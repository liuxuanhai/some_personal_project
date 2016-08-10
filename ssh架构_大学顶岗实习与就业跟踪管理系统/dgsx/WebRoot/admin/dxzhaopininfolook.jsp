<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	<div class="text-center m20"><h1>${sessionScope.dxzhaopininfolook.title}</h1></div>
	
	<div class="text-center m20">
	<small>
	发布时间:<em>${sessionScope.dxzhaopininfolook.addtime}</em>&nbsp;&nbsp;&nbsp;&nbsp;浏览量:<em>${sessionScope.dxzhaopininfolook.looknum}</em>
	</small></div>
	
	<div class="row">
	 <div class="col-md-10 col-md-offset-1">
 	<div class="m20">
	${sessionScope.dxzhaopininfolook.content}
 	</div>
 	<div class="m20" >
 		<h4 class="title">参与单位</h4>
 		<p style="line-height:200%;">
 		${sessionScope.dxzhaopininfolook.cydw}
 		</p>
 	</div>
 	<hr style="height:3px;border:none;border-top:3px double red;">
	<div class="text-center"><a href="javascirpt:void(0)" onclick="window.close()">关闭页面</a></div>
	 </div>
	</div>
</div>
<div class="m30"></div>
</body>
</html>
