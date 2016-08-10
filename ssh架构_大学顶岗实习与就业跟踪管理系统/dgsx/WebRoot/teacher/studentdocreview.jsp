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
<form id="addform" action="#" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10" id="doctable">
<caption class="text-center">
待审核材料列表
</caption>
	<thead>
       <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>材料名称</th>
        <th>材料说明</th>
        <th>材料类型</th>
        <th>查看下载</th>
        <th>审核操作</th>
       </tr>
     </thead>
     <c:forEach items="${sessionScope.docreviewlist}" var="doc">
       <tr>
		<td>
		<c:out value="${doc[0]}"/>
		</td>
		<td><c:out value="${doc[1]}"/></td>
		<td><c:out value="${doc[2]}"/></td>
		<td><c:out value="${doc[3]}"/></td>
		<td>
		<c:choose>
		<c:when test="${doc[4]=='0' }">实习周记</c:when>
		<c:when test="${doc[4]=='1' }">
		实习报告
		</c:when>
		<c:when test="${doc[4]=='2' }">三方协议</c:when>
		<c:when test="${doc[4]=='3' }">离校手续</c:when>
		</c:choose>
		</td>
		<td>
		<c:if test="${fn:contains(doc[5], '.pdf')}">
			<a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<c:out value="${doc[5]}"/>">预览&nbsp;&nbsp;</a>
		</c:if>
		<c:if test="${doc[5]!=''}">
			<a href="javascript:void(0);" onClick="ondownload(this)">下载</a>
		</c:if>
		</td>
		<td>
			<a href="javascript:void(0);" onclick="onshenhe(<c:out value="${doc[6]}"/>,'1')">同意通过</a>&nbsp;&nbsp;
			<a href="javascript:void(0);" onclick="onshenhe(<c:out value="${doc[6]}"/>,'2')">拒绝通过</a>
		</td>
		<td class="hide"><c:out value="${doc[5]}"/></td>
	</tr>
	</c:forEach>
</table>
</form>

</body>
<script type="text/javascript">

//下载文档材料
function ondownload(obj)
{
	 var file=obj.parentNode.parentNode.cells[7].innerHTML.split(".");
	 var filename=obj.parentNode.parentNode.cells[0].innerHTML+"_"+obj.parentNode.parentNode.cells[1].innerHTML+"_"
	 +obj.parentNode.parentNode.cells[2].innerHTML+"."+file[1];
	 window.location.href="../servlet/fileDownloadServlet?filepath="+obj.parentNode.parentNode.cells[7].innerHTML+
			 "&filename="+filename.replace(/\+/g,"");
}
function onshenhe(obj1,obj2)
{
	studentdocument.shenhestatus(obj1,obj2,callback);
}
function callback()
{
	alert("审核完成");
	window.location.href="../studentdocument.do?method=studocReviewByTeacherFindExecute&teacherid="+$("#hidenteacherid").val();	
}
</script>
</html>