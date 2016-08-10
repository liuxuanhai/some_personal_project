<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">用户名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="用户名" value="${sessionScope.findinfo}">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增用户</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>用户id</th>
        <th>用户名</th>
        <th>真实密码</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.adminlist}" var="administrator">
        <tr>
        	<td><c:out value="${administrator.adminid}"/></td>
			<td><c:out value="${administrator.username}"/></td>
			<td>*****</td>
			<td><a href="../administrator.do?method=administratorBeforeModifyExecute&adminid=<c:out value="${administrator.adminid}"/>"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="#" onClick="delcfm('../administrator.do?method=administratorDeleteExecute&adminid=<c:out value="${administrator.adminid}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
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


</body>
</html>
<script>
	// 页面加载后绑定事件
    $(function () {
		$('#addbtn').click(function(){
				window.location.href="adminadd.jsp";
		 });
		$('#findbtn').click(function(){
			window.location.href="../administrator.do?method=administratorFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
	 });
    });
	
    //下面是删除对话框提示
	function delcfm(url) {  
        $('#url').val(url);//给会话中的隐藏属性URL赋值  
        $('#delcfmModel').modal();  
    }  
	function urlSubmit(){  
        var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
        window.location.href=url+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));       
    }
</script>