<%@ page import="com.hq.bean.House" %>
<%@ page import="com.hq.db.PageDiv" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  @author zth
  @create  2019-05-31 14:49
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>环球优路</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/huanqiu.css" />
    <style type="text/css">

        #country_top_pic{ width: 1200px; margin: 0 auto;}
        #country_top_pic .c_left{ width: 760px; height: 510px; float: left; }
        #country_top_pic .c_right{ width: 430px; height: 510px; float: right; background: url(img/c_right.jpg) no-repeat;}
        #country_top_pic .c_right #country_desc{width: 430px; height: 510px;  background: rgba(0,0,0,.6);}
        #country_top_pic .c_right #country_desc h1{ border-bottom: 1px #FFF solid; line-height: 60px; letter-spacing: 5PX; color: #FFF; font-family:"zhonghei","微软雅黑"; font-size: 30px; padding-top: 30px; padding-left: 25px;}
        #country_top_pic .c_right #country_desc h1 small{ margin-left: 20px; color: #FFF; letter-spacing: 5px; font-size: 24px;}
        #country_top_pic .c_right #country_desc  ol { padding-left: 50px; padding-top: 30px;   overflow: hidden; }
        #country_top_pic .c_right #country_desc  ol li{ color: #FFF; font-size: 18px; margin-bottom: 10px;  line-height: 40px; counter-increment: list; position: relative; }
        #country_top_pic .c_right #country_desc  ol li:before{ content:"("counter(list)"):"; position: absolute; left: -40px;}


        #house_zhinan{width: 1200px; margin: 10px auto;}
        #house_zhinan #zhinan_menu{ border-bottom: 1px #F4F4F4 solid; height: 40px;}
        #house_zhinan #zhinan_menu li{ float: left;}
        #house_zhinan #zhinan_menu li a{ display: block; height: 40px; line-height: 40px; text-decoration: none; color: #333; background: #F4F4F4; padding: 0 20px;}
        #house_zhinan #zhinan_menu li a:hover{ background: orangered; color: #FFF; position: relative;}
        #house_zhinan #zhinan_menu li a:hover:after{ content: ""; border: 6px #000 solid; border-color: rgba(0,0,0,0); border-top:6px orangered solid; position: absolute; top: 100%;  left: 40%;}

        #house_zhinan #zhinan_menu li a.act{ background: orangered; color: #FFF; position: relative;}
        #house_zhinan #zhinan_menu li a.act:after{ content: ""; border: 6px #000 solid; border-color: rgba(0,0,0,0); border-top:6px orangered solid; position: absolute; top: 100%;  left: 40%;}


        #house_zhinan #zhinan_block{ margin-top: 15px;}
        #house_zhinan #zhinan_block .zhinan_list{ width: 580px; height: 110px; position: relative;  float: left; margin-right: 20px; margin-bottom: 20px;}
        #house_zhinan #zhinan_block .zhinan_list img{ position:absolute; left:0; top:0;width: 130px; height: 110px;}
        #house_zhinan #zhinan_block .zhinan_list h3{ position:absolute; left:140px; top:5px; font-size: 16px; font-weight: bold; width: 430px; overflow: hidden;white-space: nowrap;text-overflow: ellipsis; }
        #house_zhinan #zhinan_block .zhinan_list h3 a{ text-decoration: none; color: #333;}
        #house_zhinan #zhinan_block .zhinan_list h3 a:hover{ text-decoration: underline;}
        #house_zhinan #zhinan_block .zhinan_list p{ position: absolute; left: 140px; top: 35px; width: 430px; height: 50px; overflow: hidden; font-size: 12px;text-overflow: ellipsis;  display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;}
        #house_zhinan #zhinan_block .zhinan_list label{position: absolute; left: 480px; top: 86px;  font-size: 12px; color: #666;}


        /*房子列表*/
        #housesearch_list{ width: 1200px; margin: 0 auto;}
        #housesearch_list h5{ border-bottom:1px #ccc dashed; font-size: 20px; line-height: 40px; padding-left: 20px;}
        #housesearch_list h5 a{ margin-left: 20px; font-size: 14px; color: #333; text-decoration: none;}
        #housesearch_list h5 a:hover{ text-decoration: underline;}

        #housesearch_list .houselist_v{ width: 1200px; height: 240px; }
        #housesearch_list .houselist_v:hover{ padding-left: 20px; background:  #F4F4F4;}
        #housesearch_list .houselist_v .left{ width: 300px; height: 240px; float: left;}
        #housesearch_list .houselist_v .right{ width: 880px; height: 240px;  float: left; position: relative;}

        #housesearch_list .houselist_v .left img{  width: 280px; height: 200px; margin-top: 20px;}

        #housesearch_list .houselist_v .right h1{ position: absolute; left: 0; top: 18px; font-size: 24px; line-height: 25px; font-weight: bold;}
        #housesearch_list .houselist_v .right h1 a{ color: #555; text-decoration: none;}
        #housesearch_list .houselist_v .right h1 a:hover{ text-decoration: underline;}
        #housesearch_list .houselist_v .right p.tedian{ position: absolute; left: 0; top: 60px; font-size: 14px;  color: #444;}
        #housesearch_list .houselist_v .right p.weizhi{ position: absolute; left: 0px; top: 110px; font-size: 12px; color: #666; }
        #housesearch_list .houselist_v .right p.jiazhi{ position: absolute; left: 0; top: 150px; font-size: 14px; }
        #housesearch_list .houselist_v .right p.jiazhi>span{ font-weight: bold; color: #F00;}
        #housesearch_list .houselist_v .right p.focustedian{ position: absolute; left: 0; top: 190px; font-size: 12px;}
        #housesearch_list .houselist_v .right p.focustedian>span{ border: 1px #CCC solid; margin-right: 15px; border-radius: 12px; padding: 3px 10px; background: #FFF;}
        #housesearch_list .houselist_v .right p.price{ text-align: center; font-size: 20px; font-weight: bold; color: #FF0000; position: absolute; left: 660px; top: 80px;}
        #housesearch_list .houselist_v .right p.price span{ font-size: 16px; font-weight: 500; color: #999;}
        #housesearch_list .houselist_v .right a.housedetil{ position: absolute; left: 670px; top: 185px; display: block; padding: 10px 25px; border-radius: 10px; background: orangered; color: #FFF; text-decoration: none; letter-spacing: 5px;}
        #housesearch_list .houselist_v .right a.housedetil:hover{ background: #FF724F;}


        #house_02,#house_03{ display: none;}

    </style>
