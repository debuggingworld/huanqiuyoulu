<%--
  @author zth
  @create  2019-05-09 16:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>

    <title>焦点广告管理</title>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>焦点广告 <small>焦点广告图片</small></h5>
                </div>
                <div class="ibox-content">
                    <h2>上传焦点广告<br></h2>

                    <form class="form-inline" method="post" enctype="multipart/form-data" action="admin/focuspic?action=uploadPic" >
                        <div class="form-group">
                            <input type="text" class="form-control" name="dis" placeholder="焦点图描述">
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
                            <div >
                                <%--<div class="input-group">--%>
                                    <%--<input id='location' class="form-control" onclick="$('#i-file').click();">--%>
                                    <%--<label class="input-group-btn">--%>
                                        <%--<input type="button" id="i-check" value="浏览文件" class="btn btn-primary" onclick="$('#i-file').click();">--%>
                                    <%--</label>--%>
                                <%--</div>--%>
                                <input type="file" class="form-control" name="pic" placeholder="选择文件">
                            </div>
                            <input type="file" name="pic" id='i-file'  onchange="$('#location').val($('#i-file').val());" style="display: none">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="link" placeholder="外链">
                        </div>
                        <button type="submit" class="btn btn-info">增加焦点图</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
</body>
</html>
