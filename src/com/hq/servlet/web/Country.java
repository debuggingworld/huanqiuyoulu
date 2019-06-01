package com.hq.servlet.web;

import com.hq.bean.Article;
import com.hq.bean.City;
import com.hq.bean.CityPic;
import com.hq.bean.House;
import com.hq.db.DB;
import com.hq.db.PageDiv;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-31 11:52
 */
@WebServlet("/country")
public class Country extends Action {

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        int id = mapping.getInt("cityid");
        try {
            City city = DB.get(id,City.class);
            mapping.setAttr("country",city);

            List<CityPic> cityPics = DB.query(" select * from citypic where city_id = ? ",new BeanListHandler<CityPic>(CityPic.class),id);
            mapping.setAttr("cityPics",cityPics);

            List<Article> articles = DB.query(" select * from article where city_id = ? limit 4 ",new BeanListHandler<Article>(Article.class),id);
            mapping.setAttr("articles",articles);

            List<City> countrys = DB.query("select * from city  where parent_id = 0 order by level ",new BeanListHandler<City>(City.class));
            mapping.setAttr("countrys",countrys);

            PageDiv<House> pageDiv = null;
            int pageNo = 1;
            if (mapping.getInt("pageNo")>0){
                pageNo = mapping.getInt("pageNo");
            }
            int pageSize = 3;
            String sql = "select * from House where country_id = ? order by level limit ?,? ";
            List<House> houses = DB.query(sql,new BeanListHandler<House>(House.class),id,(pageNo-1)*pageSize,pageSize);

            long total = (long)DB.query("select count(id)  from House where country_id = ? ",new ArrayHandler(),id)[0];
            pageDiv = new PageDiv<>(pageNo,pageSize,total,houses);
            mapping.setAttr("pageDiv",pageDiv);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        mapping.forward("web/country.jsp");
    }
}
