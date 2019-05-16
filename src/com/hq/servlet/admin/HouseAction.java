package com.hq.servlet.admin;

import com.hq.bean.City;
import com.hq.bean.House;
import com.hq.db.DB;
import com.hq.db.PageDiv;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-15 15:35
 */
@WebServlet("/admin/house")
public class HouseAction extends Action {
    Logger log = Logger.getLogger(HouseAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

        try{
            // 所有国家
            String sql = "select * from city where display=1 and parent_id = 0 order by level";
            List<City> countrys = DB.getAll(City.class,sql);
            mapping.setAttr("countrys",countrys);

            PageDiv<House> pageDiv = null;
            int pageSize = 15;
            int paseNo = 1;

            if (mapping.getInt("pageNo")>0){
                paseNo = mapping.getInt("pageNo");
            }

            long cid = mapping.getLong("cid");
            if(cid<1) cid=null!=(Long)mapping.getAttr("cid")?(Integer)mapping.getAttr("cid"):0;

            if (cid > 0){
                mapping.setAttr("country",DB.get(cid,City.class));
                pageDiv = DB.getByPage(House.class,"select * from house where country_id = ? order by level,id ",paseNo,pageSize,cid);
            }else {
                pageDiv = DB.getByPage(House.class,"select * from house  order by level,id ",paseNo,pageSize);

            }

            mapping.setAttr("cid",cid);
            mapping.setAttr("pageDiv",pageDiv);

        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.HouseAction_列出楼盘信息出错"+e.getMessage());
            e.printStackTrace();
        }

        mapping.forward("admin/house_list.jsp");
    }

    /**
     * 跳转到添加楼盘页面
     */
    public void toadd(Mapping mapping) throws ServletException, IOException{
        try {
            List<City> countrys = DB.getAll(City.class,"select * from city where display = 1 and parent_id = 0 order by level");
            mapping.setAttr("countrys",countrys);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.HouseAction_跳转到添加楼盘页面出错"+e.getMessage());
        }
        mapping.forward("admin/house_add.jsp");
    }
}


















