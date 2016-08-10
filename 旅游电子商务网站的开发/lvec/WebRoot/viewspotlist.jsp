<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<title>旅游电子商务网欢迎您</title>
<link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery.min.js"></script>
<!-- Custom Theme files -->
<!--theme-style-->
<link href="css/styleqiantai.css" rel="stylesheet" type="text/css" media="all" />	
<!--//theme-style-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="New Store Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!--fonts-->
<link href='http://fonts.useso.com/css?family=Lato:100,300,400,700,900' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Roboto:400,100,300,500,700,900' rel='stylesheet' type='text/css'><!--//fonts-->
<!-- start menu -->
<link href="css/memenu.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="js/memenu.js"></script>
<script>$(document).ready(function(){$(".memenu").memenu();});</script>
<script src="js/simpleCart.min.js"> </script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
<script type='text/javascript' src='dwr/interface/spotuser.js'></script>
</head>
  <body>
   <!--header-->
<div class="header">
	<div class="header-top">
		<div class="container">
			<div class="header-left">		
					<input class="hide" id="spotuserid" value="${sessionScope.spotuser.userid }"/>	
					<input class="hide" id="spotusername" value="${sessionScope.spotuser.username }"/>	
					<c:choose>
						<c:when test="${sessionScope.spotuser==null }">
							<ul>
								<li ><a href="javascript:void(0)"  onclick="onlogin()">登录</a></li>
								<li><a  href="javascript:void(0)"  onclick="onregister()">注册</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<ul>
								<li ><a href="spotuser.do?method=spotuserOrderByTypeExecute&username=${sessionScope.spotuser.username}"  >欢饮您,${sessionScope.spotuser.username}</a></li>
								<li><a  href="exit.jsp" >退出</a></li>
							</ul>
						</c:otherwise>
					</c:choose>
					<div class="cart box_1">
						<a href="shoppingcart.jsp">
						<h3> <div class="total">
							<c:choose>
								<c:when test="${sessionScope.cart==null }">
									<span class="simpleCart_total"></span> 
									(<span id="simpleCart_quantity" class="simpleCart_quantity"></span> 件)
								</c:when>
								<c:otherwise>
									<c:set var="sum" value="0"/>
			                        <c:forEach items="${sessionScope.cart}" var="cart" >
			                        <c:set var="sum" value="${sum + cart[2]*cart[3] }"/>
			                        </c:forEach>
			                        ¥<span class="" style="color:red">${sum}</span> 
			                        (<span style="color:blue">${fn:length(sessionScope.cart) }</span> 件)
								</c:otherwise>
							</c:choose>
							</div>
							<img src="images/cart.png" alt=""/>
						</h3>
						</a>

					</div>
					<div class="clearfix"> </div>
			</div>
				<div class="clearfix"> </div>
		</div>
		</div>
		<div class="container">
			<div class="head-top">
				<div class="logo">
					<a href="index.jsp"><img src="images/logo.png" alt=""></a>	
				</div>
		  <div class=" h_menu4">
				<ul class="memenu skyblue">
					  <li ><a class="color8" href="index.jsp">主页</a></li>	
				      <li class="active grid"><a class="color1" href="viewspot.do?method=viewspotListExecute">景点门票</a>
					</li>
				    <li class="grid"><a class="color2" href="hotel.do?method=hotelListExecute">酒店预订</a>
			    	</li>
				<li><a class="color4" href="goodinfo.do?method=goodinfoListExecute">旅游产品</a></li>				
				<li><a class="color6" href="luntanhuati.do?method=luntanhuatiListExecute">旅游论坛</a></li>
			  </ul> 
			</div>
				<div class="clearfix"> </div>
		</div>
		</div>
	</div>
   
 	<div class="content">
		<div class="container">
		<div class="form-inline" style="padding:10px;">
			<div>城市:
			<select id="city" class="form-control">
				<option value="">所有</option>
				<c:forEach items="${sessionScope.citylist}" var="city">
				<option value="<c:out value="${city}"/>"><c:out value="${city}"/></option>
				</c:forEach>
			</select>&nbsp;&nbsp;
			<input class="hide" id="hidecity" value="${sessionScope.city}"/>
			<input type="text" style="width:300px" value="${sessionScope.findinfo}" id="findinfo" class="form-control" /><input type="button" onclick="onfindinfo()" value="Go" class="btn btn-primary form-control">
			</div>
		</div>
		<div style="padding:10px;">
		<c:forEach items="${sessionScope.viewspotlist}" var="viewspot">
			<div class="row" style="padding:15px;border:1px solid #EEE">
			<div class="col-md-6" style="height:200px">
				<c:set var="spotimagelist" value="${fn:split(viewspot.sportimage, '#')}" />
				<a href="viewspot.do?method=spotviewLookExecute&spotid=<c:out value="${viewspot.spotid}"/>">
				<img  src="<%=path %>/upload/${spotimagelist[0]}" width="100%" height="200">
				</a>
			</div>
			<div class="col-md-4" style="height:200px">
				<p>景点名称：<c:out value="${viewspot.spotname}"/></p>
				<p>所在城市：<c:out value="${viewspot.spotcity}"/></p>
				<p>详细地址：<c:out value="${viewspot.spotaddr}"/></p>
			</div>
			<div class="col-md-2" style="height:200px">
			¥<span style="font-size:25px;color:#58E"><c:out value="${viewspot.spotprice}"/></span>
			</div>
			</div>

		</c:forEach>
		</div>
		</div>
	</div>
   
   <!-- 对话框 -->
