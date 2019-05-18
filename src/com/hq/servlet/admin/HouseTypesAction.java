package com.hq.servlet.admin;

import com.hq.bean.House;
import com.hq.bean.Huxing;
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
 * @Date 2019-05-18 12:10
 */
@WebServlet("/admin/type_house")
public class HouseTypesAction extends Action {
    private Logger log = Logger.getLogger(HouseTypesAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

        long id = 0;

        if (mapping.getLong("id") > 0){
            id = mapping.getLong("id");
        }

        if (null != mapping.getAttr("id")){
            id = (Long)mapping.getAttr("id");
        }

        try {
            if (id >0){
                House house = DB.get(id,House.class);
                String sql = "select * from huxing where  house_id = ? order by level";
                List<Huxing> huxings = DB.getAll(Huxing.class,sql,id);

                mapping.setAttr("huxings",huxings);
                mapping.setAttr("house",house);
            }
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.HouseTypesAction_index_查询户型出错"+e.getMessage());
        }
        mapping.forward("admin/house_type_list.jsp");
    }
}
