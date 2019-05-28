package com.hq.servlet.web;

import com.hq.bean.Travel;
import com.hq.db.DB;
import com.hq.servlet.core.Action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

/**
 * @author zth
 * @Date 2019-05-28 11:14
 */
@WebServlet("/web/travel")
public class TravelAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        int id = mapping.getInt("id");
        if (id > 0){
            try {
                Travel travel = DB.get(id,Travel.class);
                mapping.setAttr("travel",travel);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            mapping.forward("web/travel_show.jsp");
        }else {
            mapping.redirect("index");
        }
    }
}
