package com.hq.servlet.admin;

import com.hq.servlet.core.Action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-05 21:33
 */
@WebServlet("/admin/login")
public class LoginAction extends Action {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.service(req, resp);
    }

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.forward("admin/login.jsp");
    }
}
