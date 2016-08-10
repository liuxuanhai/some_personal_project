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
    
    <label class="sr-only" for="name">姓名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="工号/姓名/电话/身份证..." value="${sessionScope.findinfo}" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增教师</button>
    &nbsp;&nbsp; 
        <button type="button" class="btn btn-default" id="import" onclick="onimport()">批量导入</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>工号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>学院</th>
        <th>职称</th>
        <th>研究方向</th>
        <th>电话</th>
        <th>身份证</th>
        <th>入职日期</th>
        <th>QQ号</th>
        <th>角色类型</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.teacherlist}" var="teacher">
        <tr>
        	<td><c:out value="${teacher.teaid}"/></td>
			<td><c:out value="${teacher.name}"/></td>
			<td><c:out value="${teacher.sex}"/></td>
			<td><c:out value="${teacher.academy.academyname}"/></td>
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
			<td><a href="../teacher.do?method=teacherBeforeModifyExecute&teacherid=<c:out value="${teacher.teaid}"/>"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="javascript:void(0)" onClick="delcfm('../teacher.do?method=teacherDeleteExecute&teacherid=<c:out value="${teacher.teaid}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
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


<!-- 对话框-->
<div class="modal fade" id="importModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">导入教师(严格格式的excel文件)</h4>
      </div>
      <div class="modal-body">
        <form id="importform" action="../servlet/importTeacherServlet" enctype="multipart/form-data" method="post" class="definewidth m20">
        <div class="from-inline">
        <label for="name">学院：</label>
        <select id="importacademy" name="importacademy" style="width:200px;">
        <c:forEach items="${sessionScope.teaacademylist}" var="teaacademy">
       	<option value="<c:out value="${teaacademy.academyid}"/>">
       	<c:out value="${teaacademy.academyname}"/>
       	</option>
		</c:forEach>
        </select>
        </div>
        <div class="from-inline">
        <label for="name">excel文件：</label><input  type="file" class="file form-control" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" id="file" name="file">
        </div>
        </form>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="onImportCheck()" class="btn btn-success">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
<script>

function onprevious()
{
	if(parseInt($("#pagenumber").val())<=1)
	{
		alert('已经是首页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())-1;
	window.location.href="../teacher.do?method=teacherFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../teacher.do?method=teacherFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}

//导入
function onimport()
{
	$('#importModel').modal();  
}
function onImportCheck()
{
	if($("#importacademy").val()==""||$("#importacademy").val()==null)
	{  
         alert("请选择院系");  
         return;  
    }  
    if($('#file')[0].files.length<1)
	{
		alert("请添加excel教师文件");return;
	}
    $("#importform").submit();//开始导入
}


	// 页面加载后绑定事件
    $(function () {
		$('#addbtn').click(function(){
				window.location.href="../teacher.do?method=teacherBeforeAddexecute";
		 });
		$('#findbtn').click(function(){
			window.location.href="../teacher.do?method=teacherFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
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