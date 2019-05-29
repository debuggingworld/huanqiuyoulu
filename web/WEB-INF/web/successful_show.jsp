<%--
  @author zth
  @create  2019-05-29 20:31
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成功案例详情</title>
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
                                <a href="index.html#succ_case">成功案例</a>
                            </li>
                            <li>
                                ${successful.name}
                            </li>
                        </ol>
                    </div>
                    <div class="text-center article-title">
                        <img src="${successful.pic2}" class="img-circle" style="width: 30px ;display: inline-block">
                        <span style="font-size: 22px">${successful.name}</span>
                        <br><br>
                        <h4>选购项目：${successful.house}</h4>
                        <h4>选购理由：${successful.why}</h4>
                    </div>
                    <hr>
                    <div>
                        ${successful.dis}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../admin/booter.jsp"%>
</body>
</html>
