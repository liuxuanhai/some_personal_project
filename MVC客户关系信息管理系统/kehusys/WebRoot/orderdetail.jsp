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

<div class="container m20">
	<div class="m20 row">
	<div class="col-sm-3 col-md-offset-1">
	订单编号：${requestScope.ordermana.ordernum}
	</div>
	<div class="col-sm-2">
	客户名称：${requestScope.ordermana.kename}
	</div>
	<div class="col-sm-3">
	订货日期：${requestScope.ordermana.ordertime}
	</div>
	<div class="col-sm-2">
	负责员工：${requestScope.ordermana.ygname}
	</div>
	</div>
	<table class="table table-bordered table-hover definewidth m10">
	<caption class="text-center">
	<a href="<%=path %>/servlet/OrdermanaServlet?method=getOrdermana&userid=${requestScope.userid}" class="btn btn-default">返回上级</a>&nbsp;&nbsp;
	
	<c:if test="${requestScope.ordermana.yuangongid==requestScope.userid }">
	<input value="添加产品" type="button" class="btn btn-success" onclick="onadd()"/>
	<input value="导入excel" type="button" class="btn btn-success" onclick="onimport()"/>
	
	</c:if>
	
	
	
	</caption>
	    <thead>
	    <tr>
	        <th>产品名称</th>
	        <th>产品单价(元)</th>
	        <th>订购数量</th>
	        <th>订购总额(元)</th>
	        <th>备注</th>
	        <th>添加时间</th>
	        <th>操作</th>
	    </tr>
	    </thead>
	        <c:forEach items="${requestScope.orderdetaillist}" var="order">
	        <tr>
	        	<td class="hide"><c:out value="${order.id}"/></td>
	        	<td><c:out value="${order.name}"/></td>
				<td><c:out value="${order.price}"/></td>
				<td><c:out value="${order.nums}"/></td>
				<td><c:out value="${order.totalprice}"/></td>
				<td><c:out value="${order.remark}"/></td>
				<td><c:out value="${order.addtime}"/></td>
				<td>
				<c:if test="${requestScope.ordermana.yuangongid==requestScope.userid }">
				<a href="#" onclick="onedit(this)">修改</a>&nbsp;&nbsp;
				<a  href="#" onClick="delcfm('<%=path %>/servlet/OrderdetailServlet?method=delOrderdetail&orderdetailid=<c:out value="${order.id}"/>&userid=${requestScope.userid}&ordernum=<c:out value="${order.ordernum}"/>')">删除</a>
				</c:if>
				</td>
			</tr>
			</c:forEach>
	</table>
</div>


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
        <h4 class="modal-title">添加产品</h4>
      </div>
      <form action="<%=path %>/servlet/OrderdetailServlet?method=addOrderdetail" method="post">
	      	<div class="modal-body">
	      	<input class="hide" name="userid" value="${requestScope.userid}"/>
	      	<input class="hide" name="ordernum" value="${requestScope.ordernum}"/>
	        <div class="form m10">
	        	产品名称
				<input type="text" id="addname" name="name"  class="form-control"/>
	        </div>
	        <div class="form m10">
	        	产品单价
				<input type="text" id="addprice" name="price"  class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	订购数量
				<input type="text" id="addnums" name="nums"  class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
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
      <form action="<%=path %>/servlet/OrderdetailServlet?method=editOrderdetail" method="post">
	      <div class="modal-body">
	      <input class="hide" name="userid" value="${requestScope.userid}"/>
	      <input class="hide" name="ordernum" value="${requestScope.ordernum}"/>
	      <input type="hidden" id="editid" name="orderdetailid"/>
	       <div class="form m10">
	        	产品名称
				<input type="text" id="editname" name="name"  class="form-control"/>
	        </div>
	        <div class="form m10">
	        	产品单价
				<input type="text" id="editprice" name="price"  class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	订购数量
				<input type="text" id="editnums" name="nums"  class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
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


<!-- 导入详单-->
<div class="modal fade" id="importModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">导入详单</h4>
      </div>
      <form action="<%=path %>/servlet/OrderdetailImportServlet" enctype="multipart/form-data" method="post">
	      <div class="modal-body">
	      <input class="hide" name="userid" value="${requestScope.userid}"/>
	      <input class="hide" name="ordernum" value="${requestScope.ordernum}"/>
	       <div class="form m10">
	        	详单excel
				<input type="file" class="file form-control" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" id="file" name="file">	
	        </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-success" onclick="return onimportcheck()" >确定</button>
	      </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
<script>
function onimport()
{
	$("#importModal").modal();
}
function onimportcheck()
{
	if($('#file')[0].files.length<1)
	{
		alert('请添加excel文件');return false;
	}
	return true;
}
// 编辑
function onedit(obj)
{
	
	$("#editid").val(obj.parentNode.parentNode.cells[0].innerHTML);	
	$("#editname").val(obj.parentNode.parentNode.cells[1].innerHTML);		
	$("#editprice").val(obj.parentNode.parentNode.cells[2].innerHTML);	
	$("#editnums").val(obj.parentNode.parentNode.cells[3].innerHTML.trim());
	$("#editremark").val(obj.parentNode.parentNode.cells[5].innerHTML.trim());	
	$("#editModal").modal(); //修改界面
}


// 保存
function oneditsave()
{
	if($("#editname").val()=="")
	{
	alert("请输入产品名称");return false;
	}
	if($("#editprice").val()=="")
	{
	alert("请输入产品单价");return false;
	}
	if($("#editnums").val()=="")
	{
	alert("请输入产订购数量");return false;
	}
	return true;
}

function onadd()
{
	$("#addModal").modal(); //添加界面
}
function onaddsave()
{
	if($("#addname").val()=="")
	{
	alert("请输入产品名称");return false;
	}
	if($("#addprice").val()=="")
	{
	alert("请输入产品单价");return false;
	}
	if($("#addnums").val()=="")
	{
	alert("请输入产订购数量");return false;
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