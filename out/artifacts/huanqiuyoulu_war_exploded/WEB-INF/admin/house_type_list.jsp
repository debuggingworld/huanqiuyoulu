<%--
  @author zth
  @create  2019-05-18 12:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>楼盘户型管理</title>
    <%@include file="header.jsp"%>
    <style type="text/css">
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
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>楼盘户型管理
                        <small style="font-size: 12px; font-weight: bold; margin-left: 30px;">${house.name}</small>
                    </h5>
                </div>
            </div>

            <%--content--%>
            <div class="ibox-content" style="font-size:12px;">
                <div style="width: 100%">
                    <form action="/admin/type_house?action=saveAdd" method="post" enctype="multipart/form-data" class="form-inline">
                        <input type="hidden" name="house_id" value="${house.id}">
                        <input type="text" name="dis" placeholder="户型描述" class="form-control">
                        <input type="text" name="area" placeholder="户型面积" class="form-control">
                        <input type="number" step="any" name="price"  placeholder="户型价格" class="form-control" required>
                        <select name="level" class="form-control">
                        <%
                            for (int i =9 ; i >0 ; i--) {
                        %>
                            <option value="<%=i%>"><%=i%></option>
                        <%
                            }
                        %>
                        </select>
                        <%--图片选择框--%>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="请选择上传图片" readonly id="fileName">
                        </div>
                        <div class="form-group " >
                            <div class="form-control"  style="padding: 0px">
                                <a href="javascript:;" class="file " style="width: 100%" >选择图片
                                    <input type="file" required onchange="document.getElementById('fileName').value=this.value"  name="pic">
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="form-control" style="padding: 0px">
                                <button class="btn btn-info " type="submit" >添加户型</button>
                            </div>
                        </div>
                    </form>
                    <div style="clear: both;"></div>
                </div>

                <%--展示户型--%>
                <div style="padding-top: 30px" >
                    <table class="table table-hover table-condensed table-responsive" style="font-size: small">
                        <tr><th>ID</th><th>图片</th><th>描述</th><th>价格</th><th>面积</th><th>排序<th>管理</th></tr>

                        <c:forEach items="${huxings}" var="huxing" varStatus="vs">

                            <form action="admin/type_house" method="post" class="form-group">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="house_id" value="${huxing.house_id}">
                                <input type="hidden" name="id" value="${huxing.id}">
                                <tr style="padding: 5px 0px">
                                    <td>${vs.count}</td>
                                    <td><img src="${huxing.path}" class="img-rounded " style="width: 50px"></td>
                                    <td><input type="text" name="dis"  class="form-control" value="${huxing.dis}"></td>
                                    <td><input type="text" name="price" class="form-control" value="${huxing.price}"></td>
                                    <td><input type="text" name="area" class="form-control" value="${huxing.area}"></td>
                                    <td>
                                        <select name="level" class="form-control">
                                            <%
                                                for(int i=9;i>0;i--)
                                                {
                                                    request.setAttribute("temi", i);
                                            %>
                                            <option value="<%=i%>" <c:if test="${temi==huxing.level}">selected="selected"</c:if>><%=i%></option>
                                            <%
                                                }
                                            %>
                                        </select>
                                    </td>
                                    <td>
                                        <button type="submit" class="btn btn-info btn-sm">
                                            <i class="fa fa-edit"></i>修改
                                        </button>
                                        <a href="admin/type_house?action=delImg&id=${huxing.id}&hid=${house.id}&path=${huxing.path}"  class="btn btn-danger btn-sm">
                                            <i class="fa fa-close"></i>删除
                                        </a>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </table>
                    <div style="clear: both;">
                </div>
            </div>
        </div>
            <%--end content --%>
        </div>
    </div>
</div>




<%@include file="booter.jsp"%>
</body>
</html>
