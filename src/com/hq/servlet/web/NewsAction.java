package com.hq.servlet.web;

import com.hq.bean.Article;
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
 * @Date 2019-05-30 15:43
 */
@WebServlet("/news")
public class NewsAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

        // 资讯
        PageDiv<Article> pageDiv = null;
        int pageNo = 1;
        if (mapping.getInt("pageNo")>0){
            pageNo = mapping.getInt("pageNo");
        }
        int pageSize = 7;
        try {
            int channelID = mapping.getInt("channel_id");
            if (channelID > 0){
                String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c where a.channel_id = c.id and a.city_id = t.id and a.channel_id =  ? order by id desc ,level asc limit ? ,?";

                List<Article> articles = DB.query(sql,new BeanListHandler<Article>(Article.class),channelID,(pageNo-1)*pageSize,pageSize);

                long total = (long)DB.query("select count(id) from article where channel_id = ?",new ArrayHandler(),channelID)[0];
                pageDiv = new PageDiv<>(pageNo,pageSize,total,articles);
                mapping.setAttr("channel_id",channelID);
            }else {
                String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c where a.channel_id = c.id and a.city_id = t.id order by id desc ,level asc  limit ? ,?";

                List<Article> articles = DB.query(sql,new BeanListHandler<Article>(Article.class),(pageNo-1)*pageSize,pageSize);

                long total = (long)DB.query("select count(id) from article ",new ArrayHandler())[0];
                pageDiv = new PageDiv<>(pageNo,pageSize,total,articles);
                mapping.setAttr("channel_id",channelID);
            }

            // 热点关注
            String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c  order by  visits   limit 10";

            List<Article> hot_arts = DB.query(sql,new BeanListHandler<Article>(Article.class));
            mapping.setAttr("hot_arts",hot_arts);

            mapping.setAttr("pageDiv",pageDiv);
        } catch (SQLException e) {
            e.printStackTrace();
        }




        mapping.forward("web/news_list.jsp");
    }
}
