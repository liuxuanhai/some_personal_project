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
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<!-- Custom Theme files -->
<!--theme-style-->
<link href="css/styleqiantai.css" rel="stylesheet" type="text/css" media="all" />	
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />	
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
<script src="js/main.js"></script>
<script src="js/simpleCart.min.js"> </script>

    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
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
				<li class="active grid"><a class="color4" href="goodinfo.do?method=goodinfoListExecute">旅游产品</a></li>				
				<li><a class="color6" href="luntanhuati.do?method=luntanhuatiListExecute">旅游论坛</a></li>
			  </ul> 
			</div>
				<div class="clearfix"> </div>
		</div>
		</div>
	</div>
   
 	<div class="content">
		<div class="container">
		<div style="padding:10px;">
			<div class="row" style="padding:15px;border:1px solid #EEE">
			<div class="col-md-7" style="height:200px">
				   <div id="myCarousel" class="carousel slide">
				   <!-- 轮播（Carousel）指标 -->
				   <ol class="carousel-indicators">
				      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				      <li data-target="#myCarousel" data-slide-to="1"></li>
				      <li data-target="#myCarousel" data-slide-to="2"></li>
				   </ol>   
				   <!-- 轮播（Carousel）项目 -->
				   <div class="carousel-inner text-center" style="height:280px;">
				      <c:set var="imagelist" value="${fn:split(sessionScope.goodinfoinfo.goodimage, '#')}" />
						<c:forEach items="${imagelist}" var="image" varStatus="status">
							<c:choose>
						       <c:when test="${image!=''&&status.index==0}">
						       	  
						       	<div class="item active">
						         <img src="<%=path %>/upload/${image}" alt="" style="width:100%;height:280px;">
						        </div>
						       </c:when>
						       <c:when test="${image!=''&&status.index!=0}">
						       	  
						       	<div class="item">
						         <img src="<%=path %>/upload/${image}" alt="" style="width:100%;height:280px;">
						        </div>
						       </c:when>
						       <c:otherwise>
						       </c:otherwise>
							</c:choose>
						</c:forEach>
				   </div>
				   <!-- 轮播（Carousel）导航 -->
				   <a class="carousel-control left" href="#myCarousel" 
				      data-slide="prev">&lsaquo;</a>
				   <a class="carousel-control right" href="#myCarousel" 
				      data-slide="next">&rsaquo;</a>
				</div> 
			</div>
			<div class="col-md-5" style="height:280px">
				<h2 style="color:#58E" id="goodname">${sessionScope.goodinfoinfo.goodname}</h2>
				<br/><br/>
				<input class="hide" id="goodid" value="${sessionScope.goodinfoinfo.goodid}"/>
				<p>产品价格：¥<span style="font-size:20px;color:#E87" id="goodprice">${sessionScope.goodinfoinfo.goodprice}</span></p>
				<div class="form-inline m20">
					购买数量：<input type="text" style="width:50px;text-align:center" value="1" id="buynum" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
					&nbsp;&nbsp;
				</div>
				<div class="m20"><input type="button" value="加入购物车" id="addtocart" onclick="onaddtoshoppingcart()" class="btn btn-success"/></div>
			</div>
			</div>
			<div class="row" style="border:1px solid #EEE">
				<div class="cd-tabs">
						<nav>
						<ul class="cd-tabs-navigation">
								<li><a data-content="description"  href="#0" class="selected ">产品描述</a></li>
								<li><a data-content="comment" href="#0" >相关评论</a></li>
							</ul> 
						</nav>
						<ul class="cd-tabs-content">
							<li data-content="description" class="selected ">
							<div class="facts">
							<h4>产品描述</h4>
							  <p>
							  	${sessionScope.goodinfoinfo.gooddescr}
							  </p>      
					        </div>
					
						</li>
						<li data-content="comment" >
							<c:forEach items="${sessionScope.goodinfocomment}" var="comment">
								<div class="comments-top-top">
									<div class="top-comment-right">
										<h6><c:out value="${comment.username}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${comment.addtime}"/></h6>
										<p><c:out value="${comment.content}"/></p>
									</div>
								</div>
							</c:forEach>
						</li>
					</ul> 
				</div> 
			</div>
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
function onaddtoshoppingcart()
{
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}
	if($("#buynum").val()=="")
	{
		alert("请输入购买数量");return;
	}
	//goodid
	//$("#goodid").val();$("#goodname").val();$("#goodprice").val();$("#buynum").val();$("#spotusername").val()
	window.location.href="goodinfo.do?method=goodinfoAddtoCartExecute&goodid="+$("#goodid").val()+"&goodprice="+$("#goodprice").html()
			+"&nums="+$("#buynum").val()+"&goodname="+encodeURI(encodeURI($("#goodname").html()));
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
$(function(){
    $('#myCarousel').carousel({
      interval: 5000  // 自动轮播间隔
    });
});
</script>
