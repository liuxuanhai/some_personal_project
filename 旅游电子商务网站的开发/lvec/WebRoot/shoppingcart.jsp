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
				      <li ><a class="color1" href="viewspot.do?method=viewspotListExecute">景点门票</a>
					</li>
				    <li ><a class="color2" href="hotel.do?method=hotelListExecute">酒店预订</a>
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
		<table class="table table-bordered table-hover definewidth m20">
		<caption class="text-center">
			<h3>购物车列表：¥<span style="color:#A7E;font-size:30px" id="ordertotalprice">${sum }</span>&nbsp;&nbsp;
			<small><input value="提交订单" type="button" class="btn btn-success" onclick="submitorder()"/></small>
			</h3>
		
		
		</caption>
			<tr>
			<th>产品id</th><th>产品名称</th><th>产品单价(元/件)</th><th>购买数量(件)</th><th>购买总额(元)</th>
			</tr>
            <c:forEach items="${sessionScope.cart}" var="cart" >
            
            <tr>
			<td>${cart[0]}</td><td>${cart[1]}</td><td>${cart[2]}</td><td>${cart[3]}</td><td>${cart[2]*cart[3]}</td>
			</tr>
            </c:forEach>
		</table>
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


   <!-- 对话框 -->
<div class="modal fade" id="submitorderModel">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">提交订单</h4>
	      </div>
	      <div class="modal-body">
	      <div class="m10" style="padding:10px">
	      	收货人:
	        <input type="text" id="submitordername" class="form-control" />
	      </div>
	      <div class="m10" style="padding:10px">
	      	收货地址:
	        <input type="text" id="submitorderaddr" class="form-control" />
	      </div>
	      <div class="m10" style="padding:10px">
	      	联系号码:
	        <input type="text" id="submitorderphone"  class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	      </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="submitordercheck()">确定提交</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

  </body>
</html>

<script type="text/javascript">

// 提交订单
function submitorder()
{
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}	
	if(parseFloat($("#ordertotalprice").html())<=0)
		{
		alert("购物车为空");return;
		}
	$("#submitorderModel").modal();//显示提交页面
	
	
}
function submitordercheck()
{
	if($("#submitordername").val()=="")
	{
	alert("请输入收货人姓名");return;
	}
	if($("#submitorderaddr").val()=="")
	{
	alert("请输入收货地址");return;
	}
	if($("#submitorderphone").val()=="")
	{
	alert("请输入联系号码");return;
	}
	window.location.href="goodinfo.do?method=submitgoodorderExecute&username="+$("#spotusername").val()+
			"&ordertotalprice="+$("#ordertotalprice").html()+"&ordername="+encodeURI(encodeURI($("#submitordername").val()))+
			"&orderaddr="+encodeURI(encodeURI($("#submitorderaddr").val()))+"&orderphone="+$("#submitorderphone").val();
}

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
</script>
