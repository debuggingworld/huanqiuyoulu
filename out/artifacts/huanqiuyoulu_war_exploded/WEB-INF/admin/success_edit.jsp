<%--
  @author zth
  @create  2019-05-28 21:37
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改成功案例</title>
    <%@include file="header.jsp"%>
    <script charset="utf-8" src="kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="kindeditor/lang/zh-CN.js"></script>
</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>修改成功案例</h5>
    </div>
    <div class="ibox-content">
        <form action="admin/successful" method="post" class="form-horizontal">
            <input type="hidden" name="action" value="saveEdit">
            <input type="hidden" name="id" value="${successful.id}">
            <div class="form-group">
                <div class="col-sm-4 ">
                    <input type="text" value="${successful.name}" class="form-control" name="name" placeholder="请输入姓名">
                </div>
                <div class="col-sm-4 ">
                    <input type="text" value="${successful.house}" class="form-control" placeholder="选择的项目" name="house" >
                </div>
            </div>
            <div class="form-group ">

                <div class=col-sm-4>
                    <select name="level" class="form-control">
                        <%
                            for (int i = 9; i >0 ; i--) {
                                request.setAttribute("temi",i);
                        %>
                        <option value="<%=i%>" <c:if test="${successful.level==temi}">selected="selected"</c:if>>
                            <%=i%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class=col-sm-4>
                    <input class="form-control" value="${successful.why}" type="text" name="why"  placeholder="选择理由">
                </div>
            </div>


            <div class="form-group col-sm-12 ">
                <div class="col-sm-12 pull-left" >
                    <textarea col="23" rows="10" name="dis" id="txt1" class="form-control" style="width:100%;height:200px;" >
                        ${successful.dis}
                    </textarea>

                </div>
            </div>


            <div class="form-group ">
                <label class="col-sm-1 control-label">项目图：</label>
                <div class="col-sm-1">
                    <input type="hidden" value="${successful.pic1}" id="pic1" name="pic1"/>
                    <img id="uppic1" src="${successful.pic1}" style="width: 50px "  class="img-rounded">
                </div>

                <label class="col-sm-1 control-label">客户头像：</label>
                <div class="col-sm-1">
                    <input type="hidden" value="${successful.pic2}" id="pic2" name="pic2"/>
                    <img id="uppic2" src="${successful.pic2}" style="width: 50px "  class="img-rounded">
                </div>

                <div class="col-sm-2 ">
                    <div class="col-sm-1">

                    </div>
                    <button type="submit" class="brn btn-info" style="padding: 5px;margin-top: 30px ">修改成功案例</button>
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

        K('#uppic1').click(function() {
            editor.loadPlugin('image', function() {
                editor.plugin.imageDialog({

                    uploadJson:'admin/fileupload',
                    imageUrl : K('#pic1').val(),
                    clickFn : function(url, title, width, height, border, align) {
                        K('#pic1').val(url);
                        document.getElementById("uppic1").src=url;
                        editor.hideDialog();
                    }
                });
            });
        });

        K('#uppic2').click(function() {
            editor.loadPlugin('image', function() {
                editor.plugin.imageDialog({

                    uploadJson:'admin/fileupload',
                    imageUrl : K('#pic2').val(),
                    clickFn : function(url, title, width, height, border, align) {
                        K('#pic2').val(url);
                        document.getElementById("uppic2").src=url;
                        editor.hideDialog();
                    }
                });
            });
        });
    });
</script>

</body>
</html>

