<%--
  @author zth
  @create  2019-05-20 17:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <%@include file="header.jsp"%>
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
                                <a href="index.html">首页</a>
                            </li>
                            <li>
                                <a href="index.html#art">${article.channelName}</a>
                            </li>
                            <li>
                                ${article.title}
                            </li>
                        </ol>
                    </div>
                    <div class="text-center article-title">
                        <h3>${article.content}</h3>
                    </div>
                    <div class="text-center">
                        <a class="btn btn-info" href="index.html#art">返回</a>
                    </div>
                    <hr>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="booter.jsp"%>
</body>
</html>
