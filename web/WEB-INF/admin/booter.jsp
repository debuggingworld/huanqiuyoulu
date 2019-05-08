<%--
  @author zth
  @create  2019-05-06 21:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--全局 js--%>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<%--自定义 js--%>
<script src="js/content.js"></script>
<script src="js/sweetalert.min.js"></script>
<script src="js/plugins/layer/laydate/laydate.js"></script>

<%
    String msg = (String)request.getAttribute("msg");
    String err = (String)request.getAttribute("err");
    if (null!= msg){
        out.println("<script type=\"text/javascript\">swal('"+msg+"!','','success')</script>");
    }else if (null != err){
        out.println("<script type=\"text/javascript\">swal('"+err+"!','','error')</script>");
    }

%>
