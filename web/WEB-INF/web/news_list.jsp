<%--
  @author zth
  @create  2019-05-30 15:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
    <meta charset="UTF-8">
    <title>环球优路-海外资讯</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/huanqiu.css" />
    <style type="text/css">
        #news_block{ width: 1200px; margin: 0 auto;}

        #news_block ul.country_menu{ list-style: none;}
        #news_block ul.country_menu li{ float: left; margin-right: 1px;}
        #news_block ul.country_menu li a{ display: block; line-height: 25px; padding: 6px 20px; color: #000000; background: #F4F4F4; text-decoration: none;}
        #news_block ul.country_menu li a:hover{ border-bottom: 2px #0072E4 solid; color:#0072E4 ;}
        #news_block ul.country_menu li:first-of-type a{border-bottom: 2px #0072E4 solid; color:#0072E4 ;}

        #news_block  #news_list_block{ margin-top: 10px;}
        #news_block  #news_list_block .left{width: 880px; float: left;  height: 1000px;}
        #news_block  #news_list_block .right{width: 300px; float: right;  height: 1000px;}

        #news_block  #news_list_block .left .news_list{width: 880px; height: 125px; margin-bottom: 20px;}
        #news_block  #news_list_block .left .news_list:hover{ padding-left: 10px; background: #F7F7F7;}
        #news_block  #news_list_block .left .news_list img{ float: left; width: 200px; height: 125px; margin-right: 10px;}
        #news_block  #news_list_block .left .news_list div{ float: left; width: 640px; height: 125px;}
        #news_block  #news_list_block .left .news_list div h1 { line-height: 18px;}
        #news_block  #news_list_block .left .news_list div h1 a{ font-size: 18px; font-weight: bold; text-decoration: none; color: #333;}
        #news_block  #news_list_block .left .news_list div h1 a:hover{text-decoration: underline;}
        #news_block  #news_list_block .left .news_list div p{ margin-top: 15px; height: 76px; width: 640px; overflow: hidden; font-size: 12px; line-height: 24px;
            text-overflow: ellipsis;  display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;}
        #news_block  #news_list_block .left .news_list div p a{ text-decoration: none; color: #666;}


        #news_block  #news_list_block .right h3{ font-size: 18px; line-height: 40px; border-bottom: 2px #F1F1F1 solid; padding-left: 10px;}
        #news_block  #news_list_block .right ul{ list-style: none; padding-left: 10px; margin-top: 10px;}
        #news_block  #news_list_block .right ul li{ border-bottom: 1px #CCC dashed; counter-increment: list;  line-height: 40px;  overflow: hidden; text-overflow: ellipsis; white-space:nowrap; }

        #news_block  #news_list_block .right ul li a{ font-size:12px;  color: #333; text-decoration: none; }
        #news_block  #news_list_block .right ul li:before{margin-right: 10px; content: counter(list);  padding: 0 5px; font-size: 12px; border-radius:3px; background: #ff0000; color: #FFF; }
        #news_block  #news_list_block .right ul li a:hover{ text-decoration: underline;}
    </style>
</head>
<body>
<div style="border-bottom: 1px #ccc solid; background: #FFF; width: 100%; z-index: 900;" id="outnav">

    <div  id="topnav">

        <img src="img/logo.png"  style="max-width: 200px;"/>

        <ul>
            <li><a href="index.html">首页</a></li>
            <li id="globhouse" style="position: relative;"><a href="house_list.html" >海外地产  <span class="caret"></span></a>
                <div id="downmenu">
                    <a href="country.html">马来西亚</a>
                    <a href="country.html">泰国</a>
                    <a href="country.html">新加坡</a>
                    <a href="country.html">越南</a>
                </div>

            </li>
            <li><a href="#">海外资讯</a></li>
            <li><a href="news_content.html">关于我们</a></li>
            <li><a href="news_content.html">联系我们</a></li>
        </ul>
        <p>
            <span class="glyphicon glyphicon-phone-alt"></span>  :
            400-123-456
        </p>
    </div>
    <div style="clear: both;"></div>
