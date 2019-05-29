package com.hq.servlet.admin;

import com.hq.bean.Successful;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import com.hq.utils.HtmlGenerator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-28 16:51
 */
@WebServlet("/admin/successful")
public class SuccessfulAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        String sql  = "select * from successful order by level";
        try {
            List<Successful> successfuls = DB.getAll(Successful.class,sql);
            mapping.setAttr("successfuls",successfuls);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("admin/success_list.jsp");
    }

    /**
     * 跳转到添加页面
     */
    public void toAdd(Mapping mapping) throws ServletException, IOException {
        mapping.forward("admin/success_add.jsp");
    }

    /**
     * 保存添加
     */
    public void saveAdd(Mapping mapping) throws ServletException, IOException {
        Successful successful = new Successful();
        mapping.getBean(successful);
        try {
            long id  = DB.add(successful);
            System.out.println("id====="+id);
            pub(id,mapping);
            mapping.setAttr("msg","添加成功");
        } catch (SQLException e) {
            mapping.setAttr("err","添加失败");
            e.printStackTrace();
        }
        index(mapping);
    }

    /**
     * 跳转到修改页面
     */
    public void edit(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");
        if (id > 0){
            Successful successful = null;
            try {
                successful = DB.get(id, Successful.class);
                mapping.setAttr("successful",successful);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            mapping.forward("admin/success_edit.jsp");
        }else {
            index(mapping);
        }
    }

    public void saveEdit(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");
        if (id > 0){
            try {
                Successful successful = DB.get(id,Successful.class);
                mapping.getBean(successful);
                DB.update(successful);

                pub(successful.getId(),mapping);
                mapping.setAttr("msg","修改成功");
            } catch (SQLException e) {
                e.printStackTrace();
                mapping.setAttr("err","修改失败");
            }
        }
        index(mapping);
    }

    public void del(Mapping mapping) throws ServletException, IOException{
        Successful  successful = null;
        long id = mapping.getLong("id");

        try {
            if (id > 0){
                successful = DB.get(id,Successful.class);

                if (null != successful ){
                    // 删除主图
                    if (null != successful.getPic1() && -1 != successful.getPic1().indexOf("ups")){
                        int index = successful.getPic1().lastIndexOf("ups");
                        File file = new File(this.getServletContext().getRealPath(successful.getPic1().substring(index)));

                        if (file.exists()){
                            file.delete();
                        }
                    }
                    // 删除头像
                    if (null != successful.getPic2() && -1 != successful.getPic2().indexOf("ups")){
                        int index = successful.getPic2().lastIndexOf("ups");
                        File file = new File(this.getServletContext().getRealPath(successful.getPic2().substring(index)));

                        if (file.exists()){
                            file.delete();
                        }
                    }
                }
                DB.delete(id, Successful.class);
            }
            mapping.setAttr("msg","删除成功");
        } catch (SQLException e) {
            mapping.setAttr("err","删除失败");
            e.printStackTrace();
        }
        index(mapping);
    }

    public void show(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");

        if (id > 0){
            try {
                Successful successful = DB.get(id,Successful.class);
                mapping.setAttr("successful",successful);
            } catch (SQLException e) {
                e.printStackTrace();
                mapping.setAttr("err","查看失败");
            }
        }
        mapping.forward("web/successful_show.jsp");
    }

    public void pub(long id ,Mapping mapping) throws ServletException, IOException{
        if (id > 0){
            String basePath = mapping.basePath()+"/web/successful?id="+id;
            String realPath = this.getServletContext().getRealPath("web/successful");
            File file = new File(realPath);
            if (!file.exists()){
                file.mkdirs();
            }
            HtmlGenerator.creatHtmlPage(basePath,realPath+"/successful_"+id+".html");
            mapping.setAttr("msg","发布成功");
        }
    }

    public void createTtml(Mapping mapping) throws ServletException, IOException{
        int id  = mapping.getInt("id");
        if (id>0){
            pub(id,mapping);
            mapping.setAttr("msg","发布成功");
        }
        mapping.setAttr("channel_id",mapping.getInt("channel_id"));
        index(mapping);
    }



}
