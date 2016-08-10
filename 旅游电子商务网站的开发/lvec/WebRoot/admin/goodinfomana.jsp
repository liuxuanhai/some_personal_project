<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Goodinfo1" %> 
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
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="商品名称/类别" value="">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增产品</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>产品id</th>
        <th>所属类别</th>
        <th>产品名称</th>
        <th>产品单价(元)</th>
        <th>产品描述</th>
        <th>库存</th>
        
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.goodinfolist}" var="good">
        <tr>
        	<td><c:out value="${good.goodid}"/></td>
        	<td><c:out value="${good.typename}"/></td>
			<td><c:out value="${good.goodname}"/></td>
			<td><c:out value="${good.goodprice}"/></td>
			<td><c:out value="${good.gooddescr}"/></td>
			<td><c:out value="${good.goodnum}"/></td>
			<td><a href="../goodinfo.do?method=goodinfoBeforeModifyExecute&goodinfoid=<c:out value="${good.goodid}"/>">修改</a>&nbsp;&nbsp;
			<a  href="#" onClick="delcfm('../goodinfo.do?method=goodinfoDeleteExecute&goodinfoid=<c:out value="${good.goodid}"/>')">删除</a></td>
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
	// 添加按钮的触发
    $(function () {
		$('#addnew').click(function(){

				window.location.href="goodinfoadd.jsp";
		 });
    });
    
 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			//encode两次
			window.location.href="../goodinfo.do?method=goodinfoFindExecute&goodinfofindnfo="+encodeURI(encodeURI(document.getElementById("usernameorid").value));
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