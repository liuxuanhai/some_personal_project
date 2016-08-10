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
	        <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/classroom.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">姓名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="工号/姓名/电话/身份证..." value="" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" onclick="onfind()">查询</button>&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" onclick="onback()">返回</button>&nbsp;&nbsp;  
</form>
<input type="hidden" value="${sessionScope.oneacademyinfo.academyid}" id="academyid"/>
<table class="table table-bordered table-hover definewidth m10" id="teachertable">
<caption class="text-center">${sessionScope.oneacademyinfo.academyname}-${sessionScope.classroom.classname}-分配指导教师
<input type="hidden" id="classid" value="${sessionScope.classroom.classid}"/>
</caption>
    <thead>
    <tr>
        <th>工号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>职称</th>
        <th>研究方向</th>
        <th>电话</th>
        <th>入职日期</th>
        <th>角色类型</th>
        <th>指导班级数</th>
        <th>分配</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.oneacademyinfo.teachers}" var="teacher">
        <tr>
        	<td><c:out value="${teacher.teaid}"/></td>
			<td><c:out value="${teacher.name}"/></td>
			<td><c:out value="${teacher.sex}"/></td>
			<td><c:out value="${teacher.level}"/></td>
			<td><c:out value="${teacher.direction}"/></td>
			<td><c:out value="${teacher.phone}"/></td>
			<c:set var="stringtime" value="${fn:split(teacher.schooltime, ' ')}" />
			<td><c:out value="${stringtime[0]}"/></td>
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
			<td>
				<a href="javascript:void(0)" onclick="onFPTeacher(this)">确认分配</a>
			</td>
		</tr>
		</c:forEach>
</table>

<!-- 对话框 -->
<div class="modal fade" id="fpModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">提示</h4>
      </div>
      <div class="modal-body">
    <div class="m30">
   <input type="hidden" id="fpteaid"/>
   确定指定<span id="fpteachername"></span>为${sessionScope.classroom.classname}的指导教师吗？
    </div>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="onsaveZhidaolaoshi()" class="btn btn-success">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
<script>

function onFPTeacher(obj)
{
	$("#fpteaid").val(obj.parentNode.parentNode.cells[0].innerHTML);
	$("#fpteachername").html(obj.parentNode.parentNode.cells[1].innerHTML);
	$("#fpModel").modal();
}
function onsaveZhidaolaoshi()
{
	//确定指导教师
	classroom.setTeacherToClassroom($("#classid").val(),$("#fpteaid").val(),callback);
}
function callback()
{
	alert("指定指导教师成功");	
	onback();//返回
}
function onback()
{
	window.location.href="../classroom.do?method=academyClassroomFindExecute&academyid="+$("#academyid").val();
}
function onsaveteacher()
{
	//保存	
}
function onfind()
{
	//查找
	for(var i=1;i<$("#teachertable tr").length;++i)
	{
		$("#teachertable tr:eq("+i+")").addClass("hide");
		if($("#teachertable tr:eq("+i+") td:eq(0)").html().indexOf($("#findinfo").val())>=0||$("#teachertable tr:eq("+i+") td:eq(1)").html().indexOf($("#findinfo").val())>=0||$("#teachertable tr:eq("+i+") td:eq(3)").html().indexOf($("#findinfo").val())>=0||$("#teachertable tr:eq("+i+") td:eq(5)").html().indexOf($("#findinfo").val())>=0)
			$("#teachertable tr:eq("+i+")").removeClass("hide");
	}
}
</script>