<%--
  @author zth
  @create  2019-05-17 20:57
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>楼盘相册管理</title>
    <%@include file="header.jsp"%>
    <style type="text/css">
        .country_names{ list-style: none; padding: 0; margin: 0; }
        .country_names li{ float: left; }
        .country_names  li a{ color: #333; text-decoration: none; line-height: 30px; padding: 5px 10px;}
        .country_names  li a:hover{ text-decoration: underline;}
    </style>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">

                <div class="ibox-title">
                    <h5>楼盘相册管理
                        <small style="font-size: 12px; font-weight: bold; margin-left: 25px;">${house.name}</small>
                    </h5>
                </div>
                <div class="ibox-content" style="font-size: 12px">
                    <div style="width: 100%">
                        <ul class="country_names" style="margin-left: 0px;padding-left: 0px">
                            <li><a href="admin/pic_house?id=${house.id}&channel=0" <c:if test="${channel==0}">style="font-weight:bold;color:red;"</c:if>>全部</a></li>
                            <li><a href="admin/pic_house?id=${house.id}&channel=1" <c:if test="${channel==1}">style="font-weight:bold;color:red;"</c:if>>效果</a></li>
                            <li><a href="admin/pic_house?id=${house.id}&channel=2" <c:if test="${channel==2}">style="font-weight:bold;color:red;"</c:if>>实景</a></li>
                            <li><a href="admin/pic_house?id=${house.id}&channel=3" <c:if test="${channel==3}">style="font-weight:bold;color:red;"</c:if>>样板间</a></li>
                            <li><a href="admin/pic_house?id=${house.id}&channel=4" <c:if test="${channel==4}">style="font-weight:bold;color:red;"</c:if>>配套</a></li>
                            <li><a href="admin/pic_house?id=${house.id}&channel=5" <c:if test="${channel==5}">style="font-weight:bold;color:red;"</c:if>>活动</a></li>
                        </ul>
                        <c:if test="${channel >0}">
                            <form action="admin/pic_house?action=imgUpload" method="post" class="form-inline" enctype="multipart/form-data">
                                <input type="hidden" name="channel" value="${channel}">
                                <input type="hidden" name="id" value="${house.id}">
                                <input type="text" class="form-control" name="dis" placeholder="图片描述">
                                <div class="form-group">
                                    <select name="level" class="form-control" >
                                        <%
                                            for (int i = 9; i >0 ; i--) {
                                        %>
                                        <option value="<%=i%>"><%=i%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="booter.jsp"%>
</body>
</html>

















