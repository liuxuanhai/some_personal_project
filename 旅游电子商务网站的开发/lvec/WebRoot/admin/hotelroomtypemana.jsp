<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Roomtype" %> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/roomtype.js'></script>
</head>
<body>
<input type="hidden" value="${sessionScope.hotelid}" id="hotelid"/>
<form class="form-inline definewidth m20" action="#" method="post">  
酒店名称:<label>${sessionScope.hotelname}</label>&nbsp;  &nbsp;  
<button type="button" class="btn btn-primary" id="addnew">添加房型</button>&nbsp;  &nbsp;  
<button type="button" class="btn btn-success" id="backid">返回</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>房型ID</th>
        <th>房型名称</th>
        <th>房型描述</th>
        <th>预订单价(元/天)</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.roomtypelist}" var="roomtype">
        <tr>
        	<td><c:out value="${roomtype.roomid}"/></td>
			<td><c:out value="${roomtype.roomname}"/></td>
			<td><c:out value="${roomtype.roomdescr}"/></td>
			<td><c:out value="${roomtype.roomprice}"/></td>
			<td><a href="#" onclick="onmodifyroomtype(this)">修改</a>&nbsp;&nbsp;
			<a  href="#" onClick="delcfm('../roomtype.do?method=roomtypeDeleteExecute&roomtypeid=<c:out value="${roomtype.roomid}"/>')">删除</a></td>
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

<!-- 信息添加确认 -->
<div class="modal fade" id="addModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">${sessionScope.hotelname}-添加房型</h4>
      </div>
      <div class="modal-body">
      <input type="hidden" value="" id="updatetype"/>
      <input type="hidden" value="" id="roomid"/>
       <div class="form m10"><label for="name">房型名称：</label>&nbsp;&nbsp;
       <input id="roomname" type="text" class="form-control"/></div>
       <div class="form m10"><label for="name">房型描述：</label>&nbsp;&nbsp;
       <textarea rows="3" cols="" id="roomdescr" class="form-control"></textarea></div>
       <div class="form  m10"><label for="name">预订价格：</label>&nbsp;&nbsp;
       <input id="roomprice" type="text" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/></div>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="addRoomtype()" class="btn btn-success" data-dismiss="modal">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


</body>
</html>
<script>
	// 添加按钮的触发
    $(function () {
		$('#addnew').click(function(){
			$("#updatetype").val('1'); //1为添加
			$('#addModel').modal();  
		 });
		$('#backid').click(function(){
			window.location.href="../hotel.do?method=hotelFindExecute";
		 });
    });
	function addRoomtype()
	{
		if($("#addroomname").val()=="")
		{
			alert('请输入房型名称');return;
		}
		if($("#addroomdescr").val()=="")
		{
			alert('请输入房型描述');return;
		}
		if($("#addroomprice").val()=="")
		{
			alert('请输入房型预订价格');return;
		}
		if($("#updatetype").val()=="1")
			roomtype.addRoomtype($("#hotelid").val(),$("#roomname").val(),$("#roomdescr").val(),$("#roomprice").val(),addroomtypecallback);
		else
			roomtype.editRoomtype($("#roomid").val(),$("#roomname").val(),$("#roomdescr").val(),$("#roomprice").val(),addroomtypecallback);
	}
	function addroomtypecallback()
	{
		window.location.href="../roomtype.do?method=roomtypeFindExecute&hotelid="+$("#hotelid").val();
	}
    
	function onmodifyroomtype(obj)
	{
		$("#updatetype").val('2'); //为修改
		$("#roomid").val(obj.parentNode.parentNode.cells[0].innerHTML);
		$("#roomname").val(obj.parentNode.parentNode.cells[1].innerHTML);
		$("#roomdescr").val(obj.parentNode.parentNode.cells[2].innerHTML);
		$("#roomprice").val(obj.parentNode.parentNode.cells[3].innerHTML);
		$('#addModel').modal(); 
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