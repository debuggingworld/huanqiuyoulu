package com.hq.servlet.admin;

import com.hq.bean.House;
import com.hq.bean.Video;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-29 9:24
 */
@WebServlet("/admin/voide_house")
public class VoideAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        int id = mapping.getInt("id");
        if (id > 0){
            try {
                House house = DB.get(id,House.class);
                List<Video> videos = DB.query("select * from video where house_id=? order by level", new BeanListHandler<Video>(Video.class),id);

                mapping.setAttr("house",house);
                mapping.setAttr("videos",videos);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        mapping.forward("admin/house_video_list.jsp");
    }
}