</div>

<!--
    描述：图片 banner
-->
<div id="new_banner">
    <img src="img/news_banner.jpg" width="100%" />
</div>

<div id="news_block">
    <ol class="pathnav">
        <li><a href="index.html">首页</a></li>
        <li><a href="#">海外资讯</a></li>
    </ol>
    <div style="clear: both;"></div>

    <ul class="country_menu">
        <li><a href="#">全部</a></li>
        <li><a href="#">美国</a></li>
        <li><a href="#">加拿大</a></li>
        <li><a href="#">新加坡</a></li>
        <li><a href="#">马来西亚</a></li>
        <li><a href="#">泰国</a></li>
        <li><a href="#">新西兰</a></li>
        <li><a href="#">英国</a></li>
        <li><a href="#">越南</a></li>
        <li><a href="#">日本</a></li>
    </ul>

    <div style="clear: both;"></div>

    <div id="news_list_block">
        <div class="left">

            <c:forEach items="${pageDiv.list}" var="article" varStatus="vs">
                <div class="news_list">
                    <a href="news_content.html"><img src="${article.pic}" width="200" height="125" /></a>
                    <div>
                        <h1><a href="news_content.html">${article.title}</a></h1>
                        <p><a href="news_content.html">
                                    <c:set value="${article.content}" var="temcont" scope="request"></c:set>
                                    <%
                                        String temstr=(String)request.getAttribute("temcont");
                                        String txtcontent = temstr.replaceAll("</?[^>]+>", ""); //剔出<html>的标签
                                        txtcontent = txtcontent.replaceAll("<a>\\s*|\t|\r|\n</a>", "");
                                        if(txtcontent.length()>450)
                                            out.print(txtcontent.substring(0,450));
                                        else
                                            out.print(txtcontent);
                                    %>
                        </a></p>
                    </div>

                </div>
            </c:forEach>



        </div><!--left end-->
        <div class="right">
            <h3>热点关注</h3>
            <ul>
                <c:forEach items="${hot_arts}" var="hot">
                    <li><a href="news_content.html">${hot.title}</a></li>
                </c:forEach>
               
            </ul>
            <div style="clear: both;"></div>
            <div>
                <img src="img/news_adwlist.jpg" />
            </div>
        </div><!--right end--->
        <div style="clear: both;"></div>
        <!--分页-->
        <div>
            <nav>
                <ul class="pagination" >
                    <li>
                        <a href="#" aria-label="Previous">
                            <span aria-hidden="true">上一页</span>
                        </a>
                    </li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                        <a href="#" aria-label="Next">
                            <span aria-hidden="true">下一页</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>



<!--
作者：langyamoren@163.com
时间：2018-08-14
描述：页脚
-->
<div style="background:#2C3644; height: 280px; width: 100%;">
    <div id="pagefoot">
        <div id="foot_tel">
            <div class="left">
                <h3>环球优路</h3>
                <h5>youlu.com</h5>

                <h3><span class="glyphicon glyphicon-earphone"></span>&nbsp;:400-123-456</h3>
                <h3><span class="glyphicon glyphicon-envelope"></span>&nbsp;:9703239@qq.com</h3>
            </div>
            <div class="right">
                <div>
                    <img src="img/app_ios_androiddown_app.jpg" width="140" height="140" />
                    <p style="text-align: center;">公众号</p>
                </div>

                <div>
                    <img src="img/app_ios_androiddown_app.jpg" width="140" height="140" />
                    <p style="text-align: center;">公众号</p>
                </div>
            </div>
        </div>
        <div id="foot_bottom" style="clear: both; text-align: center; line-height: 50px;">
            Copyright © 2018 youlu.com Inc. All Rights Reserved.

            陕西棕榈海岸置业有限公司&nbsp;陕ICP备18013995号


        </div>
    </div>
</div>
<script type="text/javascript" src="js/jquery.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<script type="text/javascript" src="js/huanqiu.js" ></script>
</body>
</html>
