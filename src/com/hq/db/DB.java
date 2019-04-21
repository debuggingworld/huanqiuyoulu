package com.hq.db;

import com.alibaba.druid.pool.DruidDataSource;
import com.hq.db.annotation.Column;
import com.hq.db.annotation.Exclude;
import com.hq.db.annotation.Table;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.ArrayListHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

/**
 * @author zth
 * @Date 2019-04-18 20:37
 *
 * 封装操作数据库的工具类
 */


public class DB {

    private static Logger log = Logger.getLogger(DB.class);
    private static QueryRunner run = new QueryRunner();
    private static DruidDataSource ds = null;

    // 只放进行事务的 Connection
    private static ThreadLocal<Connection> conn = new ThreadLocal<>();

    static {
        // 初始化连接池
        try{
            ResourceBundle res = ResourceBundle.getBundle("jdbc");
            ds = new DruidDataSource();
            ds.setUrl(res.getString("url"));
            ds.setDriverClassName(res.getString("driverClassName"));
            ds.setUsername(res.getString("username"));
            ds.setPassword(res.getString("password"));
            ds.setFilters(res.getString("filters"));
            ds.setMaxActive(Integer.parseInt(res.getString("maxActive")));
            ds.setInitialSize(Integer.parseInt(res.getString("initialSize")));
            ds.setMaxWait(Integer.parseInt(res.getString("maxWait")));
            ds.setMinIdle(Integer.parseInt(res.getString("minIdle")));
            //ds.setMaxIdle(Integer.parseInt(res.getString("maxIdle")));
            ds.setValidationQuery(res.getString("validationQuery"));
            ds.setTestWhileIdle(Boolean.parseBoolean(res.getString("testWhileIdle")));
            ds.setTestOnBorrow(Boolean.parseBoolean(res.getString("testOnBorrow")));
            ds.setTestOnReturn(Boolean.parseBoolean(res.getString("testOnReturn")));
            ds.setTimeBetweenEvictionRunsMillis(Long.parseLong(res.getString("timeBetweenEvictionRunsMillis")));
            ds.setMinEvictableIdleTimeMillis(Long.parseLong(res.getString("minEvictableIdleTimeMillis")));
            //ds.setValidationQuery(res.getString("validationQuery"));

        } catch (SQLException e) {
            log.error("ERROR_001_com.hq.db.Db_初始化连接池失败_line52"+e.getMessage());
        }
    }

    /**
     *  通过 DruidDataSource 得到 Connection
     * @return Connection 对象
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        // 得到 ThreadLocal 中的 Connection
        Connection con = conn.get();
        //如果开启了事务，则con不为空，应该直接返回con
        if (null == con || con.isClosed()){
            con = ds.getConnection();
            conn.set(con);
        }
        return con;
    }

    // ---------------------------对事物操作的封装-------------------------------------

    /**
     * 开启事务
     * @throws SQLException
     */
    public static void beginTransaction() throws SQLException{
        //得到ThreadLocal中的connection
        Connection con = conn.get();
        //设置事务提交为手动
        con.setAutoCommit(false);
        //把当前开启的事务放入ThreadLocal中
        conn.set(con);
    }

    /**
     * 提交事务
     * @throws SQLException
     */
    public static void commitTransaction() throws SQLException {
        //得到ThreadLocal中的connection
        Connection con = conn.get();
        //判断con是否为空，如果为空，则说明没有开启事务
        if (con == null){
            throw new SQLException("没有开启事务,不能提交事务");
        }
        // 如果 con 不为空,提交事务
        con.commit();
        // 事务提交后，关闭连接
        con.close();
        // ThreadLocal中移出连接
        conn.remove();
    }

    /**
     *  回滚事务
     */
    public static void rollbackTransaction(){
        try {
            //得到 ThreadLocal 中的 connection
            Connection con = conn.get();
            // 判断con是否为空，如果为空，则说明没有开启事务，不能回滚事务
            if (con == null){
                throw new SQLException("没有开启事务,不能回滚事务");
            }
            // 事务回滚
            con.rollback();
            // 关闭连接
            con.close();
            // 将连接移除 ThreadLocal
            conn.remove();
        }catch (SQLException e){
            log.error("ERROR_002_com.hq.db_回滚事务失败_line124..."+e.getMessage());
        }
    }

