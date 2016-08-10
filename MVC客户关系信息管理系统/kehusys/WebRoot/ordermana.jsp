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
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/bootstrap/css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/css/style.css" />
    <script type="text/javascript" src="<%=path %>/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=path %>/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
</head>
<body>
<form class="form-inline definewidth m20" action="<%=path %>/servlet/OrdermanaServlet?method=getOrdermana" method="post">    
    <input class="hide" id="userid" name="userid" value="${requestScope.userid}"/>
     	<input type="text" id="starttime" name="starttime" placeholder="2016-5-1" value="${requestScope.starttime}" readonly class="form_datetime form-control"/>
     	至
     	<input type="text" id="endtime" name="endtime" placeholder="2016-5-1" value="${requestScope.endtime}" readonly class="form_datetime form-control"/>
    <button type="submit" class="btn btn-primary" id="findbtn">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn" onclick="onadd()">新增订单</button>&nbsp;&nbsp;
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>订单id</th>
        <th>客户姓名</th>
        <th>订单金额(元)</th>
        <th>备注</th>
        <th>负责员工</th>
        <th>订货日期</th>
        <th>详单管理</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${requestScope.orderlist}" var="order">
        <tr>
        	<td><c:out value="${order.ordernum}"/></td>
        	<td class="hide"><c:out value="${order.customerid}"/></td>
			<td><c:out value="${order.kename}"/></td>
			<td><c:out value="${order.totalprice}"/></td>
			<td><c:out value="${order.remark}"/></td>
			<td><c:out value="${order.ygname}"/></td>
			<c:set var="time" value="${fn:split(order.ordertime, ' ')}" />
			<td>${time[0]}
			</td>
			<td>
			<a href="<%=path %>/servlet/OrderdetailServlet?method=getOrderdetail&userid=${requestScope.userid}&ordernum=<c:out value="${order.ordernum}"/>">详单管理</a>
			</td>
			<td>
			<c:if test="${requestScope.userid==order.yuangongid }">
			<a href="#" onclick="onedit(this)">修改</a>&nbsp;&nbsp;
			<a  href="#" onClick="delcfm('<%=path %>/servlet/OrdermanaServlet?method=delOrdermana&userid=${requestScope.userid}&ordernum=<c:out value="${order.ordernum}"/>')">删除</a>
			</c:if>
			</td>
		</tr>
		</c:forEach>
</table>


<!-- 信息删除确认 -->
<div class="modal fade" id="delcfmModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">警告</h4>
      </div>
      <div class="modal-body">
        <p>您确认要删除吗？</p>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="urlSubmit()" class="btn btn-success" data-dismiss="modal">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 信息添加-->
<div class="modal fade" id="addModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">添加订单</h4>
      </div>
      <form action="<%=path %>/servlet/OrdermanaServlet?method=addOrdermana" method="post">
	      	<div class="modal-body">
	      	<input class="hide" name="userid" value="${requestScope.userid}"/>
	        <div class="form m10">
	        	客户姓名
	        	<select id="addcustomerid" name="customerid" class="form-control">
	        		<c:forEach items="${requestScope.customerlist}" var="customer">
	        		<option value="<c:out value="${customer.id}"/>"><c:out value="${customer.name}"/></option>
	        		</c:forEach>
	        	</select>
	        </div>
	        <div class="form m10">
	        	订货日期<input type="text" id="addordertime" name="ordertime" placeholder="2016-5-1" readonly class="form_datetime form-control"/>
	        </div>
	        <div class="form m10" >
	        	备注
	        	<textarea rows="3" cols="" id="addremark" name="remark" class="form-control"></textarea>
	        </div>
	        </div>
	        <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>&nbsp;&nbsp;
	      	 <button type="submit" class="btn btn-success" onclick="return onaddsave()" >确定</button>&nbsp;&nbsp;
	        </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 信息修改-->
<div class="modal fade" id="editModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">修改订单</h4>
      </div>
      <form action="<%=path %>/servlet/OrdermanaServlet?method=editOrdermana" method="post">
	      <div class="modal-body">
	      <input class="hide" name="userid" value="${requestScope.userid}"/>
	      <input type="hidden" id="editid" name="ordernum"/>
	       <div class="form m10">
	        	客户姓名
	        	<select id="editcustomerid" name="customerid" class="form-control" disabled="disabled">
	        		<c:forEach items="${requestScope.customerlist}" var="customer">
	        		<option value="<c:out value="${customer.id}"/>"><c:out value="${customer.name}"/></option>
	        		</c:forEach>
	        	</select>
	        </div>
	        <div class="form m10">
	        	订货日期<input type="text" id="editordertime" name="ordertime" placeholder="2016-5-1" readonly class="form_datetime form-control"/>
	        </div>
	        <div class="form m10" >
	        	备注
	        	<textarea rows="3" cols="" id="editremark" name="remark" class="form-control"></textarea>
	        </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-success" onclick="return oneditsave()" >确定</button>
	      </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
<script>
// 编辑
function onedit(obj)
{
	$("#editid").val(obj.parentNode.parentNode.cells[0].innerHTML);	
	$("#editcustomerid").val(obj.parentNode.parentNode.cells[1].innerHTML);		
	$("#editremark").val(obj.parentNode.parentNode.cells[4].innerHTML);	
	$("#editordertime").val(obj.parentNode.parentNode.cells[6].innerHTML.trim());		
	$("#editModal").modal(); //修改界面
}

//时间控件初始化
$(".form_datetime").datetimepicker({
	language:  'zh-CN',
	format: 'yyyy-mm-dd',
	autoclose: true,
	weekStart: 1,
    todayBtn:  1,
    todayHighlight: 1,
    minView:3
	});
//$(".form_datetime").datetimepicker( 'update', new Date() );

// 保存
function oneditsave()
{
	if($("#editcustomerid").val()=="")
	{
	alert("请选择客户");return false;
	}
	if($("#editordertime").val()=="")
	{
	alert("请选择订货日期");return false;
	}
	return true;
}

function onadd()
{
	$("#addModal").modal(); //添加界面
}
function onaddsave()
{
	if($("#addcustomerid").val()=="")
	{
	alert("请选择客户");return false;
	}
	if($("#addordertime").val()=="")
	{
	alert("请选择订货日期");return false;
	}
	return true;
}
//下面是对提示对话框的函数
function delcfm(url) {  
    $('#url').val(url);//给会话中的隐藏属性URL赋值  
    $('#delcfmModel').modal();  
}  
function urlSubmit(){  
    var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
    window.location.href=url;        
}
</script>