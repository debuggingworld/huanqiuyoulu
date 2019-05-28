package com.hq.servlet.admin;

import com.hq.bean.Article;
import com.hq.bean.Travel;
import com.hq.db.DB;
import com.hq.servlet.core.Action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-28 8:28
 */
@WebServlet("/admin/travel")
public class TravelAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        List<Travel> travels  = null;

        try {
            travels = DB.getAll(Travel.class,"select *  from travel order by id desc");
            mapping.setAttr("travels",travels);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        mapping.forward("admin/travel_list.jsp");
    }

    /**
     * 跳转到添加页面
     */
    public void toAdd(Mapping mapping) throws ServletException, IOException {
        mapping.forward("admin/travel_add.jsp");
    }

    /**
     * 保存添加
     */
    public void saveAdd(Mapping mapping) throws ServletException, IOException {
        Travel travel = new Travel();
        mapping.getBean(travel);
        travel.setIssue(0);
        travel.setCtimes(new Date());

        try {
            DB.add(travel);
            mapping.setAttr("msg","增加成功!");
        } catch (SQLException e) {
            mapping.setAttr("err","添加失败!");
            e.printStackTrace();
        }
        index(mapping);
    }

    /**
     * 跳转到修改页面
     */
    public void edit(Mapping mapping) throws ServletException, IOException {
        int id = mapping.getInt("id");
        if (id >0){
            try {
                Travel travel = DB.get(id,Travel.class);
                mapping.setAttr("travel",travel);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            mapping.forward("admin/travel_edit.jsp");
        }else {
            index(mapping);
        }
    }

    /**
     * 保存修改
     */
    public void saveEdit(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");
        if (id > 0){
            try {
                Travel travel = DB.get(id,Travel.class);
                mapping.getBean(travel);
                DB.update(travel);
                mapping.setAttr("msg","修改成功");
            } catch (SQLException e) {
                mapping.setAttr("err","修改失败");
                e.printStackTrace();
            }
        }
        index(mapping);
    }

    /**
     * 删除旅行
     */
    public void del(Mapping mapping) throws ServletException, IOException{
        Travel travel = null;
        int id = mapping.getInt("id");

        if (id>0){
            try {
                travel = DB.get(id,Travel.class);

                if (null != travel && null != travel.getPic() && -1 != travel.getPic().indexOf("ups")){
                    // 删除主图
                    int index = travel.getPic().lastIndexOf("ups");
                    File file = new File(this.getServletContext().getRealPath(travel.getPic().substring(index)));

                    if (file.exists()){
                        file.delete();
                    }
                }
                DB.delete(id, Travel.class);
                mapping.setAttr("msg","删除成功");
            } catch (SQLException e) {
                mapping.setAttr("err","删除失败");
                e.printStackTrace();
            }
        }
        index(mapping);
    }

    /**
     * 修改禁用/启用
     */
    public void display(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");
        int display = mapping.getInt("display");

        if (id >0){
            String sql = "update travel set issue = ? where id = ?";
            try {
                DB.update(sql,display,id);
                if (display == 1){
                    mapping.setAttr("msg","禁用成功");
                }
                if (display == 0){
                    mapping.setAttr("msg","启用成功");
                }
            } catch (SQLException e) {
                mapping.setAttr("err","禁用/启用失败");
                e.printStackTrace();
            }
        }
        index(mapping);
    }

    /**
     * 显示旅游详情
     */
    public void show(Mapping mapping) throws ServletException, IOException {
        int id = mapping.getInt("id");

        try {
            Travel travel = DB.get(id, Travel.class);
            mapping.setAttr("travel", travel);
        } catch (SQLException e) {
            e.printStackTrace();
            mapping.forward("admin/travel_show.jsp");
        }
    }


}














