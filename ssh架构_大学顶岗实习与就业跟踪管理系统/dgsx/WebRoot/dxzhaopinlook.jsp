<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Administrator" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("mess")=="wrong") out.println("<script type=text/javascript>$('.popover-user').popover('show')</script>");
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>大型招聘查看</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="scripts/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/navbar.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>
<body>
<div class="container">
<div class="m10"></div>
<!-- Static navbar -->
<div class="row">
<div class="col-sm-12">
      <nav class="navbar navbar-default" >
                <div class="container-fluid">
          <div class="navbar-header" style="font-size: 20px;">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <span class="navbar-brand">高校顶岗实习与就业跟踪系统</span>
            
          </div>
          <div id="navbar" class="navbar-collapse collapse" style="font-size: 18px;">
            <ul class="nav navbar-nav">
              <li ><a href="<%=path %>/index.jsp">首页</a></li>
              <li ><a href="qiantai.do?method=gonggaoIndexExecute">新闻公告</a></li>
              <li><a href="qiantai.do?method=ptzhaopinIndexExecute">普通招聘</a></li>
              <li class="active"><a href="qiantai.do?method=dxzhaopinIndexExecute">大型招聘</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      </div>
</div>

<div class="m10" style="border:1px solid #ccc;">
	<div class="text-center m20"><h1>${sessionScope.dxzhaopinlook.title}</h1></div>
	<hr/>
	<div class="text-center">
	<small>
	发布时间:<em>${sessionScope.dxzhaopinlook.addtime}</em>&nbsp;&nbsp;&nbsp;&nbsp;浏览量:<em>${sessionScope.dxzhaopinlook.looknum}</em>
	</small></div>
	
	<div class="row">
	 <div class="col-md-10 col-md-offset-1">
 	<div class="m20">
	${sessionScope.dxzhaopinlook.content}
 	</div>
 	<div class="m20" >
 		<h4 class="title">参与单位</h4>
 		<p style="line-height:200%;">
 		${sessionScope.dxzhaopinlook.cydw}
 		</p>
 	</div>
 	<hr style="height:3px;border:none;border-top:3px double red;">
	<div class="text-center"><a href="javascirpt:void(0)" onclick="window.close()">关闭页面</a></div>
	 </div>
	</div>	
</div>
	
</div>

<div class="m30">
</div>

</body>

</html>