package com.hq.servlet.core;

import com.alibaba.fastjson.JSON;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author zth
 * @Date 2019-04-21 19:37
 */
public abstract class Action extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        req.setCharacterEncoding("utf-8");
        // 防止浏览器缓存
        resp.setHeader("Pragma", "No-cache");
        resp.setHeader("Cache-Control", "no-cache");
        resp.setDateHeader("Expires", 0);

        String method = null!= req.getParameter("action")?req.getParameter("action"):"index";

        Class<? extends Action> clazz = this.getClass();

        // 访问一个带 Mapping 参数的方法

        try {
            Method meth = clazz.getDeclaredMethod(method,Mapping.class);
            if (null != meth){
                meth.invoke(this,new Mapping(req,resp));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ERROR_1000_找不到目标方法！" + e.getMessage());

            req.getRequestDispatcher("error/error404.jsp").forward(req,resp);
        }

    }

    // 默认要实现的方法
    public abstract void index(Mapping mapping) throws ServletException,IOException;

    /**
     * 封装内部类，因为成员内部类在多线程可能会出现问题
     */
    public class Mapping {

        private HttpServletRequest req;

        private HttpServletResponse resp;

        public Mapping(HttpServletRequest req, HttpServletResponse resp) {
            this.req = req;
            this.resp = resp;
        }

        protected SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        // 获取字符串
        public String getString(String param){
            return null!= req.getParameter(param)?req.getParameter(param):"";
        }

        // 获取字符数组
        public String[] getStringArray(String param){
            return req.getParameterValues(param);
        }

        // 获取数字
        public int getInt(String param){
            int re = 0;
            String str = this.getString(param);
            if (str.matches("\\d+")){
                re = Integer.parseInt(str);
            }
            return re;
        }

        public Long getLong (String param){
            long re = 0;
            String str = this.getString(param);
            if (str.matches("\\d+")){
                re = Long.parseLong(str);
            }
            return re;
        }

        // 填充请求参数到 Bean 对象
        public void getBean(Object bean){
            Class<? extends Object> clazz = bean.getClass();

            Field[] fields = clazz.getDeclaredFields();
            if (null!=fields && fields.length>0){

                try {
                    for (Field field:fields) {
                        field.setAccessible(true);
                        String fname = field.getName();
                        Class<?> type = field.getType();

                        String paramv = this.getString(fname);

                        if (type == String.class){
                            field.set(bean,paramv);
                        }else if (type == Integer.class || type == int.class || type == Integer.TYPE){
                            field.set(bean,this.getInt(fname));
                        }else if (type == Long.class || type == long.class || type == Long.TYPE){
                            field.set(bean,this.getInt(fname));
                        }else if (type == Date.class){
                            if (paramv.matches("\\d{4}[-]\\d{2}[-]\\d{2}[ ]\\d{2}[:]\\d{2}[:]\\d{2}")){
                                field.set(bean,simpleDateFormat.parse(paramv));
                            }
                        }
                    }
                }catch (Exception e){
                    System.out.println("ERROR_002_填充对象值出错");
                }
            }
        }

        // 对 request  的访问
        public Object getAttr(String key){
            return req.getAttribute(key);
        }

        public void setAttr(String key,Object value){
            req.setAttribute(key,value);
        }

        public void forward(String path) throws ServletException, IOException {
            req.getRequestDispatcher("/WEB-INF/"+path).forward(req,resp);
        }

        public void redirect(String path) throws IOException {
            resp.sendRedirect(path);
        }

        // 直接输出值
        public void randerText(String msg) throws IOException {
            resp.setContentType("text/html;charset=utf-8");

            PrintWriter out = resp.getWriter();
            out.println(msg);
            out.close();
        }

        // 输出 json
        public void randerJson(Object object) throws IOException {
            resp.setContentType("text/html;charset=utf-8");

            PrintWriter out = resp.getWriter();
            out.println(JSON.toJSONString(object));
            out.close();
        }

        // 从 session 中获取值
        public Object getSessionAttr(String param){
            return req.getSession().getAttribute(param);
        }
        // 设置 session 值
        public void setSessionAttr(String key,Object val){
            req.getSession().setAttribute(key,val);
        }

        // 删除 session 中的值
        public void removeSessionAttr(String key){
            req.removeAttribute(key);
        }

        // 销毁 session
        public void invalidateSession(){
            req.getSession().invalidate();
        }

        public String basePath(){
            return req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
        }

        public HttpServletRequest getReq() {
            return req;
        }

        public void setReq(HttpServletRequest req) {
            this.req = req;
        }

        public HttpServletResponse getResp() {
            return resp;
        }

        public void setResp(HttpServletResponse resp) {
            this.resp = resp;
        }

    }
}
