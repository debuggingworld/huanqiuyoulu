<%--
  @author zth
  @create  2019-05-31 10:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>环球优路</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/huanqiu.css" />
    <style type="text/css">
        #news_content{ width: 1200px; margin: 0 auto; padding: 30px; border: 1px #F2F2F2 solid;}
        #news_content img{ max-width: 1000px;}

        #news_content h1{ line-height: 50px; font-size: 24px; font-weight: bold; color: #333;}
        #news_content h6{ line-height: 50px; font-size: 14px; color: #555; border-bottom: 1px #ccc dashed;}
        #news_content .contents{ font-size: 16px; line-height: 35px;}
    </style>
</head>
<body>
<div style="border-bottom: 1px #ccc solid; background: #FFF; width: 100%; z-index: 900;" id="outnav">

    <div  id="topnav">
        <img src="img/logo.png"  style="max-width: 200px;"/>

        <ul>
            <li><a href="index.html">首页</a></li>
            <li id="globhouse" style="position: relative;"><a href="houses" >海外地产  <span class="caret"></span></a>
                <div id="downmenu">
                    <c:forEach items="${countrys}" var="country">
                        <a href="country?cityid=${country.id}">${country.name}</a>
                    </c:forEach>
                </div>

            </li>
            <li><a href="news">海外资讯</a></li>
            <li><a href="aboutMe">关于我们</a></li>
            <li><a href="#pagefoot">联系我们</a></li>
        </ul>
        <p>
            <span class="glyphicon glyphicon-phone-alt"></span>  :
            400-123-456
        </p>
    </div>
    <div style="clear: both;"></div>
</div>

<div id="new_banner">
    <img src="img/adw01.jpg" width="100%" style="max-height: 300px;"/>
</div>

<%-- 描述：面包导航--%>
<div  style="height: 40px; background: #F2F2F2;">
    <div style="width: 1200px; margin: 0 auto;">
        <ol class="pathnav">
            <li><a href="index.html">首页</a></li>
            <li><a href="#">关于我们</a></li>
        </ol>
        <div style="clear: both;"></div>
    </div>
</div>

<div id="news_content">
    <h1>环球优路</h1>
    <div class="row">
        <div class="">
            <div class="ibox float-e-margins">
                <div class="ibox-content">
                    <div class="carousel slide" id="carousel1">
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt="image" class="img-responsive" src="img/about01.jpg">
                            </div>
                            <div class="item">
                                <img alt="image" class="img-responsive" src="img/about02.jpg">
                            </div>
                            <div class="item">
                                <img alt="image" class="img-responsive" src="img/about03.jpg">
                            </div>
                            <div class="item">
                                <img alt="image" class="img-responsive" src="img/about04.jpg">
                            </div>
                            <div class="item">
                                <img alt="image" class="img-responsive" src="img/about05.jpg">
                            </div>

                        </div>
                        <a data-slide="prev" href="carousel.html#carousel1" class="left carousel-control">
                            <span class="icon-prev"></span>
                        </a>
                        <a data-slide="next" href="carousel.html#carousel1" class="right carousel-control">
                            <span class="icon-next"></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <div class="contents">
        <p>
            <br><br>
            我们是一家旅居地产综合服务提供商，致力于为客户提供最完善的投资咨询服务，一站式服务，打造旅居地产第一品牌“环球第二家园”，为成功人士规划全球资产，做每个人都能买得起的好房子。<br/>
            选择一个居所，静、可聆听己心！动、则尽阅繁华，匠心精筑，第二家园给心一个归宿...<br/>
            我们一直渴望着，老了之后我们一起远离都市的喧嚣，<br/>
            去往我们一直向往的城市购买或是建造一座小院。<br/>
            小院周边没有车水马龙，更没有闪烁的霓虹；<br/>
            也不会再有那朝九晚五，<br/>
            也看不到那些行色焦虑的匆匆人群。<br/>
            心若没有栖息的地方，<br/>
            到哪里都是在流浪。<br/>
            寻一方庭院，<br/>
            过第二人生。<br/>
            得第二家园，<br/>
            享幸福人生。<br/>
        </p>

    </div>
</div>

<div>

    <hr/>


</div>


<%--描述：页脚--%>

<div style="background:#2C3644; height: 280px; width: 100%;"  class="full_screen">
    <div id="pagefoot">
        <div id="foot_tel">
            <div class="left">
                <h3>环球优路</h3>
                <h5>youlu.com</h5>

                <h3><span class="glyphicon glyphicon-earphone"></span>&nbsp;123-456-789</h3>
                <h3><span class="glyphicon glyphicon-envelope"></span>&nbsp;    123456x@qq.com</h3>
            </div>
            <div class="right">
                <div>
                    <img src="img/alipay.png" width="140" height="140" />
                    <p style="text-align: center;">支付宝</p>
                </div>

                <div>
                    <img src="img/weixin.png" width="140" height="140" />
                    <p style="text-align: center;">微信</p>
                </div>

                <div style="clear: both; text-align: center; ">
                    <br>
                    <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;您的支持是我唯一的动力</h4>
                </div>
            </div>
        </div>

        <div id="foot_bottom" style="clear: both; text-align: center; line-height: 50px;">
            Copyright © 2018 zth.com Inc. All Rights Reserved.

            潘小柔置业有限公司&nbsp;陕ICP备xxxxx号


        </div>
    </div>
</div>


<script type="text/javascript" src="js/jquery.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min.js" ></script>
<script type="text/javascript" src="js/huanqiu.js" ></script>
</body>
</html>