    /**
     * 关闭事务
     * @param connection
     * @throws SQLException
     */
    public static void releaseConnection(Connection connection) throws SQLException {
        //得到ThreadLocal中的connection
        Connection con = conn.get();
        //如果参数连接与当前事务连接不相等，则说明参数连接不是事务连接，可以关闭，否则交由事务关闭
        if (connection != null && con != connection){
            //如果连接没有被关闭，关闭之
            if (!connection.isClosed()){
                connection.close();
            }
        }
    }

    /**
     * 关闭 DruidDataSource
     */
    public static void closeDataSource(){
        if (null!=ds){
            ds.close();
        }
    }

    // -----------------------重写 QueryRunner 中的方法--------------------------
    public static int[] batch(String sql,Object[][] params) throws SQLException {
        Connection con = getConnection();
        int[] result = run.batch(sql,params);
        releaseConnection(con);
        return result;
    }

    public static <T> T query(String sql ,ResultSetHandler<T> handler,Object... params) throws SQLException {
        Connection con = getConnection();
        T result = run.query(con,sql,handler,params);
        releaseConnection(con);
        return result;
    }

    public static <T> T query(String sql, ResultSetHandler<T> handler) throws SQLException {
        Connection con = getConnection();
        T result = run.query(con,sql,handler);
        releaseConnection(con);
        return result;

    }

    public static int update(String sql,Object... params) throws SQLException{
        Connection con = getConnection();
        int result = run.update(con,sql,params);
        releaseConnection(con);
        return result;
    }

    public static int update(String sql,Object params) throws SQLException{
        Connection con = getConnection();
        int result = run.update(con,sql,params);
        releaseConnection(con);
        return result;
    }

    public static int update(String sql) throws SQLException{
        Connection con = getConnection();
        int result = run.update(con,sql);
        releaseConnection(con);
        return result;
    }

    //------------------------通用方法封装-----------------------------------------------

