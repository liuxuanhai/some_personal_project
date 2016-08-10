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
		<div class="form-inline"  style="padding:10px;" onchange="onchangetype()">
			<div>订单类型:
			<select  class="form-control" id="ordertype">
				<option value="0">景点订单</option>
				<option value="1">酒店订单</option>
				<option value="2">产品订单</option>
			</select>&nbsp;&nbsp;
			<input class="hide" value="${sessionScope.ordertype}" id="hideordertype"/>
			<input type="button" onclick="onpersoninfo()" value="个人信息" class="btn btn-primary form-control">
			</div>
		</div>
		<c:choose>
			<c:when test="${sessionScope.ordertype=='0' }">
				<table class="table table-bordered table-hover definewidth m20">
				<caption class="text-center"><h3>景点订单</h3></caption>
					<thead>
				    <tr>
				        <th>订单id</th>
				        <th>用户名</th>
				        <th>景点名称</th>
				        <th>门票价格</th>
				        <th>订票数量</th>
				        <th>订票总额</th>
				        <th>游玩日期</th>
				        <th>取票联系人</th>
				        <th>联系电话</th>
				        <th>提交时间</th>
				        <th>评论</th>
				    </tr>
				    </thead>
				        <c:forEach items="${sessionScope.orderlist}" var="spotorder">
				        <tr>
				        	<td><c:out value="${spotorder.orderid}"/></td>
							<td><c:out value="${spotorder.username}"/></td>
							<td><c:out value="${spotorder.spotname}"/></td>
							<td><c:out value="${spotorder.spotprice}"/></td>
							<td><c:out value="${spotorder.nums}"/></td>
							<td><c:out value="${spotorder.totalprice}"/></td>
							<td><c:out value="${spotorder.tratime}"/></td>
							<td><c:out value="${spotorder.name}"/></td>
							<td><c:out value="${spotorder.phone}"/></td>
							<td><c:out value="${spotorder.ordertime}"/></td>
							<td><a  href="#" onClick="ongotocommnet(<c:out value="${spotorder.spotid}"/>)">评论</a></td>
						</tr>
						</c:forEach>
				</table>
			</c:when>
			<c:when test="${sessionScope.ordertype=='1' }">
				 <table class="table table-bordered table-hover definewidth m10">
				 <caption class="text-center"><h3>酒店订单</h3></caption>
				    <thead>
				    <tr>
				        <th>订单id</th>
				        <th>用户名</th>
				        <th>酒店名称</th>
				        <th>房型</th>
				        <th>预订单价(元/天)</th>
				        <th>预订天数</th>
				        <th>预订总额</th>
				        <th>入住日期</th>
				        <th>取票联系人</th>
				        <th>联系电话</th>
				        <th>提交时间</th>
				        <th>评论</th>
				    </tr>
				    </thead>
				        <c:forEach items="${sessionScope.orderlist}" var="hotelorder">
				        <tr>
				        	<td><c:out value="${hotelorder.orderid}"/></td>
							<td><c:out value="${hotelorder.username}"/></td>
							<td><c:out value="${hotelorder.hotelname}"/></td>
							<td><c:out value="${hotelorder.roomname}"/></td>
							<td><c:out value="${hotelorder.roomprice}"/></td>
							<td><c:out value="${hotelorder.nums}"/></td>
							<td><c:out value="${hotelorder.totalprice}"/></td>
							<td><c:out value="${hotelorder.checkintime}"/></td>
							<td><c:out value="${hotelorder.name}"/></td>
							<td><c:out value="${hotelorder.phone}"/></td>
							<td><c:out value="${hotelorder.ordertime}"/></td>
							<td><a  href="#" onClick="ongotocommnet(<c:out value="${hotelorder.hotelid}"/>)">评论</a></td>
						</tr>
						</c:forEach>
				</table>
			</c:when>
			<c:when test="${sessionScope.ordertype=='2' }">
			<c:forEach items="${sessionScope.orderlist}" var="goodorder">
			<div style="border:solid 1px #88E;padding:15px">
				<div >
					订单编号:${goodorder[0].orderid }&nbsp;&nbsp;&nbsp;&nbsp;
					用户名:${goodorder[0].username }&nbsp;&nbsp;&nbsp;&nbsp;
					订单时间:${goodorder[0].ordertime }&nbsp;&nbsp;&nbsp;&nbsp;
					收货人:${goodorder[0].name }&nbsp;&nbsp;&nbsp;&nbsp;
					订单总额:${goodorder[0].totalprice }&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				<div >
				
					<table class="table table-bordered table-hover definewidth m10">
					    <thead>
					    <tr>
					        <th>商品名称</th>
					        <th>商品单价</th>
					        <th>购买数量</th>
					        <th>购买总额</th>
					        <th>评论</th>
					    </tr>
					    </thead>
					        <c:forEach items="${goodorder[1]}" var="goodorderinfo">
					        <tr>
					        	<td><c:out value="${goodorderinfo.goodname}"/></td>
								<td><c:out value="${goodorderinfo.goodprice}"/></td>
								<td><c:out value="${goodorderinfo.nums}"/></td>
								<td><c:out value="${goodorderinfo.totalprice}"/></td>
								<td><a  href="#" onClick="ongotocommnet(<c:out value="${goodorderinfo.goodid}"/>)">评论</a></td>
							</tr>
							</c:forEach>
					</table>
				</div>
			</div>
			</c:forEach>
			</c:when>
		</c:choose>
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
<div class="modal fade" id="personModel">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">个人信息</h4>
	      </div>
	      <div class="modal-body">
	      	 <div class="modal-body">
			      <div class="m10">
			      	登录用户:
			        ${sessionScope.spotuser.username }
			      </div>
			      <div class="m10">
			      	登录密码:
			        <input type="password" id="personuserpwd" name="userpwd" class="form-control" />
			      </div>
			      <div class="m10">
			      	姓名:
			        <input type="text" id="personname" name="name" class="form-control" value="${sessionScope.spotuser.name }"/>
			      </div>
			      <div class="m20">
			      	联系电话:
			        <input type="text" value="${sessionScope.spotuser.phone }" id="personphone" name="phone" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
			      </div>
			      <div class="m20">
			      	联系地址:
			        <input type="text" value="${sessionScope.spotuser.addr }" id="personaddr" name="addr" class="form-control"/>
			      </div>
		      </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="modifypersoninfo()">保存信息</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


   <!-- 对话框 -->
