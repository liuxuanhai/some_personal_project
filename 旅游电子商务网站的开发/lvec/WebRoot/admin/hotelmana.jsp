<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Hotel" %> 
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
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="景点名称/城市" value="">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增酒店</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>酒店id</th>
        <th>酒店名称</th>
        <th>酒店城市</th>
        <th>详细地址</th>
        <th>预订起价(元/天)</th>
        <th>房型管理</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.hotellist}" var="hotel">
        <tr>
        	<td><c:out value="${hotel.hotelid}"/></td>
			<td><c:out value="${hotel.hotelname}"/></td>
			<td><c:out value="${hotel.hotelcity}"/></td>
			<td><c:out value="${hotel.hoteladdr}"/></td>
			<td><c:out value="${hotel.hotelprice}"/></td>
			<td><a href="../roomtype.do?method=roomtypeFindExecute&hotelid=<c:out value="${hotel.hotelid}"/>">房型管理</a></td>
			<td><a href="../hotel.do?method=hotelBeforeModifyExecute&hotelid=<c:out value="${hotel.hotelid}"/>">修改</a>&nbsp;&nbsp;
			<a  href="#" onClick="delcfm('../hotel.do?method=hotelDeleteExecute&hotelid=<c:out value="${hotel.hotelid}"/>')">删除</a></td>
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

				window.location.href="hoteladd.jsp";
		 });
    });
    
 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			//encode两次
			window.location.href="../hotel.do?method=hotelFindExecute&hotelfindnfo="+encodeURI(encodeURI(document.getElementById("usernameorid").value));
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