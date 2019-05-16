<%--
  @author zth
  @create  2019-05-15 15:56
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>楼盘管理</title>
    <%@include file="header.jsp"%>
    <style type="text/css">
        #treemenu ul{list-style: none}
    </style>
</head>
<body>
<div style="height: 40px;"></div>
<div class="container-fluid">
    <div class="row">
        <%--左侧--%>
        <div class="col-sm-2">
            <div class="treemenu">
                <ul>
                    <div class="ibox float-e-margins">
                        <div class="file-manager"  style="padding: 20px">
                            <ul class="folder-list" style="padding: 0px">
                                <li>
                                    <a href="admin/house"><i class="fa fa-folder">&nbsp;&nbsp;&nbsp;所有</i> </a>
                                </li>
                                <c:forEach items="${countrys}" var="count">
                                    <li class="parent_menu">
                                        <a href="admin/house?cid=${count.id}">
                                            <span class="fa fa-folder-open"></span>
                                            ${count.name}
                                        </a>
                                    </li>
                                </c:forEach>
                                <div class="clearfix"></div>
                            </ul>
                        </div>
                    </div>
                </ul>
            </div>
        </div>

        <%--右侧--%>
        <div class="col-sm-10" style="border-left: 1px #ccc solid ;">
            <div class="row">
                <c:if test="${not empty country}">
                    <span style="font-size:20px; font-weight: bold; ">&nbsp;&nbsp;${country.name }</span>
                </c:if>
                <a href="admin/house?action=toadd" class="btn btn-info" style="margin: 10px 20px">
                    +添加楼盘项目
                </a>
            </div>

            <table class="table table-hover table-striped table-condensed table-responsive">
                <tr><th>ID</th><th>楼盘</th><th>时间</th><th>管理</th></tr>
            </table>
        </div>
    </div>
</div>

<%@include file="booter.jsp"%>
</body>
</html>
