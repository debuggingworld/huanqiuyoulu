package com.hq.servlet.web;

import com.hq.bean.Article;
import com.hq.bean.Successful;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

/**
 * @author zth
 * @Date 2019-05-29 21:27
 */
@WebServlet("/web/successful")
public class SuccessfulAction extends Action {

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        long id = mapping.getLong("id");
        try {
            if (id > 0){
                Successful successful = DB.get(id,Successful.class);
                mapping.setAttr("successful",successful);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("web/successful_show.jsp");
    }
}
