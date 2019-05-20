<%--
  @author zth
  @create  2019-05-07 19:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">

    <title>环球优路</title>
    <base href="<%=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"%>"/>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->

    <link rel="shortcut icon" href="images/favicon.ico">
    <link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close">
            <i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
               <li>
                   <a class="navbar-minimalize J_menuItem">
                       <i class="fa fa-bars" style="font-size:20px;color:#FFF;"></i>
                       <span class="nav-label" style="font-size:20px;color:#FFF;">环球优路</span>
                   </a>
               </li>
                <li>
                    <a class="J_menuItem top_menu " href="admin/forward?page=admin/welcome.jsp">
                        <i class="fa fa-home"></i>
                        <span class="nav-label">主页</span>
                    </a>
                </li>
                <li>
                    <a class="J_menuItem top_menu " href="admin/article?action=toAdd">
                        <i class="fa fa-image"></i>
                        <span class="nav-label">发布资讯</span>
                    </a>
                </li>
                <li>
                    <a class="J_menuItem top_menu " href="admin/article">
                        <i class="fa fa-object-group"></i>
                        <span class="nav-label">资讯管理</span>
                    </a>
                </li>
                <li>
                    <a class="J_menuItem top_menu " href="admin/train">
                        <i class="fa fa-user-secret"></i>
                        <span class="nav-label">培训管理</span>
                    </a>
                </li>

                <li>
                    <a class="J_menuItem top_menu " href="admin/house?cid=0&pageNo=1">
                        <i class="fa fa-building-o"></i>
                        <span class="nav-label">楼盘管理
                    </a>
                </li>

                <li>
                    <a class="hassubs_menu" >
                        <i class="fa fa-bar-chart-o"></i>
                        <span class="nav-label">经纪人管理</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a class="J_menuItem" href="admin/celler?action=regist">注册经纪人</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/company?action=add">注册经纪公司</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/company">经纪公司管理</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/seller">经纪人管理</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/custom?action=add">新客户报备</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/custom">客户管理</a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#" class="hassubs_menu">
                        <i class="fa fa-wrench"></i>
                        <span class="nav-label">系统管理</span>
                        <span class="fa arrow"></span>
                    </a>
                    <ul class="nav nav-second-level">
                        <li>
                            <a class="J_menuItem" href="admin/city">国家</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/focuspic">焦点图</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/artchannel">资讯栏目</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/attach">附件管理</a>
                        </li>
                        <li>
                            <a class="J_menuItem" href="admin/admin">管理员管理</a>
                        </li>

                    </ul>
                </li>

                <li>
                    <a class="J_menuItem top_menu " href="admin/login?action=logout">
                        <i class="glyphicon glyphicon-off"></i>
                        <span class="nav-label">注销退出</span>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row" style="height: 20px;line-height: 36px">
            <div class="navbar navbar-static-top" style="margin-bottom: 0; min-height: 35px ">
                <div class="pull-left" style="margin-left: 20px">
                    <span class="fa fa-home"></span>&nbsp;
                    <a href="" style="color: #333; font-weight: bold;">首页</a>
                    <span id="one_show"></span>
                    <span id="jm_show"></span>
                </div>
                <div class="pull-right " style="margin-right: 20px;"  >
                    Welcome,${loged.email}! <a href="admin/login?action=logout">退出</a>

                </div>
            </div>
        </div>
        <div style="clear: both;"></div>

        <div class="row J_mainContent" id="content-main">
            <iframe id="J_iframe" name="iframe0" data-index="0"  width="100%" height="100%" src="admin/forward?page=admin/welcome.jsp" frameborder="0" data-id="admin/forward?page=admin/welcome.jsp" seamless></iframe>

            <!--  <iframe class="J_iframe" id="J_iframe" name="iframe0" width="100%" height="100%" src="admin/admin/welcome" frameborder="0" data-id="admin/admin/welcome" seamless></iframe> -->
        </div>
    <!--右侧部分结束-->
</div>

<!-- 全局js -->
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="js/plugins/layer/layer.min.js"></script>

<!-- 自定义js -->
<script src="js/hAdmin.js?v=4.1.0"></script>
<script type="text/javascript" src="js/index.js"></script>

<!-- 第三方插件 -->
<script src="js/plugins/pace/pace.min.js"></script>
<%--<%@include file="booter.jsp"%>--%>
    <script src="js/content.js"></script>
    <script src="js/sweetalert.min.js"></script>
</body>

</html>
