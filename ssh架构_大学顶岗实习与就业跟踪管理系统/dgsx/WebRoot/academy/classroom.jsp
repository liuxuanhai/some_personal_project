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
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">班级名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="班级名称" value="${sessionScope.findinfo}">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" onclick="onfind()">查询</button>
</form>
<input type="hidden" value="${sessionScope.classroomacademy.academyid}" id="academyid"/>
<table class="table table-bordered table-hover definewidth m10" id="classtable">
<caption class="text-center">${sessionScope.classroomacademy.academyname}</caption>
    <thead>
    <tr>
        <th>班级id</th>
        <th>班级名称</th>
        <th>班级简介</th>
        <th>班级指导教师</th>
        <th>查看学生</th>
        <th>分配指导教师</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.classroomlist}" var="classroom">
        <tr>
        	<td><c:out value="${classroom.classid}"/></td>
			<td><c:out value="${classroom.classname}"/></td>
			<td><c:out value="${classroom.classdescr}"/></td>
			<td>
			   <c:choose>
		       <c:when test="${classroom.teacher==null}">
		                      未分配
		       </c:when>
		       <c:otherwise>
		             ${classroom.teacher.name}
		       </c:otherwise>
			</c:choose>
			</td>
			<td><a href="../student.do?method=studentAcademyFindByClassIDExecute&classid=<c:out value="${classroom.classid}"/>" >查看学生</a></td>
			<td><a href="../academy.do?method=academyFindOneExecute&classid=${classroom.classid}&academyid=${sessionScope.classroomacademy.academyid}">分配教师</a></td>
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
</html>
<script>
function onprevious()
{
	if(parseInt($("#pagenumber").val())<=1)
	{
		alert('已经是首页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())-1;
	window.location.href="../classroom.do?method=academyClassroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../classroom.do?method=academyClassroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onfind()
{
	window.location.href="../classroom.do?method=academyClassroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
}
</script>