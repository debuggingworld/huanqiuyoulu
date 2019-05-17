package com.hq.servlet.admin;

import com.hq.bean.House;
import com.hq.bean.Pictures;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
        if (mapping.getLong("id") > 0) {
            id = mapping.getLong("id");
        }
        if (mapping.getInt("channel")>0){
            channel = mapping.getInt("channel");
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
}














