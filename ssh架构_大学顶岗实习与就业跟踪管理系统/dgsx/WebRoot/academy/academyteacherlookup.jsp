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
    <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/teacher.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">姓名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="工号/姓名/电话/身份证..." value="${sessionScope.findinfo}" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>
</form>
<input type="hidden" value="${sessionScope.academyteacher.academyid}" id="academyid"/>
<table class="table table-bordered table-hover definewidth m10">
<caption class="text-center">${sessionScope.academyteacher.academyname}</caption>
    <thead>
    <tr>
        <th>工号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>职称</th>
        <th>研究方向</th>
        <th>电话</th>
        <th>身份证</th>
        <th>入职日期</th>
        <th>QQ号</th>
        <th>角色类型</th>
        <th>指导班级数</th>
        <th>指导班级</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.teacherlist}" var="teacher">
        <tr>
        	<td><c:out value="${teacher.teaid}"/></td>
			<td><c:out value="${teacher.name}"/></td>
			<td><c:out value="${teacher.sex}"/></td>
			<td><c:out value="${teacher.level}"/></td>
			<td><c:out value="${teacher.direction}"/></td>
			<td><c:out value="${teacher.phone}"/></td>
			<td><c:out value="${teacher.idcard}"/></td>
			<c:set var="stringtime" value="${fn:split(teacher.schooltime, ' ')}" />
			<td><c:out value="${stringtime[0]}"/></td>
			<td><c:out value="${teacher.qqid}"/></td>
			<td>
			<c:choose>
		       <c:when test="${teacher.roletype=='0'}">
		              普通
		       </c:when>
		       <c:otherwise>
		            院系管理员
		       </c:otherwise>
			</c:choose>
			</td>
			<td> <c:out value="${fn:length(teacher.classrooms)}"/></td>
			<td><a href="javascript:void(0)" onclick="onlookclass(this)">查看班级</a></td>
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

<!-- 对话框 -->
<div class="modal fade" id="lookModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">指导班级数目:<span id="teacherclassnum"></span></h4>
      </div>
      <div class="modal-body m30">
       <table id="teacherclasstable">
       </table>
      </div>
      <div class="modal-footer ">
      	 <div class="text-center"><button type="button" class="btn btn-default" data-dismiss="modal">确定</button></div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
<script>

//查看指导班级
function onlookclass(obj)
{
	
	//alert(obj.parentNode.parentNode.cells[0].innerHTML);
	teacher.getTeacherClass(obj.parentNode.parentNode.cells[0].innerHTML,callback);//获得教师知道班级
}
function callback(data)
{
	var n=data.length;
	$("#teacherclassnum").html(n);
	$("#teacherclasstable").html("");
	for(var i=0;i<n;++i)
		$("#teacherclasstable").append("<tr><td>"+data[i]+"</td></tr>");
	$('#lookModel').modal();
}
	// 页面加载后绑定事件
    $(function () {
		$('#findbtn').click(function(){
			window.location.href="../teacher.do?method=academyTeacherFindByAcademyIDExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
	 });
    });
	
    function onprevious()
    {
    	if(parseInt($("#pagenumber").val())<=1)
    	{
    		alert('已经是首页');return;
    	}
    	var pagenumber=parseInt($("#pagenumber").val())-1;
    	window.location.href="../teacher.do?method=academyTeacherFindByAcademyIDExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
    }
    function onnext()
    {
    	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
    	{
    		alert('已经是尾页');return;
    	}
    	var pagenumber=parseInt($("#pagenumber").val())+1;
    	window.location.href="../teacher.do?method=academyTeacherFindByAcademyIDExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
    }
</script>