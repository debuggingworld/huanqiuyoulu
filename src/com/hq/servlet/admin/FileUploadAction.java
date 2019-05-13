package com.hq.servlet.admin;

import com.alibaba.fastjson.JSONObject;
import com.hq.bean.Admin;
import com.hq.db.DB;
import com.hq.fileUpload.FilePart;
import com.hq.fileUpload.FileUploadUtil;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * @author zth
 * @Date 2019-05-13 18:03
 */
@WebServlet("/admin/fileupload")
public class FileUploadAction extends Action {
    private Logger log = Logger.getLogger(FileUploadAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.getResp().setContentType("text/html;charset=utf-8");
        PrintWriter out = mapping.getResp().getWriter();
        String basePath = this.getServletContext().getRealPath("ups");

        FileUploadUtil fup = new FileUploadUtil(mapping.getReq(),1024*1024*10,new String[]{".jpg",".bmp",".gif",".png"},basePath);

        try {
            fup.uploadFile();
            for (FilePart filePart:fup.getFileParts()) {
                if (filePart.getResult() == 1){
                    out.println(getError("文件过大"));
                    return;
                }
                if (filePart.getResult() == 2){
                    out.println(getError("类型不支持"));
                    return;
                }
            }

            if (fup.getFileParts().size() == 1 && fup.getFileParts().get(0).getResult()==0){
                FilePart filePart = fup.getFileParts().get(0);
                String sql = "insert into attach (oldname,newpath,createtime,author) values (?,?,?,?)";

                Admin admin =  (Admin)mapping.getSessionAttr("loged");
                String author = (null != admin && null != admin.getEmail())? admin.getEmail():"admin";
                String fullPath = mapping.basePath()+"ups/"+filePart.getNewName();
                DB.update(sql,filePart.getFileName(),fullPath,new Date(),author);

                JSONObject obj = new JSONObject();
                obj.put("error",0);
                obj.put("url",fullPath);
                out.println(obj.toJSONString());

            }

        } catch (Exception e) {
            log.error("com.hq.servlet.admin.FileUploadAction_ERROR_文件上传失败"+e.getMessage());
        }


    }

    private String getError(String message){
        JSONObject obj = new JSONObject();
        obj.put("error",1);
        obj.put("message",message);
        return obj.toJSONString();
    }
}
