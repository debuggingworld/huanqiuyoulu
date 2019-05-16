<%@ page import="com.hq.db.PageDiv" %>
<%@ page import="com.hq.bean.House" %><%--
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
                <c:forEach items="${ pageDiv.getList()}" var="house" varStatus="i">
                    <tr>
                        <td>${i.count}</td>
                        <td>${house.name}</td>
                        <td>
                            <a href="admin/house?action=edit$id=${house.id}" class="btn btn-info btn-sm">
                                <i class="fa fa-edit">基本</i>
                            </a>
                            <a href="admin/pic_house?id=${house.id}" class="btn btn-primary btn-sm">
                                <li class="fa fa-image">相册</li>
                            </a>
                            <a href="admin/type_house?id=${house.id}" class="btn btn-success btn-sm">
                                <li class="fa fa-bank">户型</li>
                            </a>
                            <a href="admin/voide_house/index?id=${house.id}" class="btn btn-info btn-sm">
                                <li class="fa fa-file-movie-o">视频</li>
                            </a>
                            <a href="admin/house/pub?id=${house.id}" class="btn btn-warning btn-sm">
                                <li class="fa fa-newspaper-o">发布</li>
                            </a>
                            <c:choose>
                                <c:when test="${house.isdel == 0}">
                                    <a href="admin/house/isdel?id=${house.id}&cid=${house.country_id}&vv=1" class="btn btn-danger btn-sm">
                                        <i class="fa fa-close">禁用</i>
                                    </a>
                                </c:when>
                                <c:when test="${house.isdel == 1}">
                                    <a href="admin/house/isdel?id=${house.id}&cid=${house.country_id}&vv=0" class="btn btn-success btn-sm">
                                        <i class="fa fa-check">启用</i>
                                    </a>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <div class="row">
                <div class="col-sm-8">
                    <div class="text-center">
                        <div class="btn-group">
                            <%
                                PageDiv<House> pageDiv = (PageDiv<House>)request.getAttribute("pageDiv");
                            %>
                            <a href="admin/house/index?cid=${cid}&pageNo=<%=((pageDiv.getPageNO()-1)>1?(pageDiv.getPageNO()-1):1)%>" class="btn btn-white">
                                <i class="fa  fa-chevron-left"></i>
                            </a>
                            <%
                                for (int i = pageDiv.getStart(); i <=pageDiv.getEnd() ; i++) {
                                    %>
                            <a href="admin/house/index?cid=${cid}&pageNo=<%=i%>"><%=i%></a>
                            <%
                                }
                            %>
                            <a href="admin/house/index?cid=${cid}&pageNo=<%=((pageDiv.getPageNO()+1)<pageDiv.getTotalPage()?(pageDiv.getPageNO()+1):(pageDiv.getTotalPage()))%>" class="btn btn-white">
                                <i class="fa  fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <%----%>
                <div class="col-sm-4">
                    <h4>当前第${pageDiv.getPageNO()}页 &nbsp;&nbsp;总共${pageDiv.getTotalCount()}条</h4>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="booter.jsp"%>
</body>
</html>
