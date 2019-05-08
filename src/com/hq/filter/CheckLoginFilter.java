package com.hq.filter;


import com.hq.bean.Admin;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * @author zth
 * @Date 2019-05-08 15:39
 */
@WebFilter("/admin/*")
public class CheckLoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;

        HttpSession session = request.getSession();
        Admin admin = (Admin)session.getAttribute("loged");

        String url = request.getServletPath();
        if (null != admin || (null!= url && url.indexOf("login")!= -1)){
            filterChain.doFilter(request,response);
        }else {
           response.sendRedirect("login");
        }
    }

    @Override
    public void destroy() {

    }
}
