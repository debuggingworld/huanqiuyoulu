package com.hq.db;


import com.alibaba.druid.pool.DruidDataSource;
import org.apache.commons.dbutils.QueryRunner;
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

    //private static Logger log = Logger.getLogger(DB.class);
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
            e.printStackTrace();
        } finally {

        }
    }

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




}
