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
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<form id="addform" action="#" method="post" class="definewidth m20" >
<div class="form-inline definewidth">
	<label for="name">材料类型</label>&nbsp;&nbsp;
	<select id="doctype" class="form form-control" onchange="ontypechange()"> 
	<option value="0">实习周记</option>
	<option value="1">实习报告</option>
	<option value="2">三方协议</option>
	<option value="3">离校手续</option>
	</select>&nbsp;&nbsp;
	<input class="hide" id="hidendoctype" value="${sessionScope.doctype}"/>
	<input class="hide" id="hidenstudentid" value="${sessionScope.studentid}"/>
	<input id="docadd" type="button" class="btn btn-primary" onclick="onuploaddoc()" value="上传材料"/>
</div>
<table class="table table-bordered table-hover definewidth m10" id="doctable">
	<thead>
       <tr>
        <th>材料类型</th>
        <th>材料名称</th>
        <th>材料说明</th>
        <th>指导老师</th>
        <th>审核状态</th>
        <th>查看下载</th>
        <th>操作</th>
       </tr>
     </thead>
     <c:forEach items="${sessionScope.doclist}" var="doc">
       <tr>
       	<td class="hide"><c:out value="${doc[6]}"/></td>
		<td>
		<c:choose>
		<c:when test="${doc[0]=='0' }">实习周记</c:when>
		<c:when test="${doc[0]=='1' }">实习报告</c:when>
		<c:when test="${doc[0]=='2' }">三方协议</c:when>
		<c:when test="${doc[0]=='3' }">离校手续</c:when>
		</c:choose>
		</td>
		<td><c:out value="${doc[1]}"/></td>
		<td><c:out value="${doc[2]}"/></td>
		<td><c:out value="${doc[3].name}"/></td>
		<td>
		<c:choose>
		<c:when test="${doc[4]=='0' }">未审核</c:when>
		<c:when test="${doc[4]=='1' }">审核通过</c:when>
		<c:when test="${doc[4]=='2' }">审核未通过</c:when>
		</c:choose>
		</td>
		<td>
		<c:if test="${fn:contains(doc[5], '.pdf')}">
			<a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<c:out value="${doc[5]}"/>">预览&nbsp;&nbsp;</a>
		</c:if>
			<a href="javascript:void(0);" onClick="ondownload(this)">下载</a>
		</td>
		<td>
		<c:if test="${doc[4]!='1'}">
			<a href="javascript:void(0);" onclick="onmodify(this)">修改</a>
		</c:if>
		</td>
		<td class="hide"><c:out value="${doc[5]}"/></td>
	</tr>
	</c:forEach>
</table>
</form>


<!-- 对话框 -->
<div class="modal fade" id="addModel">
  <div class="modal-dialog">
    <form class="form" action="../servlet/docfileUploadServlet" enctype="multipart/form-data" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="addtitel">上传材料</h4>
	      </div>
	      <div class="modal-body">
	      <input type="hidden" value="${sessionScope.studentid}" name="studentid"/>
	      <div class="form m10">
	      	材料类型:
	        <select id="adddoctype" name="doctype" class="form form-control"> 
			<option value="0">实习周记</option>
			<option value="1">实习报告</option>
			<option value="2">三方协议</option>
			<option value="3">离校手续</option>
			</select>
	      </div>
	      <div class="form m10">
	      	材料名称:
	        <input type="text" id="addname" name="name" class="form-control"/>
	      </div>
	      <div class="form m10">
	      	材料说明:
	        <textarea rows="3" cols="" id="adddescr" name="descr" class="form-control"></textarea>
	      </div>
	      <div class="form m10">
	      	材料路径:
	        <input type="file" class="form-control file" value="" id="addfiletask" name="addfiletask" accept="application/pdf;application/msword;application/vnd.ms-works" />
	      </div>
	      </div>
	      <div class="modal-footer">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-primary" onclick="return addcheck()">保存</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 对话框 -->
