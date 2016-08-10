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
<script type='text/javascript' src='../dwr/interface/studentdocument.js'></script>
</head>
<body>

<input class="hide" id="hidenteacherid" value="${sessionScope.teacherid}"/>
<input class="hide" id="hidenclassid" value="${sessionScope.classid}"/>
<input class="hide" id="hidenpapertype" value="${sessionScope.papertype}"/>
<form id="addform" action="#" method="post" class="definewidth m20" >
<div class="form-inline definewidth">
	<label for="name">班级</label>&nbsp;&nbsp;
	<select id="classid" class="form form-control"> 
	<c:forEach items="${sessionScope.teacher.classrooms}" var="classroom">
	<option value="<c:out value="${classroom.classid}"/>"><c:out value="${classroom.classname}"/></option>
	</c:forEach>
	</select>&nbsp;&nbsp;
	<input type="text" class="form-control" id="findinfo" value="${sessionScope.findinfo}" placeholder="学号/姓名" />
	<input id="findbtn" type="button" class="btn btn-primary" onclick="onfindinfo()" value="查询"/>
</div>
<table class="table table-bordered table-hover definewidth m10" id="doctable">
<caption class="text-center">
	<c:choose>
	<c:when test="${sessionScope.papertype=='0'}">实习周记</c:when>
	<c:when test="${sessionScope.papertype=='1'}">实习报告</c:when>
	<c:when test="${sessionScope.papertype=='2'}">三方协议</c:when>
	<c:when test="${sessionScope.papertype=='3'}">离校手续</c:when>
	</c:choose>
</caption>
	<thead>
       <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>实习周记总数</th>
        <th>待审核周记数</th>
        <th>查看学生周记</th>
       </tr>
     </thead>
     <c:forEach items="${sessionScope.doclist}" var="doc">
       <tr>
		<td>
		<c:out value="${doc[0]}"/>
		</td>
		<td><c:out value="${doc[1]}"/></td>
		<td><c:out value="${doc[2]}"/></td>
		<td>
		<c:choose>
			<c:when test="${doc[3]=='0'}"><c:out value="${doc[3]}"/></c:when>
			<c:otherwise>
				<span style="color:red"><c:out value="${doc[3]}"/></span>
			</c:otherwise>
		</c:choose>
		</td>
		<td>
		 <a href="../studentdocument.do?method=studentshixizhoujiLookExecute&teacherid=${sessionScope.teacherid}&studentid=<c:out value="${doc[0]}"/>">查看周记</a>&nbsp;&nbsp;
		</td>
	</tr>
	</c:forEach>
</table>
</form>

</body>
<script type="text/javascript">

$(function () {       
	$("#classid").val($("#hidenclassid").val());
});

function onfindinfo()
{
	if($("#classid").val()==null||$("#classid").val()=="")
		{
			alert("请选择班级");
			return;
		}
	window.location.href="../studentdocument.do?method=studentdocumentByTeacherFindExecute1&papertype="+
			$("#hidenpapertype").val()+"&teacherid="+$("#hidenteacherid").val()+"&classid="+$("#classid").val()+
			"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));	
}
</script>
</html>