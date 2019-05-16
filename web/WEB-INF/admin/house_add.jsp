<%--
  @author zth
  @create  2019-05-16 11:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>增加楼盘信息</title>
    <%@include file="header.jsp"%>
    <link rel="stylesheet" href="css/jquery-labelauty.css">
    <script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>增加楼盘基本信息</h5>
                </div>
                <div class="ibox-content" style="font-size: 12px">
                    <form action="admin/house" method="post" class="form-horizontal">
                        <input type="hidden" name="action" value="saveadd"/>

                        <div class="form-group col-sm-6">
                            <label  class="col-sm-4 col-md-2 control-label">楼盘名字:</label>
                            <div class="col-sm-8 col-md-9">
                                <input type="text" name="name"  class="form-control"  placeholder="请输入楼盘名字">
                            </div>
                        </div>
                        <div class="form-group col-sm-6">

                            <div class="col-sm-6">
                                <select name="country_id" id="country_s" class="form-control">
                                    <option value="-1">选择国家</option>
                                    <c:forEach items="${countrys}" var="count">
                                        <option value="${count.id}">${count.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <select name="city_id" id="city_s" class="form-control">
                                    <option value="-1">选择城市</option>
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<%@include file="booter.jsp"%>
<script type="text/javascript" src="js/jquery-labelauty.js"></script>
<script>

    $(function () {
        $(':input').labelauty();
        $("#country_s").change(function () {
            var id = $(this).val();
            $.get("admin/city",{parent_id:id,acton:"subcitys"},function (data) {
                $("#city_s").empty();
            })
        });
    });
</script>
</body>
</html>
