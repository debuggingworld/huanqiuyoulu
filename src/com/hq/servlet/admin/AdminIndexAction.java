package com.hq.servlet.admin;

import com.hq.servlet.core.Action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-07 19:02
 */

@WebServlet("/admin/indexAdmin")
public class AdminIndexAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.forward("admin/index.jsp");
    }
}
