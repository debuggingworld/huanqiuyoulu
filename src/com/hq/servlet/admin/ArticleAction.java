package com.hq.servlet.admin;

import com.hq.bean.Article;
import com.hq.bean.Channel;
import com.hq.bean.City;
import com.hq.db.DB;
import com.hq.db.PageDiv;
import com.hq.servlet.core.Action;
import com.hq.utils.HtmlGenerator;
import org.apache.commons.dbutils.handlers.ArrayHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-19 21:09
 */
@WebServlet("/admin/article")
public class ArticleAction extends Action {
    private Logger log = Logger.getLogger(ArticleAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        PageDiv<Article> pageDiv = null;

        int pageNo = 1;
        if (mapping.getInt("pageNo")>0){
            pageNo = mapping.getInt("pageNo");
        }

        int pageSize = 10;

        try{
            // 列出所有栏目
            List<Channel> channels = DB.getAll(Channel.class,"select * from channel order by level");
            mapping.setAttr("channels",channels);

            // 检查是不是搜索结果
            String keyword = mapping.getString("keyword");
            System.out.println(keyword);
            if (keyword.length() > 0){
                String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c where a.channel_id = c.id and a.city_id = t.id and a.title like ? order by level asc ,id desc limit ? ,?";
                List<Article> articles = DB.query(sql,new BeanListHandler<Article>(Article.class),"%"+keyword+"%",(pageNo-1)*pageSize,pageSize);
                long total = (long)DB.query("select count(id) from article where title like ?",new ArrayHandler(),"%"+keyword+"%")[0];

                pageDiv = new PageDiv<>(pageNo,pageSize,total,articles);
                mapping.setAttr("keyword",keyword);
            }else {
                int channelID = mapping.getInt("channel_id");
                if (channelID > 0){
                    String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c where a.channel_id = c.id and a.city_id = t.id and a.channel_id =  ? order by level asc ,id desc limit ? ,?";

                    List<Article> articles = DB.query(sql,new BeanListHandler<Article>(Article.class),channelID,(pageNo-1)*pageSize,pageSize);

                    long total = (long)DB.query("select count(id) from article where channel_id = ?",new ArrayHandler(),channelID)[0];
                    pageDiv = new PageDiv<>(pageNo,pageSize,total,articles);
                    mapping.setAttr("channel_id",channelID);
                }else {
                    String sql = "select a.* ,t.name as cityName,c.name as channelName from article a,city t ,channel c where a.channel_id = c.id and a.city_id = t.id order by level asc ,id desc limit ? ,?";

                    List<Article> articles = DB.query(sql,new BeanListHandler<Article>(Article.class),(pageNo-1)*pageSize,pageSize);

                    long total = (long)DB.query("select count(id) from article ",new ArrayHandler())[0];
                    pageDiv = new PageDiv<>(pageNo,pageSize,total,articles);
                    mapping.setAttr("channel_id",channelID);
                }
            }
            mapping.setAttr("pageDiv",pageDiv);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.ArticleAction_查询文章出错"+e.getMessage());
        }
        mapping.forward("admin/article_list.jsp");
    }

    public void toAdd(Mapping mapping) throws ServletException, IOException {
        try {
            List<City> countrys = DB.getAll(City.class, "select * from city where display = 1 and  parent_id = 0 order by level ");
            mapping.setAttr("countrys", countrys);

            List<Channel> channels = DB.getAll(Channel.class, "select * from channel order by level ");
            mapping.setAttr("channels", channels);

        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.ArticleAction_index_出错"+e.getMessage());
        }
        mapping.forward("admin/article_add.jsp");
    }

    /**
     * 添加资讯
     */
    public void saveAdd(Mapping mapping) throws ServletException, IOException {
        Article article = new Article();

        mapping.getBean(article);
        article.setCtime(new Date());
        article.setVisits(0);

        try {
            long id = DB.add(article);
            pub(id,article.getChannel_id(),mapping);
            mapping.setAttr("msg","添加成功");
        } catch (SQLException e) {
            mapping.setAttr("err","添加失败");
            log.error("com.hq.servlet.admin.ArticleAction_添加资讯出错"+e.getMessage());
        }
        this.index(mapping);
    }

