<%@ page import="java.util.List" %>
<%@ page import="com.hq.bean.Admin" %>
<%@ page import="com.hq.bean.Channel" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>资讯栏目管理</title>
    <style>
        th , td{
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
                    <h5>资讯栏目管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-12 text-center">

                            <form action="admin/artchannel" method="post" class="form-inline">
                                <input type="hidden" name="action" value="saveAdd">
                                <div class="form-group">
                                    <input type="text" name="name" class="form-control" placeholder="栏目名称" required>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="path" class="form-control" placeholder="栏目路径" required>
                                </div>

                                <select name="level" class="form-control">
                                    <%
                                        for (int i = 9; i >0 ; i--) {
                                    %>
                                    <option value="<%=i%>"><%=i%></option>
                                    <%
                                        }
                                    %>
                                </select>

                                <div class="form-control" style="padding: 0px">
                                    <button type="submit" class=" btn btn-info">增加</button>
                                </div>
                            </form>

                            <div style="height: 40px"></div>

                            <table class="table table-hover table-striped" style="word-break:break-all; font-size: 12px;">
                                <tr><th>#</th><th>栏目名称</th><th>栏目路径</th><th>级别</th><th>管理</th></tr>
                                <%
                                    int index= 1;
                                    List<Channel> channels = (List<Channel>)request.getAttribute("channels");
                                    for (Channel channel:channels) {
                                %>
                                <form method="post" action="admin/artchannel">
                                    <input type="hidden" name="action" value="update">
                                    <tr>
                                        <td>
                                            <%=index++%>
                                        </td>
                                        <td>
                                            <input type="hidden" name="id" value="<%=channel.getId()%>">
                                            <input type="text" class="form-control" name="name" value="<%=channel.getName()%>">
                                        </td>
                                        <td>
                                            <input type="text" name="path" class="form-control" value="<%=channel.getPath()%>">
                                        </td>
                                        <td>
                                            <select class="form-control" name="level">
                                                <%
                                                    for (int i = 9; i >0 ; i--) {
                                                    if (i == channel.getLevel()){
                                                %>
                                                <option value="<%=i%>" selected><%=i%></option>
                                                <%
                                                    }else {
                                                        %>
                                                <option value="<%=i%>" ><%=i%></option>
                                                <%
                                                    }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td>
                                            <button type="submit" class="btn btn-info">修改</button>
                                            <a href="admin/artchannel?action=del&id=<%=channel.getId()%>" class="btn btn-danger">删除</a>
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
