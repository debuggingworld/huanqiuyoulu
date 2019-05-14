<%--
  @author zth
  @create  2019-05-14 15:33
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改国家/城市</title>
    <%@include file="header.jsp"%>
    <style>
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>修改国家或城市</h5>
    </div>
    <div class="ibox-content">
        <form action="admin/city" method="post" class="form-horizontal">
            <input type="hidden" name="action" value="saveedit">
            <input type="hidden" name="id" value="${city.id}">

            <div class="form-group">
                <div class="col-sm-4 ">
                    <input type="text" class="form-control" name="name" value="${city.name}" placeholder="请输入国家或城市名字">
                </div>
                <div class="col-sm-4 ">
                    <select name="parent_id" class="form-control">
                        <option value="0">国家</option>
                        <c:forEach items="${countrys}" var="count">
                            <option value="${count.id}"
                                    <c:if test="${count.id == city.parent_id}">
                                            selected="selected"
                                    </c:if>
                            >
                                    ${count.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-4 ">
                    <select name="level" class="form-control">
                        <%
                            for (int i = 9; i >0 ; i--) {
                                request.setAttribute("temi",i);
                        %>
                        <option value="<%=i%>"
                                <c:if test="${temi == city.level}">
                                    selected="selected"
                                </c:if>
                        >
                            <%=i%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-12">
                    国家/城市特色描述：
                    <textarea name="dis" class="form-control" id="txt1">
                        ${city.dis}
                    </textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-1 control-label">主图：</label>
                <div class="col-sm-1">
                    <input type="hidden" id="pic" name="pic" value="${city.pic}"/>
                    <img id="uppic01" src="${city.pic}" style="width: 50px" class="img-rounded">
                </div>
                <div class="col-sm-3">
                    是否显示：<input type="checkbox" value="1" name="display" <c:if test="${city.display==1}"> checked="checked"</c:if>/>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-4">
                    <button type="submit" class="brn btn-primary" style="padding: 5px">修改国家或城市</button>
                </div>
            </div>
        </form>
        <hr/>
        <h3>图集管理</h3>

        <form class="form-inline" method="post" enctype="multipart/form-data" action="admin/city?action=uploadCityPic" >
            <input type="hidden" name="country_id" value="${city.id}">
            <div class="form-group">
                <input type="dis" class="form-control" required maxlength="45" name="dis" placeholder="图片描述">
            </div>
            <div class="form-group">
                <select name="level" class="form-control">
                    <%
                        for (int i = 9; i >0 ; i--) {
                    %>
                    <option value="<%=i%>"><%=i%></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <input type="text" required class="form-control" placeholder="请选择上传图片" readonly id="fileName">
            </div>
            <div class="form-group ">
                <div class="form-control"  style="padding: 0px">
                    <a href="javascript:;" class="file " style="width: 100%" >选择图片
                        <input type="file" required onchange="document.getElementById('fileName').value=this.value"  name="pic">
                    </a>
                </div>
            </div>

            <div class="form-control " style="padding: 0px;margin: 0px">
                <button type="submit" class="btn btn-info" >增加图片</button>
            </div>
        </form>

        <hr>
        <%
            System.out.println(request);
        %>
        <ul>
            <c:forEach items="${cityPics}" var="cpic">
                <li>
                    <form action="admin/city" class="form-inline" method="post">
                        <input type="hidden" name="action" value="cityspicupdate">
                        <img src="${cpic.path}" class="img-rounded" style="width:35px ">
                        <input type="hidden" name="city_id" value="${cpic.city_id}">
                        <input type="hidden" name="id" value="${cpic.id}">

                        <div class="form-group">
                            <select name="level" class="form-control">
                                <%
                                    for (int i = 9; i >0 ; i--) {
                                        request.setAttribute("tti",i);
                                %>
                                <option value="<%=i%>" <c:if test="${tti == cpic.level}">selected="selected"</c:if>><%=i%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <input type="text" class="form-control" name="dis" placeholder="图片描述" value="${cpic.dis}">
                        </div>
                        <input type="submit" class="btn btn-xs btn-primary" value="修改">
                        <a href="admin/city?action=cityspicdel&id=${cpic.id}&path=${cpic.path}&cityid=${cpic.city_id}" class="btn btn-xs btn-danger">删除</a>
                    </form>
                </li>
            </c:forEach>
        </ul>




    </div>
</div>

<%@include file="booter.jsp"%>
<script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
<script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>

<script>
    KindEditor.ready(function (K) {
        window.editor = K.create('#txt1',{
                uploadJson:'admin/fileupload'
            }
        );

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
