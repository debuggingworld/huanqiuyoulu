package com.hq.db;

import com.alibaba.druid.pool.DruidDataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

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

    public static <T> T qurey(String sql ,ResultSetHandler<T> handler,Object... params) throws SQLException {
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



}
