package com.hq.fileUpload;


import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Map;

public interface FileUploadModule {
    /**
     * 一兆的大小
     */
    long TRILLION = 1024 * 1024;
    /**
     * 文件限制的大小
     */
    long DEFAULT_SIZE = TRILLION * 5;
    /**
     *  启用
     */
    boolean ENABLE = true;
    /**
     * 不启用
     */
    boolean DISABLE = false;
    /**
     * 设置文件上传的类型
     */
    void setFileType (String[] type);
    /**
     * 设置缓存区磁盘位置，如果文件较大，建议设置缓冲
     */
    void setCachePathString(String CachePathString);
    /**
     * 设置缓存区大小，默认为 5 M
     */
    void setCacheSize (long cacheSize);

    void setFileSize(long fileSize);

    /**
     * 得到文件类型
     */
    String getFileExt(File file);
    /**
     * 文件类型检查  当fileType为空将返回true 可通过setFileType()设置文件类型
     */
    boolean validateFileType(File file);

    /**
     * 递归的根据路径创建文件夹
     */
    boolean creatFolder(String url) throws Exception;

    /**
     * 创建文件副本
     */
    File creatCopyFile(File file);

    /**
     * 文件上传 参数urlString是具体指定的目录
     *
     * 如果该对象属性值为空 ,将不使用缓存，无文件类型限制，上传大小默认为5M，
     * 目录规则默认为没有目录递归创建,相同文件名将覆盖源文件
     * 如需改变通过设置属性来改变
     *
     * 此方法如文件上传错误或者文件类型不匹配将抛出异常
     *
     */
    void uploadFiles(HttpServletRequest request, String urlString) throws Exception;

    /**
     * 获得普通表单的值
     */
    public Map<String ,String> getFormMap();
}

