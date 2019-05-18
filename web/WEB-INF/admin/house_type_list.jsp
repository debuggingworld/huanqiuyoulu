<%--
  @author zth
  @create  2019-05-18 12:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>楼盘户型管理</title>
    <%@include file="header.jsp"%>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>楼盘户型管理
                        <small style="font-size: 12px; font-weight: bold; margin-left: 30px;">${house.name}</small>
                    </h5>
                </div>
            </div>

            <%--content--%>
            <div class="ibox-content" style="font-size:12px;">
                <div style="width: 100%">
                    <form action="/admin/type_house?action="></form>
                </div>
            </div>
        </div>
    </div>
</div>




<%@include file="booter.jsp"%>
</body>
</html>
