package com.hq.bean;

import com.hq.db.annotation.Column;
import com.hq.db.annotation.Table;

/**
 * @author zth
 * @Date 2019-04-20 10:24
 */

public class Admin {
    private static final long serialVersionUID = 1L;
    private int id;
    private String email;
    private String upwd;
    private String upur;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public String getUpur() {
        return upur;
    }

    public void setUpur(String upur) {
        this.upur = upur;
    }

    @Override
    public String toString() {
        return "Admin{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", upwd='" + upwd + '\'' +
                ", upur='" + upur + '\'' +
                '}';
    }
}