    /**
     * 解析表名
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> String getTableName(Class<T> clazz){
        String result = null;
        Annotation ano = clazz.getDeclaredAnnotation(Table.class);
        if (null != ano && ano instanceof Table){
            Table table = (Table)ano;
            result = table.value();
        }else {
            // 表名和类名相同，第一个字母小写
            String allName = clazz.getName();
            int lastDot = allName.lastIndexOf(".");
            result = allName.substring(lastDot+1).toLowerCase();
        }
        return result;
    }

    /**
     * 解析类成员，将成员名和值加入 map
     * @param t
     * @param <T>
     * @return
     */
    public static <T>TreeMap<String,Object> parseAllField(T t){
        TreeMap<String,Object> map = new TreeMap<>();

        Field[] fields = t.getClass().getDeclaredFields();
        if (fields != null && fields.length >0){
            for (Field field:fields) {
                String fname = field.getName();
                // 排除字段
                if ("id".equals(fname)) continue;
                if ("serialVersionUID".equals(fname)) continue;

                Annotation ano = field.getAnnotation(Exclude.class);
                if (null != ano && ano instanceof Exclude) continue;

                // 列名解析
                Annotation clm = field.getAnnotation(Column.class);
                field.setAccessible(true);

                try {
                    // 字段中值为空的话不参与数据库操作
                    if (null == field.get(t)) continue;

                    if (null != clm && clm instanceof Column){
                        map.put(((Column)clm).value(),field.get(t));
                    }else {
                        map.put(fname,field.get(t));
                    }

                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        }
        return map;
    }

    /**
     * 将Map中的值分解为值列表与（键=？）列表
     * @param flist (eg.name=?,age=?)
     * @param values 值的列表
     * @param map 待解析的 TreeMap
     */
    public static void parseFildAndQuery(StringBuilder flist, List<Object> values,TreeMap<String,Object> map){
        if (null!=map && null!= map.keySet() && map.keySet().size()>0){
            Iterator<String> iterator = map.keySet().iterator();
            while (iterator.hasNext()){
                String key = iterator.next();
                flist.append(key+"=?,");
                values.add(map.get(key));
            }
        }

        if (flist.length()>0){
            flist.delete(flist.length()-1,flist.length());
        }
    }

    /**
     *  将 map 中的数据解析到  flist,qlist ,values中
     * @param flist 字段名+"," (eg."name,age,sex")
     * @param qlist ？+","   (eg."?,?,?")
     * @param values 字段对应的值
     * @param map
     */
    public static void parseFildAndQuery(StringBuilder flist, StringBuilder qlist,List<Object> values,TreeMap<String,Object> map){
        if (null!=map && null!= map.keySet() && map.keySet().size()>0){
            Iterator<String> iterator = map.keySet().iterator();
            while (iterator.hasNext()){
                String key = iterator.next();
                flist.append(key+",");
                qlist.append("?,");
                values.add(map.get(key));
            }
        }
        if (flist.length()>0){
            flist.delete(flist.length()-1,flist.length());
            qlist.delete(qlist.length()-1,qlist.length());
        }
    }


    //-----------------------封装对对象的增删改查-------------------------------------------

    /**
     * 向数据库插入一个对象
     * @param t 待插入的对象
     * @return 最后加入对象的id,如果是-1就是没有成功
     * @throws SQLException
     */
    public static <T> long add(T t) throws SQLException {
        // 解析表名
        String tname = getTableName(t.getClass());

        TreeMap<String,Object> map = parseAllField(t);

        StringBuilder flist = new StringBuilder();
        StringBuilder qlist = new StringBuilder();
        List<Object> values = new ArrayList<>();

        parseFildAndQuery(flist,qlist,values,map);

        String sql = "insert into "+tname+"("+flist.toString()+") values ("+qlist.toString()+")";
        // 执行sql 传 t 的参数
        update(sql,values.toString());

        Object lastId = query("select LAST_INSERT_ID() from dual",new ArrayHandler())[0];
        long reLastId = -1;
        if (null != lastId && lastId instanceof Long){
            reLastId = ((Long)lastId).longValue();
        }else if (null != lastId && lastId instanceof BigInteger){
            reLastId = ((BigInteger)lastId).longValue();
        }
        return reLastId;
    }

    /**
     * 修改对象
     * @param t
     * @param <T>
     * @throws SQLException
     */
    public static<T> void update(T t) throws SQLException{
        String tname = getTableName(t.getClass());
        TreeMap<String ,Object> map = parseAllField(t);
        StringBuilder flist = new StringBuilder();
        List<Object> values = new ArrayList<>();

        // 将Map中的值分解为值列表与（键=？）列表
        parseFildAndQuery(flist,values,map);

        String sql = "update"+tname+"set"+flist.toString()+"where id =?";
        log.debug(sql);

        // 追加 id
        try {
            Field field = t.getClass().getDeclaredField("id");
            field.setAccessible(true);
            values.add(field.get(t));
            update(sql,values.toArray());
        } catch (NoSuchFieldException|IllegalAccessException e) {
            log.error("ERROR_003_com.hq.db.Db_line376_更新对象方法中出错");
        }
    }

    /**
     * 删除对象
     * @throws SQLException
     */
    public static<T> void delete(long id,Class<T> clazz) throws SQLException{
        String tname = getTableName(clazz);
        String sql = "delete form "+tname+"where id =?";
        update(sql,id);
    }

    /**
     * 查询一个对象
     * @param id
     * @param clazz
     * @param <T>
     * @return
     * @throws SQLException
     */
    public static <T> T get(long id,Class<T> clazz)throws SQLException{
        T t = null;
        String tname = getTableName(clazz);
        String sql = "select * from "+tname+"where id =?";

        t = query(sql,new BeanHandler<T>(clazz),id);
        return t;
    }

    /**
     * 查询表中所欲数据
     */
    public static <T> List<T> getAll(Class<T> clazz) throws SQLException{
        List<T> list = new ArrayList<>();
        String tname = getTableName(clazz);
        String sql = "select * from "+tname+"order by desc";
        list = query(sql,new BeanListHandler<T>(clazz));
        return list;
    }

    public static <T> List<T> getAll(Class<T> clazz,String sql) throws SQLException{
        List<T> list = new ArrayList<>();
        String tname = getTableName(clazz);
        list = query(sql,new BeanListHandler<T>(clazz));
        return list;
    }

    public static <T> List<T> getAll(Class<T> clazz,String sql,Object... params) throws SQLException{
        List<T> list = new ArrayList<>();
        String tname = getTableName(clazz);
        list = query(sql,new BeanListHandler<T>(clazz),params);
        return list;
    }



}
