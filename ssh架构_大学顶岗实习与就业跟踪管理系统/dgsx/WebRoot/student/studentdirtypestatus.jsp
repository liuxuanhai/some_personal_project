<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<div class="container">
<input type="hidden" value="${sessionScope.student.stuid}" name="studentid" id="studentid"/>
 <div class="m30 text-center">
 	<h3>目前去向状态：<span id="currentdirstatue">${sessionScope.student.dirtype}</span>&nbsp;&nbsp;<small><a href="javascript:void(0)" onclick="onmodify()">修改</a></small></h3>
 </div>
</div>


<!-- 对话框 -->
<div class="modal fade" id="editModel">
  <div class="modal-dialog">
    <form class="form" action="#" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="edittitel">修改去向</h4>
	      </div>
	      <div class="modal-body">
	      <div class="form m20">
	      	学生:
	        <span>${sessionScope.student.stuid}-${sessionScope.student.name}</span>
	      </div>
	      <div class="form m20">
	      	去向类型:
	        <select id="editdirtype" name="dirtype" class="form form-control"> 
			<option value="在校">在校</option>
			<option value="顶岗实习">顶岗实习</option>
			<option value="专升本">专升本</option>
			<option value="研究生">研究生</option>
			<option value="公务员">公务员</option>
			<option value="已就业">已就业</option>
			<option value="创业">创业</option>
			<option value="入伍">入伍</option>
			</select>
	      </div>
	      </div>
	      <div class="modal-footer">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <input type="button" class="btn btn-success" value="保存" onclick="savedirtype()"/>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
<script>
	function savedirtype()
	{
		if($("#editdirtype").val()==null||$("#editdirtype").val()=="")
			{
			alert("请选择去向类型");return;
			}
		//提交去向

		student.modifyDirTypeStatus($("#studentid").val(),$("#editdirtype").val(),callback);
	}
	function onmodify()
	{
		$("#editdirtype").val($("#currentdirstatue").html());
		$("#editModel").modal();
	}
    function callback(){
    	$("#editModel").modal('hide');
    	$("#currentdirstatue").html($("#editdirtype").val());
    	alert("修改完成");
    }
</script>