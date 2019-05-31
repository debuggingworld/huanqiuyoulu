<%--
  @author zth
  @create  2019-05-12 12:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>国家和城市管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%@include file="header.jsp"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="file-manager"  style="padding: 20px">
                    <a href="admin/city?action=toadd" class="btn btn-info btn-primary">增加国家/城市</a>
                    <div class="hr-line-dashed"></div>
                    <h5>国家列表</h5>
                    <ul class="folder-list" style="padding: 0px">
                        <li><a href="admin/city"><i class="fa fa-folder">&nbsp;&nbsp;&nbsp;所有</i> </a></li>

                        <c:forEach items="${countrys}" var="cty">
                            <li>
                                <a href="admin/city?cid=${cty.id}"><i class="fa fa-folder">&nbsp;&nbsp;&nbsp;${cty.name}</i> </a>
                            </li>
                        </c:forEach>
                        <div class="clearfix"></div>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-sm-9 animated fadeInRight">
            <div>
                <c:if test="${not empty country}">
                    <h3>${country.name}&nbsp;&nbsp;
                        <a href="admin/city?action=edit&cityid=${country.id}" style="margin: 0px" class="btn btn-xs btn-info">修改</a>
                        <a href="country?cityid=${country.id}" style="margin: 0px" class="btn btn-xs btn-success">查看</a>
                    </h3>
                </c:if>
            </div>
            <div class="row">
                <div class="col-sm-12" >

                    <c:forEach items="${cities}" var="city">
                        <div style="margin: 0px 20px 20px 0px;display: inline-block">
                            <a href="admin/city?action=edit&cityid=${city.id}">
                                <img src="${city.pic}" class="img-thumbnail" style="width: 250px">
                                <span class="btn btn-default center-block">
                                        ${city.name}
                                </span>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

    </div>
</div>

<%@include file="booter.jsp"%>
</body>
</html>
