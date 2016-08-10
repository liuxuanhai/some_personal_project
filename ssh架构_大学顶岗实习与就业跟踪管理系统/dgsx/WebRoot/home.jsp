<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("mess")=="wrong") out.println("<script type=text/javascript>$('.popover-user').popover('show')</script>");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
    <title>高校顶岗实习与就业跟踪系统</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="scripts/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/navbar.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="css/index.css" rel="stylesheet">

	<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/administrator.js'></script>
<script type='text/javascript' src='dwr/interface/student.js'></script>
	<script type='text/javascript' src='dwr/interface/teacher.js'></script>
</head>
<body>
<div class="container">
<!-- Static navbar -->
<div class="m10"></div>
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
              <li class="active"><a href="<%=path %>/index.jsp">首页</a></li>
              <li><a href="qiantai.do?method=gonggaoIndexExecute">新闻公告</a></li>
              <li><a href="qiantai.do?method=ptzhaopinIndexExecute">普通招聘</a></li>
              <li><a href="qiantai.do?method=dxzhaopinIndexExecute">大型招聘</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      </div>
 </div>
  <div class="row">
  	<div class="col-sm-8">
  	<div id="myCarousel" class="carousel slide" style="height:250px" data-ride="carousel">
 <!-- 轮播（Carousel）指标 -->
 <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
 </ol>   
 <!-- 轮播（Carousel）项目 -->
 <div class="carousel-inner">
    <div class="item active">
       <img src="<%=path %>/upload/1.jpg"  style="height:250px;width:100%">
    </div>
    <div class="item">
       <img src="<%=path %>/upload/2.jpg" style="height:250px;width:100%">
    </div>
    <div class="item">
       <img src="<%=path %>/upload/3.jpg"  style="height:250px;width:100%">
    </div>
 </div>
 <!-- 轮播（Carousel）导航 -->
   <a class="carousel-control left" href="#myCarousel" 
      data-slide="prev">&lsaquo;</a>
   <a class="carousel-control right" href="#myCarousel" 
      data-slide="next">&rsaquo;</a>
</div> 
    	</div>
    	<div class="col-sm-4">
    	<div style="height:250px;background-color: #EEE;">
  	<div class="title">
  	 新闻公告
  	<a class="more1"   href="qiantai.do?method=gonggaoIndexExecute">更多&gt;</a>
  	</div>
  	<div class="l_list">
  	<ul>
  		<c:forEach items="${sessionScope.gonggaolist}" var="gonggao">
  		<li style="overflow:hidden;text-overflow:ellipsis;-o-text-overflow:ellipsis;white-space:nowrap;width:100%;"><a 
title="<c:out value="${gonggao.title}"/>" 
href="qiantai.do?method=gonggaoLookExecute&gonggaoid=<c:out value="${gonggao.id}"/>"  target="_blank">
	<c:out value="${gonggao.title}"/>
</a></li>
   		</c:forEach>
  	</ul>
  	</div>
  	</div>
  	</div>
  </div>
  <div class="row m10" >
   <div class="col-sm-3">
   <div style="background-image:url(upload/login_stu1.png);background-repeat:no-repeat;height:60px;" class="text-center">
   	<a  href="javascript:void(0)" onclick="onlogin('1')" style="line-height:50px;font-size:20px">学生登录</a>
   </div>
   </div>
   <div class="col-sm-3">
   <div style="background-image:url(upload/login_stu1.png);background-repeat:no-repeat;height:60px;" class="text-center">
   	<a onclick="onlogin(2)" href="javascript:void(0)" style="line-height:50px;font-size:20px">教师登录</a>
   </div>
   </div>
   <div class="col-sm-3">
   <div style="background-image:url(upload/login_acd1.png);background-repeat:no-repeat;height:60px;" class="text-center">
   	<a onclick="onlogin(3)" href="javascript:void(0)" style="line-height:50px;font-size:20px">院系登录</a>
   </div>
   </div>
   <div class="col-sm-3">
   <div style="background-image:url(upload/login_acd1.png);background-repeat:no-repeat;height:60px;" class="text-center">
   	<a onclick="onlogin(4)" href="javascript:void(0)" style="line-height:50px;font-size:20px">系统登录</a>
   </div>
   </div>
  </div>
  <div class="row m10">
  	<div class="col-sm-4">
	 	<div style="height:250px;background-color: #EEE;">
	 	<div class="title">
	  	 系统简介
	  	<a class="more1"   href="'javascript:void(0);">详情&gt;</a>
	  	</div>
	  	<div style="padding:25px">
	  	<p style="text-indent:2em;line-height:30px">
	  		该系统的目标是具有对班级信息、学生个人在校信息进行管理及维护的功能。学生可以通过此系统进行个人信息查询功能。系统的总体任务是实现学生信息理的系统化、网络化、规范化和自动化。
	  	</p>
	  	</div>
		</div>
  	</div>
  	<div class="col-sm-4">
  		<div style="height:250px;background-color: #EEE;">
    	<div class="title">
    	 普通招聘
    	<a class="more1"   href="qiantai.do?method=ptzhaopinIndexExecute">更多&gt;</a>
    	</div>
    	<div class="l_list">
    	<ul>
    		<c:forEach items="${sessionScope.ptzhaopinlist}" var="ptzhaopin">
    		<li style="overflow:hidden;text-overflow:ellipsis;-o-text-overflow:ellipsis;white-space:nowrap;width:100%;"><a title="<c:out value="${ptzhaopin.title}"/>" 
		href="qiantai.do?method=ptzhaopinLookExecute&ptzhaopinid=<c:out value="${ptzhaopin.id}"/>"  target="_blank">
			<c:out value="${ptzhaopin.title}"/>
		</a></li>
    		</c:forEach>
    	</ul>
    	</div>
   	</div>
  	</div>
  	<div class="col-sm-4">
  		<div style="height:250px;background-color: #EEE;">
    	<div class="title">
    	大型招聘
    	<a class="more1"   href="qiantai.do?method=dxzhaopinIndexExecute">更多&gt;</a>
    	</div>
    	<div class="l_list">
    	<ul>
    		<c:forEach items="${sessionScope.dxzhaopinlist}" var="dxzhaopin">
    		<li style="overflow:hidden;text-overflow:ellipsis;-o-text-overflow:ellipsis;white-space:nowrap;width:100%;"><a 
	 title="<c:out value="${dxzhaopin.title}"/>" 
		href="qiantai.do?method=dxzhaopinLookExecute&dxzhaopinid=<c:out value="${dxzhaopin.id}"/>"  target="_blank">
			<c:out value="${dxzhaopin.title}"/>
	</a></li>
    		</c:forEach>
    	</ul>
    	</div>
   	</div>
  	</div>
  </div>
  
