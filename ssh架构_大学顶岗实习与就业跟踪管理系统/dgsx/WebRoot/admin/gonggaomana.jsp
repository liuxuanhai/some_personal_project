<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
    
    <label class="sr-only" for="name">名称：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="公告题目" value="${sessionScope.findinfo}" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>&nbsp;&nbsp; 
    <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增</button>&nbsp;&nbsp; 
</form>
<table class="table table-bordered table-hover definewidth m10" style="table-layout:fixed">
    <thead>
    <tr>
        <th width="40%">公告题目</th>
        <th>更新时间</th>
        <th>浏览量</th>
        <th>查看详情</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.gonggaolist}" var="gonggao">
        <tr>
        	<td><c:out value="${gonggao.title}"/></td>
			<td><c:out value="${gonggao.addtime}"/></td>
			<td><c:out value="${gonggao.looknum}"/></td>
			
			<td><a target="_brank" href="../gonggao.do?method=gonggaoInfoLookExecute&gonggaoid=<c:out value="${gonggao.id}"/>">查看</a></td>
			<td><a href="../gonggao.do?method=gonggaoBeforeModifyExecute&gonggaoid=<c:out value="${gonggao.id}"/>"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="javascript:void(0)" onClick="delcfm('../gonggao.do?method=gonggaoDeleteExecute&gonggaoid=<c:out value="${gonggao.id}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
		</tr>
		</c:forEach>
</table>

<div>
<input type="hidden" value="${sessionScope.pagenumber}" id="pagenumber"/>
<input type="hidden" value="${sessionScope.maxpagenumber}" id="maxpagenumber"/>
	<ul class="pager">
  		<li><a href="javascript:void(0)"  onclick="onprevious()">上一页</a></li>
  		<li><a href="javascript:void(0)"  onclick="onnext()">下一页</a></li>
	</ul>
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

</body>
</html>
<script>

function onprevious()
{
	if(parseInt($("#pagenumber").val())==1)
	{
		alert('已经是首页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())-1;
	window.location.href="../gonggao.do?method=gonggaoFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())==parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../gonggao.do?method=gonggaoFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}

// 页面加载后绑定事件
   $(function () {
	$('#addbtn').click(function(){
			window.location.href="gonggaoadd.jsp";
	 });
	$('#findbtn').click(function(){
		window.location.href="../gonggao.do?method=gonggaoFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
 	});
   });

   //下面是删除对话框提示
function delcfm(url) {  
       $('#url').val(url);//给会话中的隐藏属性URL赋值  
       $('#delcfmModel').modal();  
   }  
function urlSubmit(){  
       var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
       window.location.href=url+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+$("#pagenumber").val();   
   }
</script>