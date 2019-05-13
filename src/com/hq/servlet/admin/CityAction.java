package com.hq.servlet.admin;

import com.hq.bean.City;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
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
            List<City> cities = DB.getAll(City.class);
            mapping.setAttr("cities",cities);
        } catch (SQLException e) {
            log.error("查询国家出错"+e.getMessage());
        }
        mapping.forward("admin/city_add.jsp");
    }
}
