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
<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">学号姓名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="学号/姓名/电话/身份证..." value="${sessionScope.findinfo}" style="width:200px;">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" >查询</button>&nbsp;&nbsp; 
    <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增学生</button>&nbsp;&nbsp; 
        <button type="button" class="btn btn-default" id="import" onclick="onimport()">批量导入</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>学院班级</th>
        <th>电话</th>
        <th>身份证</th>
        <th>入学日期</th>
        <th>QQ号</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.studentlist}" var="student">
        <tr>
        	<td><c:out value="${student.stuid}"/></td>
			<td><c:out value="${student.name}"/></td>
			<td><c:out value="${student.sex}"/></td>
			<td><c:out value="${student.classroom.academy.academyname}"/>&nbsp;&nbsp;<c:out value="${student.classroom.classname}"/></td>
			<td><c:out value="${student.phone}"/></td>
			<td><c:out value="${student.idcard}"/></td>
			<c:set var="stringtime" value="${fn:split(student.schooltime, ' ')}" />
			<td><c:out value="${stringtime[0]}"/></td>
			<td><c:out value="${student.qqid}"/></td>
			<td><a href="../student.do?method=studentBeforeModifyExecute&studentid=<c:out value="${student.stuid}"/>"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="javascript:void(0)" onClick="delcfm('../student.do?method=studentDeleteExecute&studentid=<c:out value="${student.stuid}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
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
        <h4 class="modal-title">导入学生(严格格式的excel文件)</h4>
      </div>
      <div class="modal-body">
        <form id="importform" action="../servlet/importStudentServlet" enctype="multipart/form-data" method="post" class="definewidth m20">
        <div class="from-inline">
        <label for="name">学院：</label>
        <select id="importacademy" name="importacademy" onchange="changeacademy()" style="width:200px;">
        <c:forEach items="${sessionScope.stuacademylist}" var="stuacademy">
       	<option value="<c:out value="${stuacademy.academyid}"/>">
       	<c:out value="${stuacademy.academyname}"/>
       	</option>
		</c:forEach>
        </select>
        </div>
        <div class="from-inline">
        <label  for="name">班级：</label>
        <select id="importclassroom" name="importclassroom" style="width:200px;">
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
	window.location.href="../student.do?method=studentFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../student.do?method=studentFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}

function changeacademy()
{
	student.getAcademyClassroom($("#importacademy").val(),getAcademyClassroomCallback);	
}
//初始化院系班级
function getAcademyClassroomCallback(data)
{
	$("#importclassroom").html(""); 
	for(var i=0;i<data.length;++i)
		$("#importclassroom").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>");
}
//导入
function onimport()
{
	changeacademy();
	$('#importModel').modal();  
}
function onImportCheck()
{
	if($("#importacademy").val()==""||$("#importacademy").val()==null)
	{  
         alert("请选择院系");  
         return;  
    }  
    if($("#importclassroom").val()==""||$("#importclassroom").val()==null)  
    {  
        alert("请选择班级");  
        return;  
    }
    if($('#file')[0].files.length<1)
	{
		alert("请添加excel学生文件");return;
	}
    $("#importform").submit();//开始导入
}

	// 页面加载后绑定事件
    $(function () {
		$('#addbtn').click(function(){
				window.location.href="../student.do?method=studentBeforeAddexecute";
		 });
		$('#findbtn').click(function(){
			window.location.href="../student.do?method=studentFindExecute&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
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