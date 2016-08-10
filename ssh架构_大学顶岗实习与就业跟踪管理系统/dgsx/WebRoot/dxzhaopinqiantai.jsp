<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Administrator" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("mess")=="wrong") out.println("<script type=text/javascript>$('.popover-user').popover('show')</script>");
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>大型招聘</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="scripts/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/navbar.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/index.css" rel="stylesheet">
	<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/doajax.js'></script>
</head>
<body>
<div class="container">
<div class="m10"></div>
<!-- Static navbar -->
<div class="row">
<div class="col-sm-12">
      <nav class="navbar navbar-default" >
                <div class="container-fluid">
          <div class="navbar-header" style="font-size: 20px;">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <span class="navbar-brand">高校顶岗实习与就业跟踪系统</span>
            
          </div>
          <div id="navbar" class="navbar-collapse collapse" style="font-size: 18px;">
            <ul class="nav navbar-nav">
              <li ><a href="<%=path %>/index.jsp">首页</a></li>
              <li ><a href="qiantai.do?method=gonggaoIndexExecute">新闻公告</a></li>
              <li><a href="qiantai.do?method=ptzhaopinIndexExecute">普通招聘</a></li>
              <li class="active"><a href="qiantai.do?method=dxzhaopinIndexExecute">大型招聘</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      </div>
</div>

<div class="m20">
</div>
	<div class="form-inline">
	<input type="text" class="form-control" id="findinfo" value="${sessionScope.findinfo }" placeholder="关键字"/>&nbsp;&nbsp;
	<input type="button" class="btn btn-primary" id="findbtn" value="查询"/>
	</div>
	<div class="m20">
	<table style="table-layout:fixed;width:90%" >
	        <c:forEach items="${sessionScope.dxzhaopinlist}" var="dxzhaopin">
	        <tr class="text-left" height="30px">
				<td  style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:80%">
				<a target="_brank" href="qiantai.do?method=dxzhaopinLookExecute&dxzhaopinid=<c:out value="${dxzhaopin.id}"/>">
				<c:out value="${dxzhaopin.title}"/></a></td>
				<td><c:out value="${dxzhaopin.addtime}"/></td>
			</tr>
			</c:forEach>
	</table>
	</div>
	<div>
	<input type="hidden" value="${sessionScope.pagenumber}" id="pagenumber"/>
	<input type="hidden" value="${sessionScope.maxpagenumber}" id="maxpagenumber"/>
		<ul class="pager">
	  		<li><a href="javascript:void(0)"  onclick="onprevious()">上一页</a></li>
	  		<li><a href="javascript:void(0)"  onclick="onnext()">下一页</a></li>
		</ul>
	</div>
	
	
</div>

</body>

</html>
<script>
function onprevious()
{
	if(parseInt($("#pagenumber").val())==1)
	{
		alert('已经是首页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())-1;
	window.location.href="qiantai.do?method=dxzhaopinIndexExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())==parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="qiantai.do?method=dxzhaopinIndexExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}

// 页面加载后绑定事件
$(function () {
	$('#findbtn').click(function(){
	window.location.href="qiantai.do?method=dxzhaopinIndexExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
	});
  });
</script>