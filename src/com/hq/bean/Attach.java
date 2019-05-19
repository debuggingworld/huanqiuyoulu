package com.hq.bean;

import java.io.Serializable;
import java.util.Date;

public class Attach implements Serializable {
    private long	id;
    private String	oldname;
    private String	newpath;
    private Date createtime;
    private String	author;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getOldname() {
        return oldname;
    }

    public void setOldname(String oldname) {
        this.oldname = oldname;
    }

    public String getNewpath() {
        return newpath;
    }

    public void setNewpath(String newpath) {
        this.newpath = newpath;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
