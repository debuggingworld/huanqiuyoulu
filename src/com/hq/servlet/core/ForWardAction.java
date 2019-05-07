package com.hq.servlet.core;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-07 23:39
 */
@WebServlet("/admin/forward")
public class ForWardAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.forward(mapping.getString("page"));
    }
}
