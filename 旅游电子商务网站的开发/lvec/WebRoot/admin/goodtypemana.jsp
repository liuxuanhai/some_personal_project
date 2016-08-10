<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Goodtype" %> 
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
	<script type='text/javascript' src='../dwr/interface/goodtype.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
<button type="button" class="btn btn-success" id="addnew">新增类别</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>类别id</th>
        <th>类别名称</th>
        <th>类别描述</th>
        <th>修改</th>
        <th>删除</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.goodtypelist}" var="goodtype">
        <tr>
        	<td><c:out value="${goodtype.typeid}"/></td>
			<td><c:out value="${goodtype.typename}"/></td>
			<td><c:out value="${goodtype.typedescr}"/></td>
			<td><a href="#" onclick="onmodify(this)">修改</a></td>
			<td><a  href="#" onClick="delcfm('../goodtype.do?method=goodtypeDeleteExecute&goodtypeid=<c:out value="${goodtype.typeid}"/>')">删除</a></td>
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
        <h4 class="modal-title">类别添加</h4>
      </div>
      <div class="modal-body form">
      <div class="form m10">
      <label>类别名称</label>&nbsp;&nbsp;
        <input type="text" value="" class="form-control" id="addtypename" placeholder="类别名称"/></div>
        <div class="form  m10">
      <label>类别描述</label>&nbsp;&nbsp;
        <textarea class="form-control" rows="3" cols="" id="addtypedescr" placeholder="类别描述"></textarea></div>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="addtype()" class="btn btn-success" data-dismiss="modal">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 信息修改确认 -->
<div class="modal fade" id="editModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">类别修改</h4>
      </div>
      <div class="modal-body form">
      <input type="hidden" id="edittypeid"/>
      <div class="form  m10">
      <label>类别名称</label>&nbsp;&nbsp;<input type="text" value="" class="form-control" id="edittypename" />
      </div>
       <div class="form m10">
      <label>类别描述</label>&nbsp;&nbsp;<textarea class="form-control" rows="3" cols="" id="edittypedescr"></textarea>
      </div>        
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="edittype()" class="btn btn-success" data-dismiss="modal">确定</a>
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
			$('#addModel').modal('show'); 
		 });
    });
	function addtype()
	{
		if($("#addtypename").val()==""){
			alert('请输入类别名称');return;
		}
		if($("#addtypedescr").val()==""){
			alert('请输入类别描述');return;
		}
		goodtype.goodtypeAdd($("#addtypename").val(),$("#addtypedescr").val(),addcallback);
	}
	function addcallback()
	{
		$("#addtypename").val('');
		$("#addtypedescr").val('');
		$('#addModel').modal('hide');
		alert("添加完成");
		window.location.href="../goodtype.do?method=goodtypeAllExecute";  // 刷新
	}
	function onmodify(obj)
	{
		$("#edittypeid").val(obj.parentNode.parentNode.cells[0].innerHTML);
		$("#edittypename").val(obj.parentNode.parentNode.cells[1].innerHTML);
		$("#edittypedescr").val(obj.parentNode.parentNode.cells[2].innerHTML);
		$('#editModel').modal('show');
	}
	
	function edittype()
	{
		if($("#edittypename").val()==""){
			alert('请输入类别名称');return;
		}
		if($("#edittypedescr").val()==""){
			alert('请输入类别描述');return;
		}
		goodtype.goodtypeEdit($("#edittypeid").val(),$("#edittypename").val(),$("#edittypedescr").val(),editcallback);
	}
	function editcallback()
	{
		$("#edittypeid").val('');
		$("#edittypename").val('');
		$("#edittypedescr").val('');
		$('#editModel').modal('hide');
		alert("修改完成");
		window.location.href="../goodtype.do?method=goodtypeAllExecute";  // 刷新
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