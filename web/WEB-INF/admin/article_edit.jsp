
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>资讯资讯:${article.title}</title>
    <%@include file="header.jsp"%>
    <script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>修改资讯</h5>
    </div>
    <div class="ibox-content">
        <form action="admin/article" method="post" class="form-horizontal">
            <input type="hidden" name="action" value="saveEdit">
            <input type="hidden" name="id" value="${article.id}">
            <div class="form-group">
                <div class="col-sm-8 ">
                    <input type="text" class="form-control" name="title" placeholder="请输入标题" value="${article.title}">
                </div>
                <div class="col-sm-4 ">
                    <select name="channel_id" class="form-control">
                        <c:forEach items="${channels}" var="channel">
                            <option value="${channel.id}" <c:if test="${channel.id == article.channel_id}"> selected</c:if> >${channel.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-4 ">
                    <input type="text" class="form-control" name="keywords" value="${article.keywords}" placeholder="请输入标签，用逗号隔开">
                </div>

                <div class="col-sm-4 ">
                    <select name="city_id" class="form-control">
                        <c:forEach items="${countrys}" var="country">
                            <option value="${country.id}" <c:if test="${country.id == article.city_id}"> selected</c:if> >${country.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-4 ">
                    <select name="level" class="form-control">
                        <%
                            for (int i = 9; i >0 ; i--) {
                                request.setAttribute("leveItem",i);
                        %>
                        <option value="<%=i%>" <c:if test="${leveItem == article.level}"> selected</c:if> ><%=i%></option>
                        <%
                            }
                        %>
                    </select>
                </div>
            </div>

            <%--正文--%>
            <div class="form-group col-sm-12 ">
                <div class="col-sm-12 pull-left" >
                    <textarea col="23" rows="10" name="content" id="txt1" class="form-control" style="width:100%;height:200px;" >${article.content} </textarea>

                </div>
            </div>


            <div class="form-group ">
                <label class="col-sm-2 control-label">主图：</label>
                <div class="col-sm-3">
                    <input type="hidden" id="pic" value="${article.pic}" name="pic"/>
                    <c:choose>
                        <c:when test="${empty article.pic }">
                            <img id="uppic01" src="images/upload.jpg" style="width: 50px "  class="img-rounded">
                        </c:when>
                        <c:otherwise>
                            <img id="uppic01" src="${article.pic}" style="width: 50px "  class="img-rounded">
                        </c:otherwise>
                    </c:choose>

                </div>
                <div class="col-sm-2 ">
                    <button type="submit" class="brn btn-info" style="padding: 5px;margin-top: 30px ">保存修改</button>
                </div>
            </div>

        </form>
    </div>
</div>

<%@include file="booter.jsp"%>

<script>
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
