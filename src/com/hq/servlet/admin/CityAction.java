package com.hq.servlet.admin;

import com.hq.bean.City;
import com.hq.bean.CityPic;
import com.hq.db.DB;
import com.hq.fileUpload.FilePart;
import com.hq.fileUpload.FileUploadUtil;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-12 12:03
 */
@WebServlet("/admin/city")
public class CityAction extends Action {
    private static Logger log = Logger.getLogger(CityAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        try {
            // 所有国家
            List<City> countrys = DB.query("select * from city where display=1 and parent_id = 0 order by level ", new BeanListHandler<City>(City.class));
            mapping.setAttr("countrys",countrys);

            // 查询具体国家的城市
            int cid = mapping.getInt("cid");
            List<City> cities = null;

            if (cid > 0){
                String sql = "select * from city where display =1 and parent_id = ? order by level";

                cities = DB.query(sql,new BeanListHandler<City>(City.class),cid);
                City country = DB.query("select * from city where id = ?",new BeanHandler<City>(City.class),cid);
                mapping.setAttr("country",country);
            }else {
                // 所有城市
                String sql = "select * from city where display =1 and parent_id >0 order by level";

                cities = DB.query(sql,new BeanListHandler<City>(City.class));
            }
            mapping.setAttr("cities",cities);

        } catch (SQLException e) {
            log.error("查询国家列表出错"+e.getMessage());
        }
        mapping.forward("admin/city_list.jsp");
    }

    /**
     * 跳转到增加页面
     */
    public void toadd(Mapping mapping) throws ServletException, IOException{
        try {
            List<City> citys=DB.getAll(City.class, "select * from city where display=1 and parent_id=0 order by level");
            mapping.setAttr("cities",citys);
        } catch (SQLException e) {
            log.error("查询国家出错"+e.getMessage());
        }
        mapping.forward("admin/city_add.jsp");
    }

    public void saveadd(Mapping mapping) throws ServletException, IOException{
        City city = new City();
        mapping.getBean(city);

        try {
            DB.add(city);
            mapping.setAttr("msg","增加成功");
        } catch (SQLException e) {
            mapping.setAttr("err","增加失败");
            log.error("增加国家或城市失败"+e.getMessage());
        }
        this.index(mapping);
    }

    public void edit(Mapping mapping) throws ServletException, IOException{
        int cityID = mapping.getInt("cityid");
        if (cityID < 1){
            cityID = (Integer)mapping.getAttr("cityid");
        }

        try {
            if (cityID > 0){
                String sql= "select * from city where display = 1 and parent_id = 0 order by level";
                List<City> countrys = DB.query(sql,new BeanListHandler<City>(City.class));
                mapping.setAttr("countrys",countrys);

                City city = DB.get(cityID,City.class);
                mapping.setAttr("city",city);

                List<CityPic> cityPics = DB.query("select * from citypic where city_id=? order by level", new BeanListHandler<CityPic>(CityPic.class),cityID);
                mapping.setAttr("cityPics",cityPics);
            }
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.FileUploadAction"+e.getMessage());
        }
        mapping.forward("admin/city_edit.jsp");
    }

    public void saveedit(Mapping mapping) throws ServletException, IOException{
        City city = new City();
        mapping.getBean(city);

        try {
            DB.update(city);
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            mapping.setAttr("err","修改失败");
            log.error("com.hq.servlet.admin.CityAction_修改国家或城市失败"+e.getMessage());
        }
        this.index(mapping);
    }


    /**
     * 上传国家城市图片
     */
    public void uploadCityPic(Mapping mapping) throws ServletException, IOException{
        String basePath = this.getServletContext().getRealPath("ups");

        FileUploadUtil fup = new FileUploadUtil(mapping.getReq(),1024*1024*10,new String[] {".jpg",".bmp",".gif",".png"},basePath);

        try {
            fup.uploadFile();
            if (fup.getFileParts().size() == 1 && fup.getFileParts().get(0).getResult() == 0){
                FilePart filePart = fup.getFileParts().get(0);
                String fullPath = mapping.basePath()+"ups/"+filePart.getNewName();

                String sql = "insert into citypic (path,level,dis,city_id) value (?,?,?,?)";
                DB.update(sql,fullPath,fup.getFormValues().get("level"),fup.getFormValues().get("dis"),fup.getFormValues().get("country_id"));

                mapping.setAttr("cityid",Integer.parseInt(fup.getFormValues().get("country_id")));
                mapping.setAttr("msg","增加成功");
            }
        } catch (Exception e) {
            log.error("com.hq.servlet.admin.CityAction_上传国家城市图片失败"+e.getMessage());
            mapping.setAttr("err","增加失败");
        }
        this.edit(mapping);
    }

    /**
     * 修改国家城市图片
     */
    public void cityspicupdate(Mapping mapping) throws ServletException, IOException{
        CityPic cityPic = new CityPic();
        mapping.getBean(cityPic);

        String sql = "update citypic set level = ?,dis=? where id=?";
        try {
            DB.update(sql,cityPic.getLevel(),cityPic.getDis(),cityPic.getId());
            mapping.setAttr("cityid",cityPic.getCity_id());
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.CityAction_修改国家城市图片失败"+e.getMessage());
            mapping.setAttr("err","修改失败");
        }
        this.edit(mapping);

    }

    /**
     * 删除国家图片
     */
    public void cityspicdel(Mapping mapping) throws ServletException, IOException{
        String path = mapping.getString("path");
        int id = mapping.getInt("id");
        String basePath = this.getServletContext().getRealPath("ups");

        int index = path.lastIndexOf("ups");

        String subPath = path.substring(index+3);

        File file = new File(basePath,subPath);
        System.out.println(file.toString());
        file.delete();

        try {
            DB.update("delete from citypic where id =?",id);
            mapping.setAttr("cityid",mapping.getInt("country_id"));
            mapping.setAttr("msg","删除成功");
        } catch (SQLException e) {
            mapping.setAttr("err","删除失败");
            e.printStackTrace();
        }
        this.edit(mapping);
    }
}
