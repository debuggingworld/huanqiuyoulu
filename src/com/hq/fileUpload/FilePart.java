package com.hq.fileUpload;

/**
 * @author zth
 * @Date 2019-05-04 22:50
 */
public class FilePart {
    private int result; // 0：成功 1：文件过大 2：类型不允许
    private String newName;
    private String mime;
    private String filedName;   // 表单名
    private String fileName;    // 原文件名
    private long fileSize;

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    public String getNewName() {
        return newName;
    }

    public void setNewName(String newName) {
        this.newName = newName;
    }

    public String getMime() {
        return mime;
    }

    public void setMime(String mime) {
        this.mime = mime;
    }

    public String getFiledName() {
        return filedName;
    }

    public void setFiledName(String filedName) {
        this.filedName = filedName;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }
}
