package com.hq.servlet.admin;

import com.hq.bean.House;
import com.hq.bean.Huxing;
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
import java.util.Date;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-18 12:10
 */
@WebServlet("/admin/type_house")
public class HouseTypesAction extends Action {
    private Logger log = Logger.getLogger(HouseTypesAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

        long id = 0;

        if (mapping.getLong("id") > 0){
            id = mapping.getLong("id");
        }

        if (null != mapping.getAttr("id")){
            id = Long.parseLong(mapping.getAttr("id").toString());
        }

        try {
            if (id >0){
                House house = DB.get(id,House.class);
                String sql = "select * from huxing where  house_id = ? order by level";
                List<Huxing> huxings = DB.getAll(Huxing.class,sql,id);

                mapping.setAttr("huxings",huxings);
                mapping.setAttr("house",house);
            }
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.HouseTypesAction_index_查询户型出错"+e.getMessage());
        }
        mapping.forward("admin/house_type_list.jsp");
    }

    /**\
     * 添加户型
     */
    public void saveAdd(Mapping mapping) throws ServletException, IOException {
        String basePath = mapping.getReq().getServletContext().getRealPath("ups");
        FileUploadUtil fup = new FileUploadUtil(mapping.getReq(),1024*1024*10,new String[] {".jpg",".bmp",".gif",".png"},basePath);

        try {
            fup.uploadFile();

            if (fup.getFileParts().size() == 1 && fup.getFileParts().get(0).getResult()==0){
                FilePart part = fup.getFileParts().get(0);

                String sql = "insert into huxing ( house_id,path ,level, dis, area,ctime, price) values(?,?,?,?,?,?,?)";
                String fullPath = mapping.basePath()+"ups/"+part.getNewName();
                DB.update(sql,fup.getFormValues().get("house_id"),fullPath,fup.getFormValues().get("level"),fup.getFormValues().get("dis"),fup.getFormValues().get("area"),new Date(),fup.getFormValues().get("price"));

                mapping.setAttr("id",fup.getFormValues().get("house_id"));
                mapping.setAttr("msg","添加成功");
            }
        } catch (Exception e) {
            mapping.setAttr("err","添加失败");
            log.error("com.hq.servlet.admin.HouseTypesAction_添加户型出错"+e.getMessage());
        }
        this.index(mapping);
    }

    /**
     * 修改户型
     */
    public void update(Mapping mapping) throws ServletException, IOException{
        Huxing huxing = new Huxing();
        mapping.getBean(huxing);
        System.out.println(huxing.toString());

        try {
            DB.update("update huxing set price=?,dis=?,level=? ,area = ? where id=?", huxing.getPrice(),huxing.getDis(),huxing.getLevel(),huxing.getArea(),huxing.getId());
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            mapping.setAttr("err","修改失败");
            e.printStackTrace();
        }
        mapping.setAttr("id",mapping.getLong("house_id"));
        this.index(mapping);
    }

    /**
     * 删除户型
     */
    public void delImg(Mapping mapping) throws ServletException, IOException{

        String path = mapping.getString("path");
        long houseID = mapping.getLong("hid");
        long id = mapping.getLong("id");

        try {
            if (id >0){
                int index = path.lastIndexOf("ups");
                File file = new File(mapping.getReq().getServletContext().getRealPath(path.substring(index)));

                file.delete();
                DB.delete(id,Huxing.class);

                mapping.setAttr("id",houseID);
                mapping.setAttr("msg","删除成功");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            mapping.setAttr("err","删除失败");
        }
        index(mapping);
    }
}












