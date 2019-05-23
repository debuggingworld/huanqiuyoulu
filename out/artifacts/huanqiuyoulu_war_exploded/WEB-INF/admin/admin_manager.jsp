<%@ page import="java.util.List" %>
<%@ page import="com.hq.bean.Admin" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>管理员管理</title>
    <style>
        td{
            border: 0px solid transparent !important;
        }
        th{
            border: 0px solid transparent !important;
        }
    </style>
</head>
<body class="gray-bg">

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>管理员管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-12 text-center">

                            <form action="admin/admin" method="post" class="form-inline">
                                <input type="hidden" name="action" value="saveAdd">
                                <div class="form-group">
                                    <input type="email" name="email" class="form-control" placeholder="请输入邮箱" required>
                                </div>
                                <div class="form-group">
                                    <input type="password" name="upwd" class="form-control" placeholder="请输入密码" required>
                                </div>

                                <div class="form-group">
                                    <select name="upur" class="form-control">
                                        <option value="100000">管理员</option>
                                        <option value="010000">普通管理员</option>
                                        <option value="001000">一般</option>
                                    </select>
                                </div>
                                <div class="form-control" style="padding: 0px">
                                    <button type="submit" class=" btn btn-info">增加</button>
                                </div>
                                <div class="form-control" style="padding: 0px">

                                    <a href="admin/printExcel?action=admin" style="margin: 0px; width: auto" class="btn btn-success ">
                                        <i class="fa fa-print"></i>
                                        导出所有管理员</a>
                                </div>
                            </form>

                            <div style="height: 40px"></div>

                            <table class="table table-hover table-striped" style="word-break:break-all; font-size: 12px;">
                                <tr><th>id</th><th>用户名</th><th>密码</th><th>级别</th><th>管理</th></tr>
                                <%
                                    int index= 1;
                                    List<Admin> list = (List<Admin>)request.getAttribute("list");
                                    for (Admin admin:list) {
                                %>
                                <form method="post" action="admin/admin">
                                    <input type="hidden" name="action" value="update">
                                    <tr>
                                        <td>
                                            <%=index++%>
                                        </td>
                                        <td>
                                            <input type="hidden" name="id" value="<%=admin.getId()%>">
                                            <input type="hidden" name="email" value="<%=admin.getEmail()%>">
                                            <%=admin.getEmail()%>
                                        </td>
                                        <td>
                                            <input type="hidden" name="upwd" value="<%=admin.getUpwd()%>">
                                            <input type="text" name="newpwd" class="form-control" placeholder="请输入新密码">
                                        </td>
                                        <td>
                                            <select class="form-control" name="upur">
                                                <option value="100000" <%=admin.getUpur().startsWith("100")? "selected":""%>>管理员</option>
                                                <option value="010000" <%=admin.getUpur().startsWith("010")? "selected":""%> >普通管理员</option>
                                                <option value="001000" <%=admin.getUpur().startsWith("001")? "selected":""%> >一般</option>
                                            </select>
                                        </td>
                                        <td>
                                            <button type="submit" class="btn btn-info">修改</button>
                                            <a href="admin/admin?action=del&id=<%=admin.getId()%>" class="btn btn-danger">删除</a>
                                        </td>
                                    </tr>
                                </form>

                                <%
                                    }
                                %>
                            </table>

                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
</body>
</html>