</div>

<div class="modal fade" id="addModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title" id="logintitle">学生登录</h4>
      </div>
      <div class="modal-body">
        <div class="form m20">
	        <label>账号</label>&nbsp;&nbsp;
	        <input type="text" class="form-control" value="" id="username"/>
        </div>
        <div class="form m20">
	        <label>密码</label>&nbsp;&nbsp;
	        <input type="password" class="form-control" value="" id="userpwd"/>
        </div>
      </div>
      <div class="modal-footer">
      	 <div class="form form-inline text-center">
      	 <input class="hidden" id="usertype"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
      	 <a  onclick="onloginsubmit()" class="btn btn-success" >确定</a>
      	 </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>


<script type="text/javascript">
function onloginsubmit()
{
	if($("#username").val()=="")
	{
		alert('请输入登录账号');return;
	}
	if($("#userpwd").val()=="")
	{
		alert('请输入登录密码');return;
	}
	if($("#usertype").val()=="1")
	{
		student.studentLogin(document.getElementById("username").value,document.getElementById("userpwd").value,signinCallback);
	}
	else if($("#usertype").val()=="2")
		teacher.teacherLogin(document.getElementById("username").value,document.getElementById("userpwd").value,signinCallback);
	else if($("#usertype").val()=="3")
		teacher.academyLogin(document.getElementById("username").value,document.getElementById("userpwd").value,signinCallback);
	else if($("#usertype").val()=="4")
		administrator.administratorLogin(document.getElementById("username").value,document.getElementById("userpwd").value,signinCallback);
}
function signinCallback(data){
	if(data=="fail") alert("用户或密码错误");
	else if(data=="success") 
	{
		if($("#usertype").val()=="1")
			window.open("student.do?method=studentLoginExecute&studentid="+document.getElementById("username").value);
		if($("#usertype").val()=="2")
		{
			window.open("teacher.do?method=teacherLoginExecute&userid="+document.getElementById("username").value);
		}
		if($("#usertype").val()=="3")
		{
			window.open("teacher.do?method=academyLoginExecute&userid="+document.getElementById("username").value);
		}
		if($("#usertype").val()=="4")
		{
			window.open("admin/adminmain.jsp?adminname="+document.getElementById("username").value);
		}
	}
	$("#userpwd").val('');
	$("#username").val('');
	$("#addModal").modal('hide');
}

function onlogin(obj)
{
	if(obj=="1") // 学生登录
	{
		$("#usertype").val(obj);
		$("#logintitle").html("学生登录");
		$("#addModal").modal();
		return ;
	}
	if(obj=="2") // 教师登录
	{
		$("#usertype").val(obj);
		$("#logintitle").html("教师登录");
		$("#addModal").modal();
		return ;
	}
	if(obj=="3") // 院系登录
	{
		$("#usertype").val(obj);
		$("#logintitle").html("院系登录");
		$("#addModal").modal();
		return ;
	}
	if(obj=="4") // 系统登录
	{
		$("#usertype").val(obj);
		$("#logintitle").html("系统登录");
		$("#addModal").modal();
		return ;
	}
}

$(function(){
    $('#myCarousel').carousel({
      interval: 5000  // 自动轮播间隔
    });
});
</script>

</html>

