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
        <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/classroom.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">班级名：</label>
    <input type="text" name="findinfo" id="findinfo"class="abc input-default form-control" placeholder="班级名称" value="${sessionScope.findinfo}">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findbtn" onclick="onfind()">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn"><span class="glyphicon glyphicon-plus"></span>新增班级</button>
    &nbsp;&nbsp;<button type="button" class="btn btn-default" id="backid" onclick="onback()">返回上级</button>
</form>
<table class="table table-bordered table-hover definewidth m10" id="classtable">
<CAPTION class="text-center"><span id="classtitel">${sessionScope.classroomacademy.academyname}</span>-班级列表
<input type="hidden" value="${sessionScope.classroomacademy.academyid}" id="academyid"/>
</CAPTION>
    <thead>
    <tr>
        <th>班级id</th>
        <th>班级名称</th>
        <th>班级简介</th>
        <th>查看学生</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${sessionScope.classroomlist}" var="classroom">
        <tr>
        	<td><c:out value="${classroom.classid}"/></td>
			<td><c:out value="${classroom.classname}"/></td>
			<td><c:out value="${classroom.classdescr}"/></td>
			<td><a href="../student.do?method=studentFindByClassIDExecute&classid=<c:out value="${classroom.classid}"/>" >查看学生</a></td>
			<td><a href="javascript:void(0)" onclick="classmodify(this)"><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;&nbsp;
			<a  href="javascript:void(0)" onClick="delcfm('../classroom.do?method=classroomDeleteExecute&classroomid=<c:out value="${classroom.classid}"/>')"><span class="glyphicon glyphicon-remove"></span></a></td>
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

<!-- 对话框 -->
<div class="modal fade" id="addModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">添加班级</h4>
      </div>
      <div class="modal-body">
      <form id="addform" action="../classroom.do?method=classroomAddExecute" method="post">
      <input type="hidden" class="form-control" name="academyid" value="${sessionScope.classroomacademy.academyid}"/>
        <div>
        班级名称
        <input type="text" class="form-control" id="addclassname" name="classname"/>
        </div>
        <div>
        班级描述
        <textarea rows="3" cols="" class="form-control" id="addclassdescr" name="classdescr"></textarea>
        </div>
      </form>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="onaddclass()" class="btn btn-success">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 对话框 -->
<div class="modal fade" id="editModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">添加班级</h4>
      </div>
      <div class="modal-body">
      <form id="editform" action="../classroom.do?method=classroomModifyExecute" method="post">
      <input type="hidden" class="form-control" name="academyid" value="${sessionScope.classroomacademy.academyid}"/>
        <div>
        班级名称
        <input type="hidden" class="form-control" id="editclassid" name="classid"/>
        <input type="hidden" class="form-control" id="edithidename"/>
        <input type="text" class="form-control" id="editclassname" name="classname"/>
        </div>
        <div>
        班级描述
        <textarea rows="3" cols="" class="form-control" id="editclassdescr" name="classdescr"></textarea>
        </div>
      </form>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="oneditclass()" class="btn btn-success">确定</a>
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
	window.location.href="../classroom.do?method=classroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}
function onnext()
{
	if(parseInt($("#pagenumber").val())>=parseInt($("#maxpagenumber").val()))
	{
		alert('已经是尾页');return;
	}
	var pagenumber=parseInt($("#pagenumber").val())+1;
	window.location.href="../classroom.do?method=classroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()))+"&pagenumber="+pagenumber;
}

function classmodify(obj)
{
	$("#editclassid").val(obj.parentNode.parentNode.cells[0].innerHTML);
	$("#edithidename").val(obj.parentNode.parentNode.cells[1].innerHTML);
	$("#editclassname").val(obj.parentNode.parentNode.cells[1].innerHTML);
	$("#editclassdescr").val(obj.parentNode.parentNode.cells[2].innerHTML);
	$('#editModel').modal();  
}
function onaddclass()
{
	if($("#addclassname").val()=="")
	{
		alert('请输入班级姓名');
		return;
	}
	if($("#addclassdescr").val()=="")
	{
		alert('请输入班级描述');
		return;
	}
	classroom.findClassroomName($("#addclassname").val(),addcallback);
}
function addcallback(data)
{
	if(data==true)
	{
		alert('此班级名称已经存在数据库中，请修改');return;
	}
	$("#addform").submit();
}
function oneditclass()
{
	if($("#editclassname").val()=="")
	{
		alert('请输入班级姓名');
		return;
	}
	if($("#editclassdescr").val()=="")
	{
		alert('请输入班级描述');
		return;
	}
	if($("#edithidename").val()==$("#editclassname").val().trim())
		$("#editform").submit();
	else
		classroom.findClassroomName($("#editclassname").val(),editcallback);
}
function editcallback(data)
{
	if(data==true)
	{
		alert('此班级名称已经存在数据库中，请修改');return;
	}
	$("#editform").submit();
}
	// 页面加载后绑定事件
    $(function () {
		$('#addbtn').click(function(){
			$('#addModel').modal();  
		 });
    });
	
    //下面是删除对话框提示
	function delcfm(url) {  
        $('#url').val(url);//给会话中的隐藏属性URL赋值  
        $('#delcfmModel').modal();  
    }  
	function urlSubmit(){  
        var url=$.trim($("#url").val());//获取会话中的隐藏属性URL  
        window.location.href=url+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));//+"&classacademy="+encodeURI(encodeURI($("#classtitel").text()));       
    }
	function onback()
	{
		window.location.href="../academy.do?method=academyFindExecute";
	}
	function onfind()
	{
		window.location.href="../classroom.do?method=classroomFindExecute&academyid="+$("#academyid").val()+"&findinfo="+encodeURI(encodeURI($("#findinfo").val()));
	}
</script>