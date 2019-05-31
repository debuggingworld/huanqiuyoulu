<%--
  @author zth
  @create  2019-05-31 20:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>环球优路</title>
    <link rel="shortcut icon" href="images/favicon.ico">
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/huanqiu.css" />
    <style type="text/css">

        #inner_mianbao{ width: 1200px; margin: 0 auto;}
        #inner_mianbao .pathnav li a{ color: #FFF; }
        #inner_mianbao .pathnav li a:hover{ text-decoration: underline; }
        #house_focus_img{width: 1200px; margin: 0 auto; position: relative;}

        #house_focus_img .left{ width:670px; height: 540px; float: left; }
        #house_focus_img .right{ width:480px; height: 540px; background: #FFF; border-top: 6px  #F75053 solid; float: left; margin-left: 15px; position: relative;}
        #house_focus_img .right h1{ position: absolute; left: 10px; top: 10px; line-height: 40px; font-size: 24px;}
        #house_focus_img .right p.price{ position: absolute; left: 30px; top: 60px; font-size: 12px; color: #666;}
        #house_focus_img .right p.price span{ color: red; font-size: 24px; font-weight: bold;}
        #house_focus_img .right p.location{ position: absolute; left: 30px; top: 120px; font-size: 12px; letter-spacing: 3px; color: #666;}
        #house_focus_img .right p.focus_list{ text-align:center;position: absolute; left: 0px; top: 160px; width: 480px; line-height: 40px; font-size: 12px; border-bottom: 1px #ccc dashed;}
        #house_focus_img .right p.focus_list span{ border: 1px #CCC solid; margin:0 10px; border-radius: 12px; padding: 3px 10px; background: #F8F8F8;}
        #house_focus_img .right  ul{position: absolute; left: 0px; top: 210px; width: 480px; height: 130px;  border-bottom: 1px #ccc dashed;}
        #house_focus_img .right  ul li{ width: 190px;  line-height: 40px;  float: left;  margin-left: 40px; color: #333; font-size: 12px;}
        #house_focus_img .right  ul li span{ margin-right: 10px;}
        #house_focus_img .right  p.address{ position: absolute; left: 20px; top: 355px; font-size: 12px; width: 420px; }
        #house_focus_img .right  p.huxing{ position: absolute; left: 20px; top: 410px; font-size: 12px;width: 420px;}
        #house_focus_img .right  a.zixun{position: absolute; left: 300px; top: 460px;  display: block; padding: 10px 25px; border-radius: 6px; background: orangered; color: #FFF; text-decoration: none; letter-spacing: 5px;}
        #house_focus_img .right  a.zixun:hover{ background: #FF724F;}
        #house_focus_img .right  p.telphone{position: absolute; left: 30px; top: 470px; font-size: 24px; font-weight: bold; color: #FF0000;;}

        /*房子详情*/

        #desc_menu{}
        #desc_menu ul li{ float: left;}
        #desc_menu ul li a{ display: block; padding: 10px 20px; text-decoration: none; color: #333; background: #eee;}
        #desc_menu ul li a:hover,#desc_menu ul li a.act{ background: orangered; color: #FFF;}

        /*
        图片轮播的样式
        */
        #house_imgs{position: relative; z-index: 8; padding-bottom: 25px; width: 100%; overflow: hidden;}
        #house_imgs #house_bigImg{margin-bottom: 10px; width: 670px; height: 445px; overflow: hidden;}
        #house_imgs #house_bigImg ul li{position: relative; z-index: 9;}
        #house_imgs .project_img{width: 670px; height: 445px; overflow: hidden;}
        #house_imgs .project_img dl{width:auto; height:445px; overflow: hidden;}
        #house_imgs .project_img dl dd{float: left; width: 670px; height: 445px;}
        #house_imgs #house_smallImg{position: relative; z-index: 10; margin-top: 0px; width: 100%; height: 82px; overflow: hidden;}
        #house_imgs span.house_imgs_lf2{display: block; position: absolute; left:20px; top: 190px; z-index: 9; width: 44px; height: 44px; border-radius: 22px; overflow: hidden; background:url(img/arrow_lf2.png) no-repeat center center; cursor:pointer;}
        #house_imgs span.house_imgs_rt2{display: block; position: absolute; right:20px; top: 190px; z-index: 9; width: 44px; height: 44px; border-radius: 22px; overflow: hidden; background:url(img/arrow_rt2.png) no-repeat center center; cursor:pointer;}

        /*和bootstrap冲突解决方法*/
        #house_smallImg *{box-sizing:content-box}
        #house_smallImg ul{width: 100%;}
        #house_smallImg ul li{position:relative; float: left;   width:126px;  padding-right: 10px;}
        #house_smallImg ul li img{display: block; width: 126px; height: 82px; cursor: pointer; }
        #house_smallImg ul li.on img{width: 122px; height: 78px; border: 2px #f23742 solid;}
        #house_smallImg ul li .bun_bg{display: block; position: absolute; bottom: 0; left: 0; z-index: 9; width: 126px; height: 27px; line-height: 26px; text-align: center; font-size: 14px; color: #FFF; background: rgba(0,0,0,0.5); }
        #house_smallImg ul li.on .bun_bg{width: 122px; bottom: 2px; left: 2px;}
        /*
        图片轮播结束
        */

        /**
         * 详情页面内容
         */
        .house_detil_list{  padding: 30px; font-size: 14px; line-height: 30px;  color: #333; margin-bottom: 20px;}
        .house_detil_list h3{ line-height: 50px; border-bottom: 1px #ccc solid; font-weight: bold; font-size: 24px;}
        /*户型列表*/
        .house_detil_list .huxing_show{ position: relative; width: 100%; height: 190px; margin-bottom: 10px;}
        .house_detil_list .huxing_show img{ position: absolute; left: 0px; top: 5px; width: 250px; height: 175px;}
        .house_detil_list .huxing_show p.hx_title{ position: absolute; left:280px ; top: 30px; font-size: 22px; font-weight: bold; }
        .house_detil_list .huxing_show p.hx_price{position: absolute; left:360px ; top: 100px;  color: #666; font-size: 16px;}
        .house_detil_list .huxing_show p.hx_price span{ color: #FF0000; font-size: 22px;}
        .house_detil_list .huxing_show a.hx_detil{ position: absolute; left:930px ; top: 80px; border-radius: 6px; letter-spacing: 5px; font-size: 14px;  color: #666;  display: block; padding: 6px 25px;  text-decoration: none; border: 1px #888 solid;}
        .house_detil_list .huxing_show a.hx_detil:hover{ background: orangered; color: #FFF; }
        /*物业配套*/

        .house_detil_list div.cf_list{ line-height: 60px; font-size: 14px; color: #999;}

        .house_detil_list div.cf_list p{ float: left;}
        .house_detil_list div.cf_list p.cf_title{ margin-right: 25px;}
        .house_detil_list div.cf_list p.cf_item{ margin: 0 15px;}
        .house_detil_list div.cf_list p.cf_item span{ color: red; margin-right: 10px;}
    </style>

</head>
<body>
<div style="border-bottom: 1px #ccc solid; background: #FFF; width: 100%; z-index: 900;" id="outnav">

    <div  id="topnav">

        <img src="img/logo.png"  style="max-width: 200px;"/>

        <ul>
            <li><a href="index.html">首页</a></li>
            <li id="globhouse" style="position: relative;"><a  >海外地产  <span class="caret"></span></a>
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

<!--面包导航-->
<div style="height: 50px; background: #333; line-height: 50px;">
    <div id="inner_mianbao">
        <ol class="pathnav" style="line-height: 50px; color: #FFF;">
            <li><a href="index.html">首页</a></li>
            <li><a >海外购房</a></li>

            <%--<li>&nbsp;购房定金和订金，到底哪个能退？</li>--%>
        </ol>
    </div>
</div>


<%--描述：以下是图片--%>

<div style="background: #333; width: 100%;">
    <div  id="house_focus_img">
        <!--轮播图上-->
        <div class="left">
            <div id="house_imgs">
                <div id="house_bigImg">
                    <ul>
                        <li>
                            <div class="project_img">
                                <dl>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469407540.jpg" class="img-responsive" alt="1531725469407540.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469298564.jpg" class="img-responsive"  alt="1531725469298564.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470105631.jpg" class="img-responsive"  alt="1531725470105631.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725897183244.jpg" class="img-responsive"  alt="1531725897183244.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725897401512.jpg" class="img-responsive"  alt="1531725897401512.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725897411022.jpg" class="img-responsive"  alt="1531725897411022.jpg"/></dd>
                                </dl>
                                <span class="house_imgs_lf2"></span><span class="house_imgs_rt2"></span>
                            </div>
                        </li>


                        <li>
                            <div class="project_img">
                                <dl>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469814719.jpg" class="img-responsive"  alt="1531725469814719.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469504434.jpg" class="img-responsive"  alt="1531725469504434.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469348449.jpg" class="img-responsive"   alt="1531725469348449.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469884208.jpg" class="img-responsive"   alt="1531725469884208.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469779814.jpg" class="img-responsive"   alt="1531725469779814.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469299782.jpg" class="img-responsive"   alt="1531725469299782.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469262729.jpg" class="img-responsive"   alt="1531725469262729.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470853850.jpg" class="img-responsive"   alt="1531725470853850.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470223422.jpg" class="img-responsive"   alt="1531725470223422.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725471963534.jpg" class="img-responsive"   alt="1531725471963534.jpg"/></dd>
                                </dl>
                                <span class="house_imgs_lf2"></span><span class="house_imgs_rt2"></span>
                            </div>
                        </li>

                        <li>
                            <div class="project_img">
                                <dl>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531728348991731.jpg" alt="1531728348991731.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531728348410827.jpg" alt="1531728348410827.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531728348271050.jpg" alt="1531728348271050.jpg"/></dd>
                                </dl>
                                <span class="house_imgs_lf2"></span><span class="house_imgs_rt2"></span>
                            </div>
                        </li>

                        <li>

                            <div class="project_img">
                                <dl>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470179075.jpg" alt="1531725470179075.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470455196.jpg" alt="1531725470455196.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470573225.jpg" alt="1531725470573225.jpg"/></dd>
                                </dl>
                                <span class="house_imgs_lf2"></span><span class="house_imgs_rt2"></span>
                            </div>
                        </li>

                        <li>
                            <div class="project_img">
                                <dl>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725471350588.jpg" alt="1531725471350588.jpg"/></dd>
                                    <dd><img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725471910731.jpg" alt="1531725471910731.jpg"/></dd>
                                </dl>
                                <span class="house_imgs_lf2"></span><span class="house_imgs_rt2"></span>
                            </div>
                        </li>
                    </ul>

                </div><!--house_bigImg-->

                <div id="house_smallImg">
                    <ul>
                        <li>
                            <img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469407540.jpg" alt="外景图"/>
                            <div class="bun_bg">外景图(6)</div>
                        </li>

                        <li>
                            <img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725469814719.jpg" alt="样板间"/>
                            <div class="bun_bg">样板间(10)</div>
                        </li>

                        <li>
                            <img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531728348991731.jpg" alt="户型图"/>
                            <div class="bun_bg">户型图(3)</div>
                        </li>

                        <li>
                            <img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725470179075.jpg" alt="周边配套"/>
                            <div class="bun_bg">周边配套(3)</div>
                        </li>

                        <li>
                            <img src="https://files.ausingroup.com/Uploads/Editor/20180716/1531725471350588.jpg" alt="区位图"/>
                            <div class="bun_bg">区位图(2)</div>
                        </li>
                    </ul>
                </div><!--house_smallImg-->
                <span class="house_imgs_lf"></span><span class="house_imgs_rt"></span>
                <div style="clear: both;"></div>
            </div><!--house_imgs-->



        </div><!--end left-->
        <div class="right">
            <h1>奥克兰核心地段住宅Union &amp; Co</h1>
            <p class="price">总价： <span>206万起</span>（人民币）NZD: 44.8万起（新西兰元）</p>
            <p class="location"><span class="glyphicon glyphicon-map-marker"></span>美国·佛罗里达州·奥兰多</p>
            <p class="focus_list">
                <span>精装修</span><span>学区</span><span>学区</span>
            </p>
            <ul>

                <li><span class="glyphicon glyphicon-credit-card"></span>套内35-95m²</li>
                <li><span class="glyphicon glyphicon-jpy"></span>首付10%</li>
                <li><span class="glyphicon glyphicon-king"></span>永久产权</li>
                <li><span class="glyphicon glyphicon-queen"></span>精品住宅</li>
                <li><span class="glyphicon glyphicon-knight"></span>精装交付</li>
                <li><span class="glyphicon glyphicon-equalizer"></span>可贷款</li>
            </ul>
            <p class="address"><b>项目地址：</b>加拿大蒙特利尔 1400 Boulevard René-Lévesque O, Montréal, QC H3G 1T6加拿大 </p>
            <p class="huxing"><b>主力户型：</b>一室一卫  (53m²)    一室一卫带阳台  (56m²)    两室两卫  (82m²)    两室两卫带阳台  (73m²)    两室两卫带阳 </p>
            <a href="#" class="zixun">预约咨询</a>
            <p class="telphone">
                <span class="glyphicon glyphicon-phone-alt"></span>  :
                400-123-456
            </p>
        </div><!--end right-->
        <div style="clear: both; height: 30px;"></div>
        <!--轮播图上 end-->
    </div>
</div>
<!--
    作者：langyamoren@163.com
    时间：2018-08-16
    描述：上部，图片轮播和右则完成
-->

<div style="width: 100%; background: #F2F2F2; height: 40px; z-index: 910;" id="out_house_desc">
    <div  style="width: 1200px; margin: 0 auto;" id="desc_menu">

        <ul>
            <li><a data-ids="#menu-01" href="#">项目简介</a></li>
            <li><a data-ids="#menu-02"  href="#">周边设施</a></li>
            <li><a data-ids="#menu-03"  href="#">特业配套</a></li>
            <li><a data-ids="#menu-04"  href="#">户型展示</a></li>
        </ul>
    </div>
</div>
<!--详情开始-->

<div  style="width: 1200px; margin: 0 auto;">
    <div class="house_detil_list">
        <h3 id="menu-01">项目简介</h3>
        <p>

            <b> 项目区位：</b> 15 – 17 Union Street, Auckland CBD<br />
            <b>开发商：</b>Conrad<br />
            <b>产权年限</b>：永久产权<br />
            <b>交房标准：</b>精装交付<br />
            <b> 可选户型：</b>一室 两室 三室<br />
            <b>能否贷款：</b>能 <br />

            Union & Co总价206万元起，首付仅需20万元，购房利息返还，无印花税。精装交付，可拎包入住，拥有永久产权。
            项目位于奥克兰市中心的维多利亚区，周边配套非常完善，学校、CBD、购物场所等环绕左右，生活便利。项目配套完善，泳池、健身房等等应有尽有。

        </p>
    </div>

    <div class="house_detil_list">
        <h3 id="menu-02">周边设施</h3>

        <h5 class="education_icon">教育<i>EDUCATION</i></h5><p></p><p><img src="http://www.ausingroup.com/Uploads/Editor/20180803/1533287444266217.jpg" title="1533287444266217.jpg" alt="学校.jpg"></p><p>项目周边教育资源丰富，从小学到大学应有尽有，可满足孩子从小到大的教育需求。距离奥克兰大学4km，开车10分钟即可到达。</p><p></p><h5 class="shopping_icon">购物<i>SHOPPING</i></h5><p></p><p><img src="http://www.ausingroup.com/Uploads/Editor/20180803/1533286723313055.jpg" title="1533286723313055.jpg" alt="购物.jpg"></p><p>项目毗邻Ponsonby购物区，距离皇后街2km，公交车5分钟即可到达。</p><p></p><h5 class="leisure_icon">休闲<i>LEISURE TIME</i></h5><p></p><p><img src="http://www.ausingroup.com/Uploads/Editor/20180803/1533287258201554.jpg" title="1533287258201554.jpg" alt="公园.jpg"></p><p>项目毗邻Western公园，距离维多利亚公园1km。</p><p></p><h5 class="traffic_icon">交通<i>TRANSPORTATION</i></h5><p></p><p><img src="http://www.ausingroup.com/Uploads/Editor/20180803/1533286477115045.jpg" title="1533286477115045.jpg" alt="交通.jpg"></p><p>项目距离公交站200米，邻近高速公路，可快速上高速，到达新西兰任意地方。</p><p></p><h5 class="hospital_icon">医院<i>HOSPITAL</i></h5><p></p><p><img src="http://www.ausingroup.com/Uploads/Editor/20180803/1533287689691535.jpg" title="1533287689691535.jpg" alt="医院.jpg"></p><p>项目距离奥克兰医院4km，开车10分钟即可到达，就医方便。</p><p></p>
    </div>

    <div class="house_detil_list">
        <h3 id="menu-03">特业配套</h3>
        <div class="cf_list">
            <p class="cf_title">
                <span class="glyphicon glyphicon-cutlery"></span>
                厨房配置:
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok-circle"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok-circle"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok-circle"></span>橱柜
            </p>
            <div style="clear: both;"></div>
        </div>

        <div class="cf_list">
            <p class="cf_title">
                <span class="glyphicon glyphicon-tint"></span>
                卫浴配置:
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <div style="clear: both;"></div>
        </div>

        <div class="cf_list">
            <p class="cf_title">
                <span class="glyphicon glyphicon-unchecked"></span>
                停车场:
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <div style="clear: both;"></div>
        </div>

        <div class="cf_list">
            <p class="cf_title">
                <span class="glyphicon glyphicon-tree-deciduous"></span>
                花园配置:
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <p class="cf_item">
                <span class="glyphicon glyphicon-ok"></span>橱柜
            </p>
            <div style="clear: both;"></div>
        </div>


    </div>

    <div class="house_detil_list">
        <h3 id="menu-04">户型展示</h3>
        <div class="huxing_show">
            <img src="http://www.ausingroup.com/Uploads/Picture/2018-05-11/5af563a318df4.jpg"  width="250" height="175"/>
            <p class="hx_title">一房一厅一卫+书房1个    套内面积50㎡</p>
            <p class="hx_price">总价：<span>¥210万</span>起</p>
            <a href="#" class="hx_detil">查看详情</a>

        </div>


        <div class="huxing_show">
            <img src="http://www.ausingroup.com/Uploads/Picture/2018-05-11/5af563a318df4.jpg"  width="250" height="175"/>
            <p class="hx_title">一房一厅一卫+书房1个    套内面积50㎡</p>
            <p class="hx_price">总价：<span>¥210万</span>起</p>
            <a href="#" class="hx_detil">查看详情</a>

        </div>


        <div class="huxing_show">
            <img src="http://www.ausingroup.com/Uploads/Picture/2018-05-11/5af563a318df4.jpg"  width="250" height="175"/>
            <p class="hx_title">一房一厅一卫+书房1个    套内面积50㎡</p>
            <p class="hx_price">总价：<span>¥210万</span>起</p>
            <a href="#" class="hx_detil">查看详情</a>

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
                <h5>huanqiujiayuan.com</h5>

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
<script type="text/javascript" src="js/carousel.js" ></script>

<script type="text/javascript">
    $(function(){
        /*$("#house_smallImg ul li").css("padding-right","10px");*/


        //单击详情切换菜单
        var tls= $('#desc_menu ul li > a');

        tls.each(function (i){

            $(this).click(function(){

                tls.each(function(){$(this).removeClass("act")});
                $(this).addClass('act');

                var temid=$(this).data("ids");
                /*  $(window).scrollTop($(temid).offset().top);*/
                var tohei=$(temid).offset().top;
                // body.animate({scrollTop:tohei }, 2000);
                // $("body").animate({scrollTop:tohei},slow);
                /*$(window).scrollTop(1200);*/
                $('body, html').animate({scrollTop:tohei-200},500);

            });
        });
        // tls.eq(0).click();

        //滚动条tab联动
        $(window).scroll(function(){
            //为页面添加页面滚动监听事件
            var wst =$(window).scrollTop(); //滚动条距离顶端值
            for (i=1; i<5; i++){
                var h = $("#menu-0"+i).offset().top-200;//加循环

                /*if(h<=wst){ //判断滚动条位置
                    $("#desc_menu ul li > a").removeClass("on"); //清除c类
                    $("#desc_menu ul li > a[href=h]").addClass("on");    //给当前导航加c类
                    $(".panel-bg").css("left",  $("#a"+i+i).position().left + "px");
                }*/
                if(h<=wst){
                    $("#desc_menu ul li > a").removeClass("act");
                    $("#desc_menu ul li > a[data-ids*="+i+"]").addClass("act");
                }
            }

        });
        //详情菜单置顶
        var elm1 = $('#out_house_desc');
        var startPos1 = $(elm1).offset().top-100;

        $.event.add(window, "scroll", function() {
            var p1 = $(window).scrollTop();
            $(elm1).css('position',((p1) > startPos1) ? 'fixed' : 'static');
            $(elm1).css('top',((p1) > startPos1) ?'80px' : '');
        });


        $("#house_smallImg li:eq(0),#house_bigImg li:eq(0) dl dd:eq(0)").addClass("on");
        /* 详情页房产图片展示 */
        $("#house_imgs").thumbnailImg({
            large_elem: "#house_bigImg",
            small_elem: "#house_smallImg",
            left_btn: ".house_imgs_lf",
            right_btn: ".house_imgs_rt",
            vis: 5,
            speed: "500"
        });
        var small_num = $("#house_smallImg ul").find("li").size(); //小图集的个数
        if (small_num <= 10) {
            $(".house_imgs_lf,.house_imgs_rt").hide();
        }else{}
        // 点击小图
        $("#house_smallImg ul li").click(function(){
            $('.project_img dl dd').removeClass("on");
            $('.project_img dl dd:first-child').addClass("on");
            $('.project_img dl').css({marginLeft: '0'});
        });
        // 点击左按钮
        $(".house_imgs_lf2").click(function(){
            var bigImg_region = $(this).closest("li").find('.project_img');//找到大图区域
            var w = bigImg_region.find("dl").find("dd").outerWidth(true); //单个大图片的宽度
            var thisindex = bigImg_region.find("dl").find(".on").index(); //当前选中的
            var li_num = bigImg_region.find("dl").find("dd").length; //图片的个数
            if(thisindex == 0){
                var thisnum = 0;
                // var thisnum = li_num-1;
                rollFun(bigImg_region,thisnum,w);
                $(".house_imgs_lf").click();
            }
            else{
                var thisnum = thisindex-1;
                rollFun(bigImg_region,thisnum,w);
            }
        });
        // 点击右按钮
        $(".house_imgs_rt2").click(function(){
            var bigImg_region = $(this).closest("li").find('.project_img');//找到大图区域
            var w = bigImg_region.find("dl").find("dd").outerWidth(true); //单个大图片的宽度
            var thisindex = bigImg_region.find("dl").find(".on").index(); //当前选中的
            var li_num = bigImg_region.find("dl").find("dd").length; //图片的个数
            if(thisindex == li_num-1){
                var thisnum = li_num-1;
                /*var thisnum = 0; */
                rollFun(bigImg_region,thisnum,w);
                $(".house_imgs_rt").click();
            }
            else{
                var thisnum = thisindex+1;
                rollFun(bigImg_region,thisnum,w);
            }
        });
        //动画效果
        function rollFun(item1,item3,item4){
            //大图向左滑动
            item1.find("dl").stop().animate({
                "marginLeft" : -(item3 * item4) + "px"
            });
            //选中
            item1.find("dl").find("dd").removeClass("on").eq(item3).addClass("on");
        }
        var t1=window.setInterval("$('.house_imgs_rt').click()", 5000);//1秒执行一次
        $(".house_con_lf").hover(function(){
            window.clearTimeout(t1);//去掉定时器
        },function(){
            t1=window.setInterval("$('.house_imgs_rt').click()", 5000);//1秒执行一次
        });

    });

</script>
</body>
</html>
