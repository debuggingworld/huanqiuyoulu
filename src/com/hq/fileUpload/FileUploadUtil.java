package com.hq.fileUpload;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author zth
 * @Date 2019-05-04 23:50
 */
public class FileUploadUtil {
    // 上传后文件在服务器上的路径
    String path = null;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    // 最大上传文件的大小
    private long maxSize = 1024*1024*10;
    // 允许的扩展名
    private String[] allowExt;
    // 上传路径的绝对值
    private String basePath;
    // 上传文件记在 fileParts 中
    private List<FilePart> fileParts = new ArrayList<>();
    // 记住表单的值
    private Map<String ,String>formValues = new HashMap<>();


    private SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");
    private Random random  = new Random();
    SimpleDateFormat formatDir = new SimpleDateFormat("yyyyMMdd");

    // 文件上传相关类
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    HttpServletRequest request;

    public FileUploadUtil(HttpServletRequest request,long maxSize, String[] allowExt, String basePath ) {
        this.maxSize = maxSize;
        this.allowExt = allowExt;
        this.basePath = basePath;
        this.request = request;
        upload.setHeaderEncoding("utf-8");
    }

    // 得到文件扩展名
    public String getFileExtName(String fname){
        String str = null;
        int index = fname.lastIndexOf(".");
        if (index!=-1){
            str = fname.toLowerCase().substring(index); // 带点
        }
        return str;
    }

    public void uploadFile() throws Exception{
        File base = new File(basePath);

        if (!upload.isMultipartContent(request)){
            throw  new Exception("没有要上传的文件");
        }

        if (!base.exists()){
            throw new Exception("上传目录不存在");
        }

        if(!(base.isDirectory()&&base.canWrite()))
        {
            throw new Exception("上传目录没有写权限");
        }

        List<FileItem> items = upload.parseRequest(request);
        Iterator<FileItem> itemIterator = items.iterator();

        while (itemIterator.hasNext()){
            FileItem item = (FileItem)itemIterator.next();
            Long fileSize = item.getSize();
            String fileName = item.getName();

            if (!item.isFormField()){
                // 文件上传
                FilePart filePart = new FilePart();
                filePart.setFiledName(item.getFieldName());
                filePart.setFileName(item.getName().toLowerCase());
                filePart.setMime(item.getContentType());
                filePart.setFileSize(item.getSize());
                /**
                 * 检查
                 */
                // 检查文件大小
                if (item.getSize() > maxSize){
                    filePart.setResult(1);
                    continue;
                }
                // 检查扩展名
                if (Arrays.toString(allowExt).indexOf(getFileExtName(item.getName()).toLowerCase()) == -1){
                    filePart.setResult(2);
                    continue;
                }

                try {
                    String ymd = formatDir.format(new Date());
                    // 创建文件夹
                    File dirFile = new File(basePath+File.separator+ymd);
                    if (!dirFile.exists()){
                        dirFile.mkdirs();
                    }

                    String newName = ymd+random.nextInt(1000)+getFileExtName(item.getName());
                    filePart.setNewName(newName);

                    File uploadedFile = new File(dirFile,newName);
                    path = uploadedFile.getAbsolutePath();
                    item.write(uploadedFile);

                }catch (Exception e){
                    e.printStackTrace();
                    throw new Exception("上传失败");
                }
                fileParts.add(filePart);
            }else {
                formValues.put(item.getFieldName(),item.getString("utf-8"));
            }
        }
    }

    public long getMaxSize() {
        return maxSize;
    }

    public void setMaxSize(long maxSize) {
        this.maxSize = maxSize;
    }

    public String[] getAllowExt() {
        return allowExt;
    }

    public void setAllowExt(String[] allowExt) {
        this.allowExt = allowExt;
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }

    public List<FilePart> getFileParts() {
        return fileParts;
    }

    public void setFileParts(List<FilePart> fileParts) {
        this.fileParts = fileParts;
    }

    public Map<String, String> getFormValues() {
        return formValues;
    }

    public void setFormValues(Map<String, String> formValues) {
        this.formValues = formValues;
    }

    public SimpleDateFormat getFormat() {
        return format;
    }

    public void setFormat(SimpleDateFormat format) {
        this.format = format;
    }

    public Random getRandom() {
        return random;
    }

    public void setRandom(Random random) {
        this.random = random;
    }

    public SimpleDateFormat getFormatDir() {
        return formatDir;
    }

    public void setFormatDir(SimpleDateFormat formatDir) {
        this.formatDir = formatDir;
    }

    public FileItemFactory getFactory() {
        return factory;
    }

    public void setFactory(FileItemFactory factory) {
        this.factory = factory;
    }

    public ServletFileUpload getUpload() {
        return upload;
    }

    public void setUpload(ServletFileUpload upload) {
        this.upload = upload;
    }

    public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }
}
