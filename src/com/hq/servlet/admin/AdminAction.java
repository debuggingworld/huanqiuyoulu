package com.hq.servlet.admin;

import com.hq.bean.Admin;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import com.hq.utils.Md5Encrypt;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-08 20:05
 */
@WebServlet("/admin/admin")
public class AdminAction extends Action {
    private  static Logger log = Logger.getLogger(AdminAction.class);

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        try {
            List<Admin> list = DB.query("select * from admin",new BeanListHandler<Admin>(Admin.class));
            mapping.setAttr("list",list);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.AdminAction_Error_查询管理员出错"+e.getMessage());
        }

        mapping.forward("admin/admin_manager.jsp");
    }

    public void saveAdd(Mapping mapping) throws ServletException, IOException{
        Admin admin = new Admin();
        mapping.getBean(admin);

        try {
            DB.add(admin);
            mapping.setAttr("msg","增加成功");
        } catch (SQLException e) {
            mapping.setAttr("err","增加失败");
            log.error("com.hq.servlet.admin.AdminAction_Error_增加管理员失败"+e.getMessage());
        }
        this.index(mapping);
    }

    public void update(Mapping mapping) throws ServletException, IOException{
        Admin admin = new Admin();
        mapping.getBean(admin);

        String newpwd = mapping.getString("newpwd");
        if (null != newpwd || !"".equals(newpwd)){
            admin.setUpwd(Md5Encrypt.md5(newpwd));
        }
        try {
            DB.update(admin);
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            mapping.setAttr("err","修改失败");
            log.error("com.hq.servlet.admin.AdminAction_Error_修改管理员失败"+e.getMessage());
        }
        this.index(mapping);
    }

    public void del(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");

        if (id>0){
            try {
                DB.delete(id,Admin.class);
                mapping.setAttr("msg","删除成功");
            } catch (SQLException e) {
                mapping.setAttr("err","删除失败");
                log.error("com.hq.servlet.admin.AdminAction_Error_删除管理员失败"+e.getMessage());
            }
        }
        this.index(mapping);
    }

}
