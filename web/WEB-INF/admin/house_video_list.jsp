<%--
  @author zth
  @create  2019-05-29 10:48
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>楼盘视频管理</title>
    <%@include file="header.jsp"%>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>楼盘视频管理
                        <small style="font-size: 12px; font-weight: bold; margin-left: 30px;">${house.name}</small>
                    </h5>
                </div>
                <%--content--%>
                <div class="ibox-content" style="font-size:12px;">
                    <div style="width: 100%;">
                        <form action="admin/voide_house" method="post" class="form-inline">
                            <input type="hidden" name="action" value="addVideo">
                            <input type="hidden" name="house_id" value="${house.id}">
                            <input type="text" class="form-control" name="dis" placeholder="视频描述">
                            <input type="text" name="code" class="form-control" placeholder="代码"/>

                            <select name="level"  class="form-control" >
                                <%for(int i=9;i>0;i--) {%>
                                <option value="<%=i%>"><%=i%></option>
                                <%
                                    }
                                %>
                            </select>
                            <button type="submit" class="btn btn-info ">增加视频</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>



<%@include file="booter.jsp"%>
</body>
</html>
