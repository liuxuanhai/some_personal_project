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
    
    <label class="sr-only" for="name">院系名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="院系名称" value="${sessionScope.findinfo}">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增院系</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>院系id</th>
        <th>院系名称</th>
        <th>院系简介</th>
        <th>院系班级</th>
        <th>查看教师</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.academylist}" var="academy">
        <tr>
        	<td><c:out value="${academy.academyid}"/></td>
			<td><c:out value="${academy.academyname}"/></td>
			<td><c:out value="${academy.academydescr}"/></td>
			<td><a href="javascript:void(0)" onclick="classmana(this)">班级管理</a></td>
			<td><a href="../teacher.do?method=teacherFindByAcademyIDExecute&academyid=<c:out value="${academy.academyid}"/>">查看教师</a></td>
			<td><a href="../academy.do?method=academyBeforeModifyExecute&academyid=<c:out value="${academy.academyid}"/>"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="javascript:void(0)" onClick="delcfm('../academy.do?method=academyDeleteExecute&academyid=<c:out value="${academy.academyid}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
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
function classmana(obj)
{
	window.location.href="../classroom.do?method=classroomFindExecute&academyid="+obj.parentNode.parentNode.cells[0].innerHTML;
}
	// 页面加载后绑定事件
    $(function () {
		$('#addbtn').click(function(){
				window.location.href="academyadd.jsp";
		 });
		$('#findbtn').click(function(){
			window.location.href="../academy.do?method=academyFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
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