    /**
     * 跳转到修改页面
     */
    public void edit(Mapping mapping) throws ServletException, IOException{

        try{
            long id = mapping.getLong("id");
            if (id>0){

                List<City> countrys = DB.getAll(City.class, "select * from city where display = 1 and  parent_id = 0 order by level ");
                mapping.setAttr("countrys", countrys);

                List<Channel> channels = DB.getAll(Channel.class, "select * from channel order by level ");
                mapping.setAttr("channels", channels);

                Article article = DB.get(id,Article.class);
                mapping.setAttr("article",article);
                mapping.setAttr("basePath",mapping.basePath());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("admin/article_edit.jsp");
    }

    /**
     * 保存修改
     */
    public void saveEdit(Mapping mapping) throws ServletException, IOException{
        Article article = null;
        long id = mapping.getLong("id");

        try {
            if (id >0){
                article = DB.get(id,Article.class);

                mapping.getBean(article);
                DB.update(article);
                pub(id,article.getChannel_id(),mapping);
            }
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            mapping.setAttr("err","修改失败");
            log.error("com.hq.servlet.admin.ArticleAction_修改资讯出错"+e.getMessage());
        }
        index(mapping);
    }

    /**
     * 显示文章
     */
    public void show(Mapping mapping) throws ServletException, IOException{

        long id = mapping.getLong("id");
         try {
             if (id >0){
                 String sql="select a.*,c.name as channelName,t.name as cityName from article a,channel c,city t where a.channel_id=c.id and a.city_id=t.id and a.id=?";
                 Article article=DB.query(sql, new BeanHandler<Article>(Article.class),id);
                 mapping.setAttr("article", article);
             }
         } catch (SQLException e) {
             e.printStackTrace();
         }

         mapping.forward("admin/article_show.jsp");
    }

    /**
     * 删除资讯
     */
    public void del(Mapping mapping) throws ServletException, IOException{

        Article article = null;
        long id = mapping.getLong("id");

        try {
            if (id > 0){
                article = DB.get(id,Article.class);

                if (null != article && null != article.getPic() && -1 != article.getPic().indexOf("ups")){
                    // 删除主图
                    int index = article.getPic().lastIndexOf("ups");
                    File file = new File(this.getServletContext().getRealPath(article.getPic().substring(index)));

                    System.out.println(file.toString());
                    if (file.exists()){
                        file.delete();
                    }
                }
                DB.delete(id,Article.class);
            }
            mapping.setAttr("msg","删除成功");
        } catch (SQLException e) {
            mapping.setAttr("err","删除失败");
            e.printStackTrace();
        }
        mapping.setAttr("channel_id",mapping.getInt("channel_id"));
        index(mapping);
    }


    /**
     * 发布文章
     */
    public void pub(long id ,int channelID,Mapping mapping ) throws ServletException, IOException{
        if (id > 0){
            String basePath = mapping.basePath()+"news?action=show&id="+id;
            String realPath = this.getServletContext().getRealPath("web/art_"+channelID);

            File file = new File(realPath);
            if (!file.exists()){
                file.mkdirs();
            }
            HtmlGenerator.creatHtmlPage(basePath,realPath+"/news_"+channelID+"_"+id+".html");
        }
    }

    public void createTtml(Mapping mapping) throws ServletException, IOException{
        long id = mapping.getLong("id");
        int channelID = mapping.getInt("channel_id");
        if (id>0 && channelID>0){
            pub(id,channelID,mapping);
            mapping.setAttr("msg","发布成功");
        }
        mapping.setAttr("channel_id",mapping.getInt("channel_id"));
        index(mapping);
    }



}
