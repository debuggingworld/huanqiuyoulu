package com.hq.servlet.web;

import com.hq.servlet.core.Action;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-31 10:19
 */
@WebServlet("/aboutMe")
public class AboutMe extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        mapping.forward("web/aboutMe.jsp");
    }
}
