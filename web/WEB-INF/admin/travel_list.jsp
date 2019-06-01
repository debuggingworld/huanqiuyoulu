<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  @author zth
  @create  2019-05-28 8:50
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>旅游管理列表</title>
</head>
<body class="">
<div style="height: 40px;"></div>
<div class="container-fluid" >
    <div class="row">
        <div class="col-sm-12">
            <div class="row">
                <a href="admin/travel?action=toAdd" class="btn btn-info" style="margin: 10px 20px;">+添加旅行</a>
            </div>
            <table class="table table-striped table-hover table-condensed table-responsive" style="font-size: 12px">
                <tr><th>ID</th><th>标题</th><th>出发时间</th><th>管理</th></tr>
                <c:forEach items="${travels}" var="travel" varStatus="vs">
                    <tr>
                        <td>${vs.count}</td>
                        <td>
                            <%--<a href="admin/travel?action=show&id=${travel.id}">${travel.title}</a>--%>
                                <a href="travel?id=${travel.id}">${travel.title}</a>
                        </td>
                        <td>${travel.depart}</td>
                        <td>
                            <a href="admin/travel?action=edit&id=${travel.id}" class="btn btn-info btn-sm">
                                <i class="fa fa-edit"></i>修改
                            </a>
                            <a href="admin/travel?action=del&id=${travel.id}" class="btn btn-danger btn-sm">
                                <i class="fa fa-close"></i>删除
                            </a>
                            <c:choose>
                                <c:when test="${travel.issue == 0}">
                                    <a href="admin/travel?action=display&id=${travel.id}&display=1" class="btn btn-primary btn-sm">
                                        <i class="fa fa-lock"></i>禁用
                                    </a>
                                </c:when>
                                <c:when test="${travel.issue == 1}">
                                    <a href="admin/travel?action=display&id=${travel.id}&display=0" class="btn btn-success btn-sm">
                                        <i class="fa fa-unlock"></i>启用
                                    </a>
                                </c:when>
                            </c:choose>
                            <a href="admin/travel?action=pub&id=${travel.id}" class="btn btn-success btn-sm">
                                发布
                            </a>


                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
</body>
</html>
