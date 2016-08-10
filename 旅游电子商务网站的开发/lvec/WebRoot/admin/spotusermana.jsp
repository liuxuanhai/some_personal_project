<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Spotuser" %> 
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
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="用户名/姓名" value="">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>&nbsp;&nbsp; 
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>会员id</th>
        <th>用户名</th>
        <th>登录密码</th>
        <th>姓名</th>
        <th>联系电话</th>
        <th>地址</th>
        <th>删除</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.spotuserlist}" var="spotuser">
        <tr>
        	<td><c:out value="${spotuser.userid}"/></td>
			<td><c:out value="${spotuser.username}"/></td>
			<td><c:out value="${spotuser.userpwd}"/></td>
			<td><c:out value="${spotuser.name}"/></td>
			<td><c:out value="${spotuser.phone}"/></td>
			<td><c:out value="${spotuser.addr}"/></td>
			<td><a  href="#" onClick="delcfm('../spotuser.do?method=spotuserDeleteExecute&spotuserid=<c:out value="${spotuser.userid}"/>')">删除</a></td>
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
    
 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			//encode两次
			window.location.href="../spotuser.do?method=spotuserFindExecute&spotuserfindnfo="+encodeURI(encodeURI(document.getElementById("usernameorid").value));
		 });
    });

	
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