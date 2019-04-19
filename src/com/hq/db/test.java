package com.hq.db;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

/**
 * @author zth
 * @Date 2019-04-19 16:57
 */
public class test {
    public static void main(String[] args) throws SQLException {
        for (int i = 0; i < 10; i++) {
            Connection connection = DB.getConnection();
            System.out.println(connection);
            connection.close();
        }
    }
}
