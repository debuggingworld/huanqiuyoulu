<%--
  @author zth
  @create  2019-05-28 17:02
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>成功案例列表</title>
</head>
<body class="">
<div style="height: 40px;"></div>
<div class="container-fluid" >
    <div class="row">
        <div class="col-sm-12">
            <div class="row">
                <a href="admin/successful?action=toAdd" class="btn btn-info" style="margin: 10px 20px;">+添加成功案例</a>
            </div>
            <table class="table table-striped table-hover table-condensed table-responsive" style="font-size: 12px">
                <tr><th>ID</th><th>姓名</th><th>项目</th><th>排序</th><th>管理</th></tr>
                <c:forEach items="${successfuls}" var="success" varStatus="vs">
                    <tr>
                        <td>${vs.count}</td>
                        <td>${success.name}</td>
                        <td>${success.house}</td>
                        <td>${success.level}</td>
                        <td>
                            <a href="admin/successful?action=edit&id=${success.id}" class="btn btn-info btn-sm">
                                <i class="fa fa-edit"></i>修改
                            </a>
                            <a href="admin/successful?action=del&id=${success.id}" class="btn btn-danger btn-sm">
                                <i class="fa fa-close"></i>删除
                            </a>
                            <a href="admin/successful?action=show&id=${success.id}" class="btn btn-primary btn-sm">
                                <i class="fa fa-file-word-o"></i>查看
                            </a>
                            <a href="admin/successful?action=createTtml&id=${success.id}" class="btn btn-success btn-sm">
                                <i class="fa fa-check-square-o"></i>发布
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
</body>
</html>
