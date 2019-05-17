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

        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
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
                <div class="ibox-content" style="font-size: 12px;padding-bottom: 50px">
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
                                <input type="hidden" name="house_id" value="${house.id}">
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

                                <%--图片选择框--%>
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="请选择上传图片" readonly id="fileName">
                                </div>
                                <div class="form-group " >
                                    <div class="form-control"  style="padding: 0px">
                                        <a href="javascript:;" class="file " style="width: 100%" >选择图片
                                            <input type="file"  onchange="document.getElementById('fileName').value=this.value"  name="pic">
                                        </a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-control" style="padding: 0px">
                                        <button class="btn btn-info " type="submit" >上传图片</button>
                                    </div>
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

