<div class="modal fade" id="editModel">
  <div class="modal-dialog">
    <form class="form" action="../servlet/docfileUploadServlet" enctype="multipart/form-data" method="post">
    	<div class="modal-content message_align">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        <h4 class="modal-title" id="edittitel">修改材料</h4>
	      </div>
	      <div class="modal-body">
	      <input type="hidden" value="" id="editdocid" name="docid"/>
	      <input type="hidden" value="${sessionScope.studentid}" name="studentid"/>
	      <div class="form m20">
	      	材料类型:
	        <select id="editdoctype" name="doctype" class="form form-control"> 
			<option value="0">实习周记</option>
			<option value="1">实习报告</option>
			<option value="2">三方协议</option>
			<option value="3">离校手续</option>
			</select>
	      </div>
	      <div class="form m20">
	      	材料名称:
	        <input type="text" id="editname" name="name" class="form-control"/>
	      </div>
	      <div class="form m20">
	      	材料说明:
	        <textarea rows="3" cols="" id="editdescr" name="descr" class="form-control"></textarea>
	      </div>
	      <div class="form m20">
	      	材料路径:
	        <input type="file" class="form-control file" value="" id="editfiletask" name="addfiletask" accept="application/pdf;application/msword;application/vnd.ms-works" />
	      </div>
	      </div>
	      <div class="modal-footer">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-primary" onclick="return editcheck()">保存</button>
	      </div>
	    </div><!-- /.modal-content -->
    </form>
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
<script type="text/javascript">
function ondownload(obj)
{
	 var file=obj.parentNode.parentNode.cells[8].innerHTML.split(".");
	 var filename=obj.parentNode.parentNode.cells[1].innerHTML+"_"+obj.parentNode.parentNode.cells[2].innerHTML+"."+file[1];
	 window.location.href="../servlet/fileDownloadServlet?filepath="+obj.parentNode.parentNode.cells[8].innerHTML+
			 "&filename="+filename.replace(/\+/g,"");
}


$(function () {       
	$("#doctype").val($("#hidendoctype").val());
});
function ontypechange()
{
	window.location.href="../studentdocument.do?method=studentdocumentFindExecute&studentid="+$("#hidenstudentid").val()+"&doctype="+$("#doctype").val();	
}

function onuploaddoc()
{
	if($("#doctype").val()==null||$("#doctype").val()=="")
	{
		alert("请选择材料类型");return;
	}
	if($("#doctype").val()!="0"&&$("#doctable tr").length>1)
	{
		alert("本类型材料只能上传一份材料");return;
	}
	
	//上传文件
	$("#adddoctype").val($("#doctype").val());
	$("#addModel").modal();
}

function addcheck()
{
	if($("#adddoctype").val()==null||$("#adddoctype").val()=="")
	{
		alert('请选择材料类型');return false;
	}
	if($("#addname").val()=="")
	{
		alert('请输入材料名称');return false;
	}
	if($("#adddescr").val()=="")
	{
		alert('请输入材料描述');return false;
	}
	if($('#addfiletask')[0].files.length<1)
	{
		alert('请添加材料路径');return false;
	}
	return true;	
}

function onmodify(obj)
{
	if($("#doctype").val()==null||$("#doctype").val()=="")
	{
		alert("请选择材料类型");return;
	}
	//上传文件
	$("#editdoctype").val($("#doctype").val());
	$("#editdocid").val(obj.parentNode.parentNode.cells[0].innerHTML);
	$("#editname").val(obj.parentNode.parentNode.cells[2].innerHTML);
	$("#editdescr").val(obj.parentNode.parentNode.cells[3].innerHTML);
	$("#editModel").modal();
}

function editcheck()
{
	if($("#editname").val()=="")
	{
		alert('请输入材料名称');return false;
	}
	if($("#editdescr").val()=="")
	{
		alert('请输入材料描述');return false;
	}
	return true;
}

</script>
</html>