</head>
<body>
<div style="border-bottom: 1px #ccc solid; background: #FFF; width: 100%; z-index: 900;" id="outnav">

    <div  id="topnav">

        <img src="img/logo.png"  style="max-width: 200px;"/>

        <ul>
            <li><a href="index.html">首页</a></li>
            <li id="globhouse" style="position: relative;"><a href="#" >海外地产  <span class="caret"></span></a>
                <div id="downmenu">
                    <c:forEach items="${countrys}" var="country">
                        <a href="country?cityid=${country.id}">${country.name}</a>
                    </c:forEach>

                </div>

            </li>
            <li><a href="news">海外资讯</a></li>
            <li><a href="aboutMe">关于我们</a></li>
            <li><a href="#foot_bottom">联系我们</a></li>
        </ul>
        <p>
            <span class="glyphicon glyphicon-phone-alt"></span>  :
            400-123-456
        </p>
    </div>
    <div style="clear: both;"></div>
</div>


<%--描述：以下是国家的轮播图--%>

<div style="width: 100%; background: #EEE;">
    <div id="country_top_pic">
        <div class="c_left">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->

                <ol class="carousel-indicators">
                    <c:forEach items="${cityPics}"   varStatus="vs">
                        <li data-target="#carousel-example-generic" data-slide-to="${vs.index}"
                            <c:if test="${vs.index == 0}"> class="active" </c:if> >
                        </li>
                    </c:forEach>

                </ol>

                <!-- Wrapper for slides -->

                <div class="carousel-inner" role="listbox">

                    <c:forEach items="${cityPics}"  var="cityPic" varStatus="vs">
                        <div class="item <c:if test="${vs.index == 0}"> active </c:if>">
                            <img src="${cityPic.path}">
                            <div class="carousel-caption">
                                <!--...-->
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>

        </div><!--end left-->
        <div class="c_right">
            <div id="country_desc">
                <h1>${country.name}<small>投资优势：</small></h1>

                <%--<ol>
                    <li>75%为华人，亚洲四小龙，世界金融与贸易中心之一</li>
                    <li>花园城市国家，全球最佳宜居城市之一</li>
                    <li>教育医疗设施全球领先</li>
                    <li>租金回报率3%-5%，房价增长潜力巨大</li>
                    <li>外国人贷款门槛低，无资本利得税和出售预扣税</li>
                </ol>--%>
                <div style="color: #eeeeee; font-size: 18px;line-height: 50px;margin-left: 10px">
                   <%-- <c:set value="${country.dis}" var="temcont" scope="request"></c:set>
                    <%
                        String temstr=(String)request.getAttribute("temcont");
                        String txtcontent = temstr.replaceAll("</?[^>]+>", ""); //ÌÞ³ö<html>µÄ±êÇ©
                        txtcontent = txtcontent.replaceAll("<a>\\s*|\t|\r|\n</a>", "");
                        if(txtcontent.length()>80)
                            out.print(txtcontent.substring(0,80));
                        else
                            out.print(txtcontent);
                    %>--%>
                       ${country.dis}
                </div>

            </div>

        </div><!--end right-->
        <div  style="clear: both;"></div>
    </div>
</div>

<div style="clear: both;"></div>

