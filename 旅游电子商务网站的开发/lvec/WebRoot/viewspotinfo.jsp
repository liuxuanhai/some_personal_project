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
				      <c:set var="imagelist" value="${fn:split(sessionScope.viewspotinfo.sportimage, '#')}" />
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
				<h2 style="color:#58E" id="">${sessionScope.viewspotinfo.spotname}</h2>
				<br/><br/>
				<p>所在城市：${sessionScope.viewspotinfo.spotcity}</p>
				<p>详细地址：${sessionScope.viewspotinfo.spotaddr}</p>
				<p>门票价格：¥<span style="font-size:20px;color:#E87">${sessionScope.viewspotinfo.spotprice}</span></p>
				<div style="padding:15px;">
				<input type="button" class="btn btn-success" value="预订" onclick="ongotoorder()"/>
				</div>
			</div>
			</div>
			<div class="row" style="border:1px solid #EEE">
				<div class="cd-tabs">
						<nav>
							<ul class="cd-tabs-navigation">
								<li><a data-content="description"  href="#0" class="selected ">景点描述</a></li>
								<li><a data-content="spotcity" href="#0" >同城酒店</a></li>
								<li><a data-content="comment" href="#0" >相关评论</a></li>
							</ul> 
						</nav>
						<ul class="cd-tabs-content">
							<li data-content="description" class="selected">
							<div class="facts">
							<h4>景点描述</h4>
							  <p>
							  	${sessionScope.viewspotinfo.spotdescr}
							  </p>
							<h4>备注信息</h4>
							  <p>
							  	${sessionScope.viewspotinfo.spotremark}
							  </p>	      
					        </div>
					
						</li>
						<li data-content="spotcity" >
							<div class="facts1">
								<c:forEach items="${sessionScope.viewspotcity}" var="viewspotcity">
									<div class="row" style="padding:10px;">
										<div class="col-md-5" style="height:80px">
											<c:set var="imagelist" value="${fn:split(viewspotcity.hotelimage, '#')}" />
											<a href="hotel.do?method=hotelLookExecute&hotelid=<c:out value="${viewspotcity.hotelid}"/>">
											<img  src="<%=path %>/upload/${imagelist[0]}" width="100%" height="200">
											</a>
										</div>
										<div class="col-md-4" style="height:80px">
											<p>酒店名称：<c:out value="${viewspotcity.hotelname}"/></p>
											<p>所在城市：<c:out value="${viewspotcity.hotelcity}"/></p>
											<p>详细地址：<c:out value="${viewspotcity.hoteladdr}"/></p>
										</div>
										<div class="col-md-2" style="height:200px">
										¥<span style="font-size:25px;color:#58E"><c:out value="${viewspotcity.hotelprice}"/></span>
										</div>
									</div>
								</c:forEach>		        
						    </div>
						</li>
						<li data-content="comment" >
							<c:forEach items="${sessionScope.viewspotcomment}" var="viewspotcomment">
								<div class="comments-top-top">
									<div class="top-comment-right">
										<h6><c:out value="${viewspotcomment.username}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${viewspotcomment.addtime}"/></h6>
										<p><c:out value="${viewspotcomment.content}"/></p>
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


   <!-- 对话框 -->
<div class="modal fade" id="yudingModel">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">用户订票</h4>
	      </div>
	      <div class="modal-body">
	      <input class="hide" id="orderspotid" value="${sessionScope.viewspotinfo.spotid}"/>
	      <div class="m10">
	      	景点名称：<span id="orderspotname" style="font-size:25px">${sessionScope.viewspotinfo.spotname}</span>
	      </div>
	      <div class="m10">
	      	景点门票：¥<span style="font-size:20px;color:#E87" id="orderspotprice">${sessionScope.viewspotinfo.spotprice}</span>
	      </div>
	      <div class="m10 form-inline">
	      	预订数量：
	        <select id="ordernums" class="form-control" onchange="numschanges()">
	        	<option value="1">1</option>
	        	<option value="2">2</option>
	        	<option value="3">3</option>
	        	<option value="4">4</option>
	        	<option value="5">5</option>
	        	<option value="6">6</option>
	        </select>
	      </div>
	      <div class="m10">
	      	订票总额：¥<span style="font-size:20px;color:#E87" id="ordertotalprices">${sessionScope.viewspotinfo.spotprice}</span>
	      </div>
	      <div class="m10 form-inline">
	      	&nbsp;&nbsp;&nbsp;&nbsp;取票人：
	        <input type="text" id="ordername" class="form-control"/>
	      </div>
	      <div class="m10 form-inline">
	      	取票电话：
	        <input type="text" id="orderphone" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	      </div>
	      <div class="m10 form-inline">
	      	游玩日期：<input type="text" id="ordertratime" readonly class="form_datetime form-control"/>
	      </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="ordercheck()">提交订单</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

  </body>
</html>

<script type="text/javascript">
function ongotoorder()
{
	//开始预订
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}
	$("#ordernums").val("1");
	$("#yudingModel").modal(); //打开预订页面
}

// 预订票数改变
function numschanges()
{
	$("#ordertotalprices").html(parseFloat($("#orderspotprice").html())*parseFloat($("#ordernums").val()));	
}

//时间控件初始化
$(".form_datetime").datetimepicker({
	language:  'zh-CN',
	format: 'yyyy-mm-dd',
	autoclose: true,
	weekStart: 1,
    todayBtn:  1,
    todayHighlight: 1,
    minView:2
	});
$(".form_datetime").datetimepicker( 'update', new Date() );

function ordercheck()
{
	// 预订检测
	if($("#ordername").val()=="")
	{
		alert("请输入取票人信息");return;
	}
	if($("#orderphone").val()=="")
	{
		alert("请输入取票电话");return;
	}
	if($("#ordertratime").val()=="")
	{
		alert("请输入游玩日期");return;
	}
	//开始提交订单
	var dataarray=new Array();
	dataarray.push($("#orderspotid").val());
	dataarray.push($("#orderspotname").html());
	dataarray.push($("#orderspotprice").html());
	dataarray.push($("#spotusername").val());
	dataarray.push($("#ordername").val());
	dataarray.push($("#orderphone").val());
	dataarray.push($("#ordernums").val());
	dataarray.push($("#ordertotalprices").html());
	dataarray.push($("#ordertratime").val());
	spotuser.spotorderAdd(dataarray,spotordercallback);
}

function spotordercallback()
{
	alert("提交订单完成，请到个人信息查看订单");
	$("#yudingModel").modal('hide');
	return;	
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
