package com.hq.servlet.admin;

import com.hq.bean.House;
import com.hq.bean.Pictures;
import com.hq.db.DB;
import com.hq.fileUpload.FilePart;
import com.hq.fileUpload.FileUploadUtil;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


/**
 * @author zth
 * @Date 2019-05-17 20:58
 */
@WebServlet("/admin/pic_house")
public class HousePicAction extends Action {
    private static Logger log = Logger.getLogger(HousePicAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        long id = 0;
        int channel = 0;

        // 获取 param
        if (mapping.getLong("id") > 0) {
            id = mapping.getLong("id");
        }
        if (mapping.getInt("channel")>0){
            channel = mapping.getInt("channel");
        }

        // 获取 attr
        if (null != (Integer)mapping.getAttr("id")){
            id = (Integer)mapping.getAttr("id");
        }
        if (null != (Integer)mapping.getAttr("channel")){
            channel = (Integer)mapping.getAttr("channel");
        }

        try {
            if (id > 0){
                House house = DB.get(id,House.class);
                // 该楼盘下的所有图
                List<Pictures> pictures = null;

                if (channel > 0){
                    String sql = "select * from pictures where house_id = ? and channel = ? order by level";
                    pictures = DB.getAll(Pictures.class,sql,id,channel);
                }else {
                    String sql = "select * from pictures where house_id = ? order by level";
                    pictures = DB.getAll(Pictures.class,sql,id);
                }
                mapping.setAttr("pics",pictures);
                mapping.setAttr("house",house);
            }
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.HousePicAction_index出错_"+e.getMessage());
        }
        mapping.setAttr("channel", channel);
        mapping.forward("admin/house_pic_list.jsp");
    }

    /**
     * 上传图片
     */
    public void imgUpload(Mapping mapping) throws ServletException, IOException{
        String basePath = this.getServletContext().getRealPath("ups");

        FileUploadUtil fup = new FileUploadUtil(mapping.getReq(),1024*1024*10,new String[] {".jpg",".bmp",".gif",".png"},basePath);

        try {
            fup.uploadFile();

            if (fup.getFileParts().size() == 1 && fup.getFileParts().get(0).getResult() == 0){
                FilePart part = fup.getFileParts().get(0);

                String sql = "insert into pictures(house_id,path,level,dis,channel) value (?,?,?,?,?)";
                String fullPath = mapping.basePath()+"ups/"+part.getNewName();
                DB.update(sql,fup.getFormValues().get("house_id"),fullPath,fup.getFormValues().get("level"),fup.getFormValues().get("dis"),fup.getFormValues().get("channel"));

                mapping.setAttr("channel",Integer.parseInt(fup.getFormValues().get("channel")));
                mapping.setAttr("id",Integer.parseInt(fup.getFormValues().get("house_id")));
                mapping.setAttr("msg","上传成功");
            }

        } catch (Exception e) {
            log.error("com.hq.servlet.admin.HousePicAction_上传图片出错_"+e.getMessage());
            mapping.setAttr("err","上传失败");
        }
        this.index(mapping);
    }

    public void delImg(Mapping mapping) throws ServletException, IOException{
//        href="admin/pic_house?action=delImg&id=<%=pic.getId()%>&hid=${house.id}&path=<%=pic.getPath()
        String path = mapping.getString("path");
        int channel = mapping.getInt("channel");
        System.out.println("del==channel"+channel);
        int houseID = mapping.getInt("hid");
        long id = mapping.getLong("id");

        try {
            if (id > 0){
                int lastIndex = path.lastIndexOf("ups");
                String webPath = path.substring(lastIndex+4);
                File file = new File(mapping.getReq().getServletContext().getRealPath("ups/"+webPath));

                file.delete();
                DB.delete(id,Pictures.class);

                mapping.setAttr("channel",channel);
                mapping.setAttr("id",houseID);
                mapping.setAttr("msg","删除成功");
            }
        } catch (SQLException e) {
            mapping.setAttr("err","删除失败");
            e.printStackTrace();
        }
        this.index(mapping);
    }
}














