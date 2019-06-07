<%--
  @author zth
  @create  2019-05-05 21:10
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <base href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"%>"/>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>登录</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>
        if (window.top !== window.self) {
            window.top.location = window.location;
        }
    </script>

</head>

<body class="signin">
<div class="signinpanel">
    <div class="row">
        <div class="col-sm-12">
            <form method="post" action="admin/login" >
                <h2 class="no-margins">环球优路</h2>
                <input type="hidden" name="action" value="checkLogin" >
                <input type="email" name="uname" class="form-control"  placeholder="用户名" required />
                <input type="password" name="upwd" class="form-control"  placeholder="密码" required/>
                <div  class="form-group ">
                    <input type="text " placeholder="输入验证码"  style="width:160px; float: left"  name="rand" required class="form-control" />
                </div>
                <div  class="form-group ">
                    <lable><img  src="../random" style="cursor:pointer ; float: right" onclick="this.src='../random?ss='+Math.random();"/></lable>
                </div>
                <br><br>
                <a href="">忘记密码了？</a>
                <button class="btn btn-success btn-block">登录</button>
            </form>
        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
</body>

</html>