<div class="modal fade" id="addModel1">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">用户注册</h4>
	      </div>
	      <div class="modal-body">
	      <div class="m10">
	      	登录用户名:
	        <input type="text" id="addusername" name="username" class="form-control" />
	      </div>
	      <div class="m10">
	      	登录密码:
	        <input type="password" id="adduserpwd" name="userpwd" class="form-control"/>
	      </div>
	      <div class="m10">
	      	姓名:
	        <input type="text" id="addname" name="name" class="form-control"/>
	      </div>
	      <div class="m20">
	      	联系电话:
	        <input type="text" id="addphone" name="phone" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	      </div>
	      <div class="m20">
	      	联系地址:
	        <input type="text" id="addaddr" name="addr" class="form-control"/>
	      </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="addcheck()">提交</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

   <!-- 对话框 -->
<div class="modal fade" id="loginModel">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">用户登录</h4>
	      </div>
	      <div class="modal-body">
	      <div class="m10">
	      	用户名:
	        <input type="text" id="addusername1" name="username" class="form-control" />
	      </div>
	      <div class="m10">
	      	密码:
	        <input type="password" id="adduserpwd1" name="userpwd" class="form-control"/>
	      </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="logincheck()">登录</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

  </body>
</html>

<script type="text/javascript">
//注册
function onregister()
{
	$("#addusername").val('');
	$("#adduserpwd").val('');
	$("#addname").val('');
	$("#addphone").val('');
	$("#addaddr").val('');
	$("#addModel1").modal();	
}
function addcheck()
{
	if($("#addusername").val()=="")
	{
		alert("请输入用户名");return;
	}
	if($("#adduserpwd").val()=="")
	{
		alert("请输入登录密码");return;
	}
	spotuser.spotuserIsExist($("#addusername").val(),callbackIsExist);
}
function callbackIsExist(data)
{
	if(data)
	{
		alert("用户名已经存在，请修改");return;
	}
	spotuser.spotuserRegister($("#addusername").val(),$("#adduserpwd").val(),$("#addname").val(),$("#addphone").val(),$("#addaddr").val(),callbackRegister);
}
function callbackRegister()
{
	alert("注册完成，请登录");
	$("#addModel1").modal('hide');	
}

// 登录
function onlogin()
{
	$("#loginModel").modal();
}
function logincheck()
{
	if($("#addusername1").val()=="")
	{
		alert("请输入用户名");return;
	}
	if($("#adduserpwd1").val()=="")
	{
		alert("请输入登录密码");return;
	}
	spotuser.spotuserLogin($("#addusername1").val(),$("#adduserpwd1").val(),callbackLogin);
}
function callbackLogin(data)
{
	if(data=="fail")
	{
		alert("用户名或密码错误");return;
	}
	window.location.href="spotuser.do?method=spotuserLoginExecute&spotusername="+$("#addusername1").val();
}

// 查找
function onfindinfo()
{
	window.location.href="viewspot.do?method=viewspotListExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&city="+encodeURI(encodeURI($("#city").val()));	
}
$(function () {
	$("#city").val($("#hidecity").val());
});
</script>
