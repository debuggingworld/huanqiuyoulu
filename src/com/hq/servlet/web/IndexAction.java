package com.hq.servlet.web;

import com.hq.bean.Focuspic;
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
 * @Date 2019-05-29 15:03
 */
@WebServlet("/index")
public class IndexAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        try {
            List<Focuspic> focus = DB.query("select * from focuspic order by level limit 3",new BeanListHandler<Focuspic>(Focuspic.class));
            mapping.setAttr("focus",focus);


            List<Travel> travels = DB.query("select * from travel order by id desc limit 3",new BeanListHandler<Travel>(Travel.class));
            mapping.setAttr("travels",travels);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        mapping.forward("web/index.jsp");
    }
}













