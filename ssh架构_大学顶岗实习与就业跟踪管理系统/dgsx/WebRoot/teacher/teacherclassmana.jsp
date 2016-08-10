<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
        <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/classroom.js'></script>
</head>
<body>
<input type="hidden" value="${sessionScope.teacherinfo.teaid}" id="teaid"/>
<table class="table table-bordered table-hover definewidth m10" id="classtable">
<caption class="text-center">${sessionScope.teacherinfo.name}-负责班级列表</caption>
    <thead>
    <tr>
        <th>班级id</th>
        <th>班级名称</th>
        <th>班级简介</th>
        <th>查看学生</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.teacherinfo.classrooms}" var="classroom">
        <tr>
        	<td><c:out value="${classroom.classid}"/></td>
			<td><c:out value="${classroom.classname}"/></td>
			<td><c:out value="${classroom.classdescr}"/></td>
			<td><a href="../student.do?method=studentAcademyFindByClassIDExecute1&classid=<c:out value="${classroom.classid}"/>" >查看学生</a></td>
		</tr>
		</c:forEach>
</table>

</body>
</html>