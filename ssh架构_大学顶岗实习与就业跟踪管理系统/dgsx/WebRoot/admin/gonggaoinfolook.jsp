<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
</head>
<body>
<div class="m30"></div>
<div class="container" style="border:1px solid #ccc;">
	<div class="text-center m20"><h1>${sessionScope.gonggaoinfolook.title}</h1></div>
	
	<div class="text-center m20">
	<small>
	发布时间:<em>${sessionScope.gonggaoinfolook.addtime}</em>&nbsp;&nbsp;&nbsp;&nbsp;浏览量:<em>${sessionScope.gonggaoinfolook.looknum}</em>
	</small></div>
	
	<div class="row">
	 <div class="col-md-10 col-md-offset-1">
 	<div class="m20">
	${sessionScope.gonggaoinfolook.content}
 	</div>
 	<div class="m20" >
 		<h4 class="title">附件</h4>
 		<c:set var="filepathlist" value="${fn:split(sessionScope.gonggaoinfolook.filepath, '#')}" />
 		<c:set var="filenamelist" value="${fn:split(sessionScope.gonggaoinfolook.filename, '#')}" />
		<c:forEach items="${filepathlist}" var="filepath"  varStatus="status">
			<p><a href="../servlet/fileDownloadServlet?filepath=${filepath}&filename=${filenamelist[status.index]}">${filenamelist[status.index]}</a></p>
		</c:forEach>
 	</div>
 	<hr style="height:3px;border:none;border-top:3px double red;">
	<div class="text-center"><a href="javascirpt:void(0)" onclick="window.close()">关闭页面</a></div>
	 </div>
	</div>
</div>
<div class="m30"></div>
</body>
</html>
