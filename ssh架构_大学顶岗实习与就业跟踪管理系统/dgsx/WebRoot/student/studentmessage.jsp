<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<form id="addform" action="#" method="post" class="definewidth m20" >
<c:choose>
	<c:when test="${sessionScope.student.classroom.teacher==null}">
	<div class="text-center"><h3>暂时没有分配负责指导老师</h3></div>
	</c:when>
	<c:otherwise>
		<table class="table table-bordered table-hover definewidth m10">
		<tr>
		<th>负责教师工号</th><th>负责教师姓名</th><th>负责教师级别</th><th>负责教师电话</th><th>负责教师QQ</th><th>QQ留言</th>
		</tr>
		<tr>
		<td>${sessionScope.student.classroom.teacher.teaid}</td>
		<td>${sessionScope.student.classroom.teacher.name}</td>
		<td>${sessionScope.student.classroom.teacher.level}</td>
		<td>${sessionScope.student.classroom.teacher.phone}</td>
		<td>${sessionScope.student.classroom.teacher.qqid}</td>
		<td>
			<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=${sessionScope.student.classroom.teacher.qqid}&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:${sessionScope.student.classroom.teacher.qqid}:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
		</td>
		</tr>
		</table>
	</c:otherwise>
</c:choose>
</form>
</body>
</html>