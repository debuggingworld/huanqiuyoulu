<%@ page import="com.hq.db.PageDiv" %>
<%@ page import="com.hq.bean.Article" %><%--
  @author zth
  @create  2019-05-20 10:32
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>资讯列表</title>
    <%@include file="header.jsp"%>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12" >
            <div class="row">
                <div class="col-sm-3" style="line-height: 50px">
                    &nbsp;&nbsp;&nbsp;<a href="admin/article">全部</a>
                    <c:forEach items="${channels}" var="channel">
                        &nbsp;&nbsp;&nbsp;<a href="admin/article?channel_id=${channel.id}">${channel.name}</a>
                    </c:forEach>
                </div>
                <div class="col-sm-8" style="line-height: 50px">
                    <form action="admin/article" method="post" class="form-inline">
                        <div class="form-group">
                            <input type="text" name="keyword" class="form-control" placeholder="请输入关键词">
                            <button type="submit" class="btn btn-info">搜索</button>
                        </div>
                    </form>
                </div>
            </div>

            <table class="table table-hover table-striped table-striped table-responsive" style="font-size: 12px">
                <tr><th>#</th><th>主图</th><th>标题</th><th>栏目</th><th>国家</th><th>时间</th><th>管理</th></tr>
                <c:forEach items="${pageDiv.list}" var="art" varStatus="vs">
                    <tr>
                        <td>${vs.count}</td>
                        <td><img src="${art.pic}" class="img-rounded" style="width: 40px"></td>
                        <td><a href="admin/article?action=show&id=${art.id}">${art.title}</a></td>
                        <td>${art.channelName}</td>
                        <td>${art.cityName}</td>
                        <td>${art.ctime}</td>
                        <td>
                            <a href="admin/article?action=edit&id=${art.id}" class="btn btn-sm btn-info"><i class="fa fa-edit">修改</i></a>
                            <a href="admin/article?action=del&id=${art.id}&channel_id=${art.channel_id}" class="btn btn-danger btn-sm"><i class="fa fa-close">删除</i></a>
                            <a href="admin/article?action=createhtml&id=${art.id}&channel_id=${art.channel_id}" class="btn btn-sm btn-success"><i class="fa fa fa-check-square-o">发布</i></a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <div class="row">
                <div class="col-sm-8 text-center">
                    <div class="btn-group">
                        <%
                            PageDiv<Article> pageDiv = (PageDiv<Article>)request.getAttribute("pageDiv");
                            if (null != pageDiv){
                        %>
                        <a href="admin/article?keyword=${keyword}&pageNo=<%=((pageDiv.getPageNO()-1)>1?(pageDiv.getPageNO()-1):1)%>&channel_id=${channel_id}" class="btn btn-white">
                            <
                        </a>
                        <%
                                for (int i = pageDiv.getStart(); i <= pageDiv.getEnd(); i++) {
                        %>
                        <a href="admin/article?keyword=${keyword}&pageNo=<%=i%>&channel_id=${channel_id}" class="btn btn-white"><%=i%></a>
                        <%
                                }
                        %>
                        <a href="admin/article?keyword=${keyword}&pageNo=<%=((pageDiv.getPageNO()+1)<pageDiv.getTotalPage()?(pageDiv.getPageNO()+1):pageDiv.getTotalPage())%>&channel_id=${channel_id}" class="btn btn-white">
                            >
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="col-sm-4">
                    <h4>当前第<span style="color: red">&nbsp;&nbsp;${pageDiv.pageNO}</span>/${pageDiv.totalPage}&nbsp;&nbsp;页总共&nbsp;&nbsp;${pageDiv.totalCount}&nbsp;&nbsp;条</h4>
                </div>
            </div>
        </div>
    </div>
</div>


<%@include file="booter.jsp"%>
</body>
</html>
