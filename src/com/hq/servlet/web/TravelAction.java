package com.hq.servlet.web;

import com.hq.bean.City;
import com.hq.bean.Travel;
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
 * @Date 2019-05-28 11:14
 */
@WebServlet("/travel")
public class TravelAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {


        try {
            List<City> countrys = DB.query("select * from city  where parent_id = 0 order by level ", new BeanListHandler<City>(City.class));
            mapping.setAttr("countrys", countrys);
            int id = mapping.getInt("id");
            if (id > 0) {
                Travel travel = DB.get(id, Travel.class);
                mapping.setAttr("travel", travel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("web/travel_show.jsp");
    }
}
