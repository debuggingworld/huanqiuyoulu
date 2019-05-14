package com.hq.servlet.admin;

import com.hq.bean.City;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanHandler;
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
            List<City> cities = DB.getAll(City.class);
            mapping.setAttr("cities",cities);
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
}
