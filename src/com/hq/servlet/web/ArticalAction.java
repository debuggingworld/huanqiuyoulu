package com.hq.servlet.web;

import com.hq.bean.Article;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

/**
 * @author zth
 * @Date 2019-05-26 16:26
 */
@WebServlet("/web/article")
public class ArticalAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        long id = mapping.getLong("id");
        try {
            if (id > 0){
                String sql="select a.*,c.name as channelName,t.name as cityName from article a,channel c,city t where a.channel_id=c.id and a.city_id=t.id and a.id=?";
                Article article = DB.query(sql, new BeanHandler<Article>(Article.class),id);
                mapping.setAttr("article",article);
                mapping.setAttr("basepath",mapping.basePath());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("admin/article_show.jsp");
    }
}
