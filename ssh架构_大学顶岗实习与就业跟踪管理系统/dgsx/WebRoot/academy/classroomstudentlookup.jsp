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
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">学号姓名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="学号/姓名/电话/身份证..." value="${sessionScope.findinfo}" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" onclick="onfind()">查询</button>
    &nbsp;&nbsp;<button type="button" class="btn btn-default" id="backid" onclick="onback()">返回</button>
</form>
<input type="hidden" value="${sessionScope.stuclassroom.academy.academyid}" id="academyid"/>
<input type="hidden" value="${sessionScope.stuclassroom.classid}" id="classid"/>
<table class="table table-bordered table-hover definewidth m10" id="studenttable">
<caption class="text-center">${sessionScope.stuclassroom.classname}</caption>
    <thead>
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>学院班级</th>
        <th>电话</th>
        <th>身份证</th>
        <th>入学日期</th>
        <th>QQ号</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.studentlist}" var="student">
        <tr>
        	<td><c:out value="${student.stuid}"/></td>
			<td><c:out value="${student.name}"/></td>
			<td><c:out value="${student.sex}"/></td>
			<td><c:out value="${student.classroom.academy.academyname}"/>&nbsp;&nbsp;<c:out value="${student.classroom.classname}"/></td>
			<td><c:out value="${student.phone}"/></td>
			<td><c:out value="${student.idcard}"/></td>
			<c:set var="stringtime" value="${fn:split(student.schooltime, ' ')}" />
			<td><c:out value="${stringtime[0]}"/></td>
			<td><c:out value="${student.qqid}"/></td>
		</tr>
		</c:forEach>
</table>
<div>
<input type="hidden" value="${sessionScope.pagenumber}" id="pagenumber"/>
<input type="hidden" value="${sessionScope.maxpagenumber}" id="maxpagenumber"/>
	<ul class="pager">
  		<li><a href="javascript:void(0)"  onclick="onprevious()">上一页</a></li>
  		<li><a href="javascript:void(0)"  onclick="onnext()">下一页</a></li>
	</ul>
</div>
</body>
</body>
</html>
<script>
function onfind()
{
	window.location.href="../student.do?method=studentAcademyFindByClassIDExecute&classid="+$("#classid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
}
function onback()
{
	window.location.href="../classroom.do?method=academyClassroomFindExecute&academyid="+$("#academyid").val();
}
function onprevious()
{
	if(parseInt($("#pagenumber").val())<=1)
	{
		alert('已经是首页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())-1;
	window.location.href="../student.do?method=studentAcademyFindByClassIDExecute&classid="+$("#classid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../student.do?method=studentAcademyFindByClassIDExecute&classid="+$("#classid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
</script>