<div id="house_zhinan">
    <%--<ul id="zhinan_menu">
        <li><a data-ids="#house_01" href="#" class="act">购房指南</a></li>
        <li><a data-ids="#house_02"  href="#" >生活百科</a></li>
        <li><a data-ids="#house_03"  href="#" >最新资讯</a></li>
    </ul>--%>
       <%-- <ul id="zhinan_menu">
            <li><a data-ids="#house_03"  ></a></li>
        </ul>--%>

    <div style="height: 40px;font-size: 20px;background-color: #ee4500 ; text-align: center;line-height: 40px"; >
        最新资讯
    </div>
    <div style="clear: both;"></div>
    <div id="zhinan_block">
        <div id="house_01">

            <c:forEach items="${articles}" var="news">
                <div class="zhinan_list">
                    <a href="web/art_${news.channel_id}/news_${news.channel_id}_${news.id}.html"><img src=${news.pic} /></a>
                    <h3><a  href="web/art_${news.channel_id}/news_${news.channel_id}_${news.id}.html">${news.title}</a></h3>
                    <p>
                        <c:set value=" ${news.content}" var="temcont" scope="request"></c:set>
                        <%
                            String temstr=(String)request.getAttribute("temcont");
                            String txtcontent = temstr.replaceAll("</?[^>]+>", "");
                            txtcontent = txtcontent.replaceAll("<a>\\s*|\t|\r|\n</a>", "");
                            if(txtcontent.length()>100)
                                out.print(txtcontent.substring(0,110));
                            else
                                out.print(txtcontent);
                        %>

                    </p>
                    <label>
                        <fmt:formatDate pattern="yyyy-MM-dd"   value="${news.ctime}" />

                    </label>
                </div>
            </c:forEach>
        </div>
    </div><!--end zhinan_block-->
</div>

<div style="width: 1200px; margin: 25px auto;">
    <img src="img/step5.jpg" />
</div>


<%-- 描述:以下是房列表--%>
<div id="housesearch_list">
    <%--<h5>${country.name}精选房：<a href="#"></a><a href="#">旧金山</a><a href="#">旧金山</a></h5>--%>

    <c:forEach items="${pageDiv.list}" var="house">
        <div class="houselist_v">
            <div class="left">
                <a house?id=${house.id}><img src="${house.pic}" border="0" /></a>
            </div>
            <div class="right">
                <h1><a href="house?id=${house.id}">${house.name}</a></h1>
                <p class="tedian">${house.feature}</p>
                <p class="weizhi"><span class="glyphicon glyphicon-map-marker"></span>${house.addr}</p>
                <p class="jiazhi">
                    近一年房价涨幅<span>10</span>% | 年均租金收益<span> 9%~20% </span> | 首付比例<span> 30%</span>
                </p>
                <p class="focustedian">
                    <%--<span>精装修</span><span>学区</span><span>学区</span>--%>
                    <span>${house.keyword}</span>
                </p>
                <p class="price">
                    ￥${house.price_rmb}
                    <br />
                    <span>约${house.price_other}万美元</span>
                </p>
                <a href="house_content.html" class="housedetil">查看详情</a>
            </div>
        </div>
    </c:forEach>

    <div>
        <nav>

            <ul class="pagination" >
                <li>
                    <%
                        PageDiv<House> pageDiv = (PageDiv<House>)request.getAttribute("pageDiv");
                    %>
                    <a href="country?cityid=${country.id}&pageNo=<%=(pageDiv.getPageNO()-1)>1?(pageDiv.getPageNO()-1):1%>" aria-label="Previous">
                        <span aria-hidden="true">上一页</span>
                    </a>
                </li>

                <%
                    for (int i = pageDiv.getStart(); i <= pageDiv.getEnd(); i++) {
                        request.setAttribute("i",i);
                %>
                <li>
                    <a  href="country?cityid=${country.id}&pageNo=<%=i%>" <c:if test="${pageDiv.pageNO == i}"> style="background-color: pink" </c:if> >
                        <%=i%>
                    </a>
                </li>

                <%
                    }
                %>

                <li>
                    <a href="country?cityid=${country.id}&pageNo=<%=((pageDiv.getPageNO()+1)< pageDiv.getTotalPage()?(pageDiv.getPageNO()+1):pageDiv.getTotalPage())%> " aria-label="Next">
                        <span aria-hidden="true">下一页</span>
                    </a>
                </li>
            </ul>

        </nav>
    </div>

</div>

<div style="background:#2C3644; height: 280px; width: 100%;">
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
<script type="text/javascript">
    $(function(){

        $("#zhinan_menu a").each(function(){
            $(this).mouseover(function(){
                $("#zhinan_menu a").removeClass("act");
                $(this).addClass("act");
            });

            $(this).click(function(){
                $("#house_01,#house_02,#house_03").hide();
                var idname=$(this).data("ids");
                $(idname).show();

            });

        });
    });

</script>
</body>
</html>
