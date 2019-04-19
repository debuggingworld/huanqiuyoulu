package com.hq.db;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;


/**
 * @author zth
 * @Date 2019-04-19 16:57
 */
public class test {
    private static Logger log= Logger.getLogger(test.class);
    public static void main(String[] args) throws SQLException {

        log.debug("debug.........");
        log.info("info............");
        log.warn("warn.............");
        log.error("error.........");

    }
}
