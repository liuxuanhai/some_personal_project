<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Hotelorder" %> 
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
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="酒店名称/用户/电话" value="${sessionScope.hotelorderfindnfo}">&nbsp;&nbsp; 
     起止日期
    <input type="text" name="starttime" id="starttime" class="abc input-default form-control" placeholder="开始日期" value="${sessionScope.starttime}">
    -<input type="text" name="endtime" id="endtime" class="abc input-default form-control" placeholder="结束日期" value="${sessionScope.endtime}">&nbsp;&nbsp; 
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>&nbsp;&nbsp;
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>订单id</th>
        <th>用户名</th>
        <th>酒店名称</th>
        <th>房型</th>
        <th>预订单价(元/天)</th>
        <th>预订天数</th>
        <th>预订总额</th>
        <th>入住日期</th>
        <th>取票联系人</th>
        <th>联系电话</th>
        <th>提交时间</th>
        <th>订单状态</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.hotelorderlist}" var="hotelorder">
        <tr>
        	<td><c:out value="${hotelorder.orderid}"/></td>
			<td><c:out value="${hotelorder.username}"/></td>
			<td><c:out value="${hotelorder.hotelname}"/></td>
			<td><c:out value="${hotelorder.roomname}"/></td>
			<td><c:out value="${hotelorder.roomprice}"/></td>
			<td><c:out value="${hotelorder.nums}"/></td>
			<td><c:out value="${hotelorder.totalprice}"/></td>
			<td><c:out value="${hotelorder.checkintime}"/></td>
			<td><c:out value="${hotelorder.name}"/></td>
			<td><c:out value="${hotelorder.phone}"/></td>
			<td><c:out value="${hotelorder.ordertime}"/></td>
			<td>
				<c:choose>
				       <c:when test="${hotelorder.orderstatus=='0'}">
				       	提交
				       </c:when>
				       <c:otherwise>
				       	已付款
				       </c:otherwise>
				</c:choose>
			</td>
			<td><a  href="#" onClick="delcfm('../hotelorder.do?method=hotelorderDeleteExecute&hotelorderid=<c:out value="${hotelorder.orderid}"/>')">删除</a></td>
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
function isDate(str)
{
    if(!/^(\d{4})\-(\d{1,2})\-(\d{1,2})$/.test(str))
        return false;
    var year = RegExp.$1-0;
    var month = RegExp.$2-1;
    var date = RegExp.$3-0;
    var obj = new Date(year,month,date);
    return !!(obj.getFullYear()==year && obj.getMonth()==month && obj.getDate()==date);
}

 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			if(!isDate($("#starttime").val()))
			{
				alert('请输入有效开始日期，如2016-01-22');return;
			}
			if(!isDate($("#endtime").val()))
			{
				alert('请输入有效截止日期，如2016-01-22');return;
			}
			
		      //将字符串转换为日期
		      var begin=new Date($("#starttime").val().replace(/-/g,"/"));
		      var end=new Date($("#endtime").val().replace(/-/g,"/"));
		      //js判断日期
		      if(begin-end>0){
		         alert("开始日期要在截止日期之前!");  
		         return;
		      }
			
			//encode两次
			window.location.href="../hotelorder.do?method=hotelorderFindExecute&hotelorderfindnfo="+encodeURI(encodeURI(document.getElementById("usernameorid").value))
					+"&starttime="+$("#starttime").val()+"&endtime="+$("#endtime").val();
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