<%--
  @author zth
  @create  2019-05-28 10:43
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${travel.title}</title>
    <%@include file="../admin/header.jsp"%>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content  animated fadeInRight article">
    <div class="row">
        <div class="col-lg-10 col-lg-offset-1">
            <div class="ibox">
                <div class="ibox-content">
                    <div class="pull-left">
                        <ol class="breadcrumb">
                            <li>
                                <a href="index.html#trav">旅游考察</a>
                            </li>
                            <li>
                                ${travel.title}
                            </li>
                        </ol>
                    </div>
                    <div class="text-center article-title">
                        <h2>${travel.title}</h2>
                        <br>
                        <h4>出发城市：${travel.city}&nbsp;&nbsp;&nbsp;&nbsp;出发时间：${travel.depart}&nbsp;&nbsp;&nbsp;&nbsp;访问城市:${travel.visitcity}</h4>
                    </div>
                    <hr>
                    <div>
                        ${travel.content}
                    </div>
                    <div class="text-center">
                        <a href="index.html#trav" class="btn btn-info">返回</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../admin/booter.jsp"%>
</body>
</html>

