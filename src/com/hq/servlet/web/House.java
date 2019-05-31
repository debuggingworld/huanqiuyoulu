package com.hq.servlet.web;

import com.hq.bean.City;
import com.hq.bean.Huxing;
import com.hq.bean.Pictures;
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
 * @Date 2019-05-31 20:18
 */
@WebServlet("/house")
public class House extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

        try {
            int house_id = mapping.getInt("id");
            List<City> countrys = DB.query("select * from city  where parent_id = 0 order by level ",new BeanListHandler<City>(City.class));
            mapping.setAttr("countrys",countrys);

            List<Pictures> pictures = DB.query("select * from pictures where house_id = ?",new BeanListHandler<Pictures>(Pictures.class),house_id);
            mapping.setAttr("pictures",pictures);

            com.hq.bean.House house = DB.get(house_id,com.hq.bean.House.class);
            mapping.setAttr("house",house);


            List<Huxing> huxings = DB.query("select * from huxing where house_id = ? ",new BeanListHandler<Huxing>(Huxing.class),house_id);
            mapping.setAttr("huxings",huxings);


        } catch (SQLException e) {
            e.printStackTrace();
        }

        mapping.forward("web/house.jsp");
    }
}
