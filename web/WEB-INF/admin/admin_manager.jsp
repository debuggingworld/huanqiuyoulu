<%--
  @author zth
  @create  2019-05-08 16:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>管理员管理</title>
</head>
<body class="gray-bg">

<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>管理员管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-12">

                            <div class="panel panel-success">
                                <div class="panel-heading">添加管理员</div>
                                <div class="panel-body">
                                    <form action="admin/admin" method="post" class="form-inline">
                                        <input type="hidden" name="action" value="saveadd">
                                        <input type="email" name="email" class="form-control" placeholder="请输入邮箱" required>
                                        <input type="password" name="upwd" class="form-control" placeholder="请输入密码" required>
                                        <div class="form-group">
                                            <select name="upur" class="form-group">
                                                <option value="100000">管理员</option>
                                                <option value="010000">普通管理员</option>
                                                <option value="001000">一般</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-info">增加</button>
                                    </form>
                                </div>
                            </div>


                        </div>
                    </div>





                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
