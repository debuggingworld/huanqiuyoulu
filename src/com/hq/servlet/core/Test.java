package com.hq.servlet.core;

import com.hq.bean.Admin;
import com.hq.db.DB;
import com.hq.utils.Md5Encrypt;

import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-04-22 17:30
 */
public class Test {
    public static void main(String[] args){
        try {
            DB.getConnection();
            DB.beginTransaction();
            Admin admin = new Admin();
            admin.setUpwd(Md5Encrypt.md5("admin"));
            admin.setUpur("10000");
            admin.setEmail("123@zth.com");

            long l = DB.add(admin);
            System.out.println(l + "::添加成功");

            /*List<Admin> list =  DB.getAll(Admin.class);
            System.out.println(list.toString());*/
            DB.commitTransaction();
        } catch (SQLException e) {
            e.printStackTrace();
            DB.rollbackTransaction();
            System.out.println(" 添加失败");
        }
    }
}
