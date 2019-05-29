package com.hq.servlet.admin;

import com.hq.servlet.core.Action;
import com.hq.utils.HtmlGenerator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-29 9:05
 */
@WebServlet("/admin/createIndex")
public class CreateIndexAction extends Action {

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        String basePath = mapping.basePath()+"index";

        String index =  this.getServletContext().getRealPath("index.html");
        HtmlGenerator.creatHtmlPage(basePath,index);
        mapping.setAttr("msg","生成成功");
        mapping.forward("admin/welcome.jsp");
    }
}
