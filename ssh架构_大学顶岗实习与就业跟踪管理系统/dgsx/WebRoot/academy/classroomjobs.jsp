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
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="班级名称">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" onclick="onfind()">查询</button>
</form>
<input type="hidden" value="${sessionScope.academyid}" id="academyid"/>
<table class="table table-bordered table-hover definewidth m10" id="classtable">
<caption class="text-center">${sessionScope.academyname}</caption>
    <thead>
    <tr>     
        <th>班级名称</th>
        <th>总人数</th>
        <th>在校</th>
        <th>顶岗实习</th>
        <th>专升本 </th>
        <th>研究生</th>
        <th>公务员</th>
        <th>已就业</th>
        <th>创业</th>
        <th>入伍</th>
        <th>查看详情</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.classjobslist}" var="classjob">
        <tr>
        	<td class="hide"><c:out value="${classjob[0]}"/></td>
			<td><c:out value="${classjob[1]}"/></td>
			<td><c:out value="${classjob[2]}"/></td>
			<td><c:out value="${classjob[3]}"/></td>
			<td><c:out value="${classjob[4]}"/></td>
			<td><c:out value="${classjob[5]}"/></td>
			<td><c:out value="${classjob[6]}"/></td>
			<td><c:out value="${classjob[7]}"/></td>
			<td><c:out value="${classjob[8]}"/></td>
			<td><c:out value="${classjob[9]}"/></td>
			<td><c:out value="${classjob[10]}"/></td>
			<td><a href="../classroom.do?method=classroomByClassidExecute&classid=${classjob[0]}">查看</a></td>
		</tr>
		</c:forEach>
</table>
</body>
</html>
<script>
function onfind()
{
	//查找
	for(var i=1;i<$("#classtable tr").length;++i)
	{
		$("#classtable tr:eq("+i+")").addClass("hide");
		if($("#classtable tr:eq("+i+") td:eq(0)").html().indexOf($("#findinfo").val())>=0)
			$("#classtable tr:eq("+i+")").removeClass("hide");
	}
}
</script>