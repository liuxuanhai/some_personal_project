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
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    <button type="button" class="btn btn-primary" id="backid">返回</button>&nbsp;&nbsp;
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>商品名称</th>
        <th>商品单价</th>
        <th>购买数量</th>
        <th>购买总额</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.goodorderinfolist}" var="goodorderinfo">
        <tr>
        	<td><c:out value="${goodorderinfo.goodname}"/></td>
			<td><c:out value="${goodorderinfo.goodprice}"/></td>
			<td><c:out value="${goodorderinfo.nums}"/></td>
			<td><c:out value="${goodorderinfo.totalprice}"/></td>
		</tr>
		</c:forEach>
</table>
</body>
</html>
<script>   
$(function () {       
	$('#backid').click(function(){
			window.location.href="../goodorder.do?method=goodorderFindExecute";
	 });
});
</script>