package com.hq.servlet.admin;

import com.hq.bean.Admin;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import com.hq.utils.Md5Encrypt;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.log4j.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;


/**
 * @author zth
 * @Date 2019-05-05 21:33
 */
@WebServlet("/admin/login")
public class LoginAction extends Action {

    private Logger log = Logger.getLogger(LoginAction.class);

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.forward("admin/login.jsp");
    }

    /**
     * 验证用户名和密码
     */
    public void checkLogin(Mapping mapping) throws ServletException, IOException {
        String email = mapping.getString("uname");
        String pwd = mapping.getString("upwd");
        String rand = mapping.getString("rand");

        String srand = (String)mapping.getSessionAttr("randomCode");

        if (!srand.equals(rand)){
            mapping.setAttr("err","验证码不正确");
            mapping.forward("admin/login.jsp");
        }else if (pwd.length()>0 && email.length()>0){
            String sql = "select * from admin where email=? and upwd =? limit 1 ";
            try {
                Admin admin = DB.query(sql,new BeanHandler<Admin>(Admin.class),email, Md5Encrypt.md5(pwd));

                if (null != admin){
                    mapping.setSessionAttr("loged",admin);
                    System.out.println("登录成功！！！！");
                    mapping.redirect("indexadmin");
                }else {
                    System.out.println("用户名或密码不正确！");
                    mapping.setAttr("err","用户名或密码不正确");
                    mapping.forward("admin/login.jsp");
                }
            } catch (SQLException e) {
                log.error("com.hq.servlet.admin.LoginAction_error_验证用户名密码失败"+e.getMessage());
            }
        }else {
            mapping.forward("admin/login.jsp");
        }
    }

}
