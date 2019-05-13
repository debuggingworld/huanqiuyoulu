<%--
  @author zth
  @create  2019-05-13 11:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>增加国家/城市</title>
    <%@include file="header.jsp"%>
</head>
<body>
<div class="ibox float-e-margins">
    <div class="ibox-title">
        <h5>增加国家或城市</h5>
    </div>
    <div class="ibox-content">
        <form action="admin/city" method="post" class="form-horizontal">
            <input type="hidden" name="action" value="saveadd">
            <div class="form-group">
                <div class="col-sm-4 ">
                    <input type="text" class="form-control" name="name" placeholder="请输入国家或城市名字">
                </div>
                <div class="col-sm-4 ">
                    <select name="parent_id" class="form-control">
                        <option value="0">国家</option>
                        <c:forEach items="${cities}" var="city">
                            <option value="${city.id}">${city.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-4 ">
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
            </div>

            <div class="form-group">
                <div class="col-sm-12">
                    国家/城市特色描述：
                    <textarea name="dis" class="form-control" id="txt1">

                    </textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-1 control-label">主图：</label>
                <div class="col-sm-1">
                    <input type="hidden" id="pic" name="pic"/>
                    <img src="images/upload.jpg" class="img-rounded">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-lg-offset-3">
                    <button
                </div>
            </div>
        </form>
    </div>
</div>



<%@include file="booter.jsp"%>
</body>
</html>
