
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>增加旅行</title>
    <%@include file="header.jsp"%>
    <script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>增加旅行</h5>
    </div>
    <div class="ibox-content">
        <form action="admin/travel" method="post" class="form-horizontal">
            <input type="hidden" name="action" value="saveAdd">
            <div class="form-group">
                <div class="col-sm-5 ">
                    <input type="text" class="form-control" name="title" placeholder="请输入标题">
                </div>
                <div class="col-sm-5 ">
                    <input id="hello" placeholder="出发时间：年-月-日" name="depart" class="laydate-icon form-control layer-date">
                </div>
            </div>
            <div class="form-group ">

                <div class=col-sm-5>
                    <input class="form-control" type="text" name="city"  placeholder="发出城市">
                </div>
                <div class=col-sm-5>
                    <input class="form-control" type="text" name="visitcity"  placeholder="访问城市">
                </div>
            </div>

            <%--正文--%>
            <div class="form-group col-sm-12 ">
                <div class="col-sm-12 pull-left" >
                    <textarea col="23" rows="10" name="content" id="txt1" class="form-control" style="width:100%;height:200px;" > </textarea>

                </div>
            </div>


            <div class="form-group ">
                <label class="col-sm-2 control-label">主图：</label>
                <div class="col-sm-3">
                    <input type="hidden" id="pic" name="pic"/>
                    <img id="uppic01" src="images/upload.jpg" style="width: 50px "  class="img-rounded">
                </div>
                <div class="col-sm-2 ">
                    <button type="submit" class="brn btn-info" style="padding: 5px;margin-top: 30px ">增加旅行</button>
                </div>
            </div>

        </form>
    </div>
</div>

<%@include file="booter.jsp"%>

<script>
    laydate({
        elem: '#hello', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });

    KindEditor.ready(function (K) {
        window.editor = K.create('#txt1',{
            uploadJson : 'admin/fileupload'
        });

        K('#uppic01').click(function() {
            editor.loadPlugin('image', function() {
                editor.plugin.imageDialog({

                    uploadJson:'admin/fileupload',
                    imageUrl : K('#pic').val(),
                    clickFn : function(url, title, width, height, border, align) {
                        K('#pic').val(url);
                        document.getElementById("uppic01").src=url;
                        editor.hideDialog();
                    }
                });
            });
        });
    });
</script>

</body>
</html>
