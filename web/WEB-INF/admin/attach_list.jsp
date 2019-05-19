<%@ page import="java.util.List" %>
<%@ page import="com.hq.bean.Focuspic" %>
<%@ page import="com.hq.db.PageDiv" %>
<%@ page import="com.hq.bean.Attach" %>
<%@ page import="com.hq.servlet.core.Action" %><%--
  @author zth
  @create  2019-05-09 16:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="header.jsp"%>
    <title>附件管理</title>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>附件管理 </h5>
                </div>
                <div class="ibox-content">

                    <%
                        PageDiv<Attach> pageDiv = (PageDiv<Attach>) request.getAttribute("pageDiv");
                    %>
                    <div class="row">
                        <div class="col-sm-12 text-center">
                            <form action="admin/attach" method="post">
                                <input type="hidden" name="action" value="del"/>
                                <div class="col-sm-3">
                                    <button type="button" class="btn btn-info" id="selectall">全选</button>
                                    <button type="submit" class="btn btn-danger pull-right">删除</button>
                                </div>
                                <div class="col-sm-9">
                                    <div class="btn-group">
                                        <a href="admin/attach?pageNo=<%=((pageDiv.getPageNO()-1)>1?(pageDiv.getPageNO()-1):1)%>" class="btn btn-white">
                                            &lt;
                                        </a>
                                        <%
                                            for (int i = pageDiv.getStart(); i <=pageDiv.getEnd() ; i++) {
                                        %>
                                        <a href="admin/attach?pageNo=<%=i%>" class="btn btn-white"><%=i%></a>
                                        <%
                                            }
                                        %>
                                        <a href="admin/attach?pageNo=<%=((pageDiv.getPageNO()+1)<pageDiv.getTotalPage()?(pageDiv.getPageNO()+1):(pageDiv.getTotalPage()))%>" class="btn btn-white">
                                            &gt;
                                        </a>

                                    </div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    当前第<span style="color: red">${pageDiv.getPageNO()}</span>/${pageDiv.getTotalPage()}页 &nbsp;&nbsp;总共${pageDiv.getTotalCount()}条
                                </div>
                                <%
                                    if (null != pageDiv && pageDiv.getList() != null){
                                        for (Attach attach:pageDiv.getList()) {
                                            String oldName = attach.getOldname().toLowerCase();
                                %>
                                <div style="display: inline-block;padding-top: 10px;padding-right: 20px " >
                                <%
                                            if (oldName.endsWith(".jpg")||oldName.endsWith(".png")||oldName.endsWith(".gif")){
                                %>
                                    <img class="img-rounded" style="width: 230px ;" src="<%=attach.getNewpath()%> ">
                                <%
                                            }else {
                                %>
                                    <div class="icon"><i class="fa fa-file"></i></div>
                                <%
                                            }
                                %>
                                    <div style="background: #eeeeee; ">
                                        <p style="padding: 10px 0px 0px 0px; margin: 0px"><%=attach.getOldname()%></p>
                                        <p style="display: inline-block; padding: 0px;margin: 0px">创建时间:<%=attach.getCreatetime()%></p>
                                        <small>
                                            <input type="checkbox" name="ids" class="i-checks" value="<%=attach.getId()%>">
                                        </small>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="booter.jsp"%>
<script type="text/javascript">
    $(function () {
        $("#selectall").click(function () {
            if ($(this).text() == "全选") {
                $("input[name='ids']").prop("checked",true);
                $(this).html("取消");
            }else {
                $("input[name='ids']").prop("checked",false);
                $(this).html("全选");
            }
        });
    });
</script>
</body>
</html>