<div class="modal fade" id="commentModel">
  <div class="modal-dialog">
    <form id="addform" class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title">评论</h4>
	      </div>
	      <div class="modal-body">
	      	 <div class="modal-body">
			      <div class="m10">
			      	评论内容:
			        <textarea rows="5" cols="" class="form-control" id="addcommentcontent"></textarea>
			      </div>
		      </div>
		      <input class="hide" id="addcommentid"/>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="button" class="btn btn-primary" onclick="addcommnetcheck()">提交评论</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

  </body>
</html>

<script type="text/javascript">

function ongotocommnet(obj)
{
	//修改个人信息
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}
	$("#addcommentid").val(obj);
	$("#commentModel").modal();
}
function addcommnetcheck()
{
	if($("#addcommentcontent").val()=="")
		{
		alert("请输入评论内容");return;
		}
	//开始预订
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}	
	spotuser.addcomment(
			$("#hideordertype").val(),
			$("#addcommentid").val(),
			$("#spotusername").val(),
			$("#addcommentcontent").val(),
			$("#spotuserid").val(),
			callbaclcomment);
}
function callbaclcomment()
{
	alert("评论完成");
	$("#commentModel").modal('hide');
	return;	
}
function onpersoninfo()
{
	//开始预订
	if($("#spotusername").val()==null||$("#spotusername").val()=="")
	{
		alert("请先登录");return;
	}
	$("#personModel").modal();
}
function modifypersoninfo()
{
	//修改个人信息
	if($("#personuserpwd").val()=="")
		{
		alert("请输入登录密码");return;
		}
	spotuser.spotuserModifyInfo($("#spotuserid").val(),$("#spotusername").val(),$("#personuserpwd").val()
			,$("#personname").val(),$("#personphone").val(),$("#personaddr").val(),callbackModify);
}
function callbackModify()
{
alert("修改信息完成");
$("#personModel").modal('hide');
}
function onchangetype()
{

	window.location.href="spotuser.do?method=spotuserOrderByTypeExecute&username="+$("#spotusername").val()+"&ordertype="+$("#ordertype").val();
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
$(function () {
	$("#ordertype").val($("#hideordertype").val());
});
</script>
