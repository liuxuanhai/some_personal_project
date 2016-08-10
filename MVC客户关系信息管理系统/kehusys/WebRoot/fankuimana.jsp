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
    <link rel="stylesheet" type="text/css" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/css/style.css" />
    <script type="text/javascript" src="<%=path %>/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form class="form-inline definewidth m20" action="<%=path %>/servlet/FankuiServlet?method=getFankui" method="post">    
    <input class="hide" id="userid" name="userid" value="${requestScope.userid}"/>
    <label class="sr-only" for="name">用户名：</label>
    <input type="text" name="findinfo" id="findinfo" name="findinfo" class="form-control" placeholder="反馈信息" value="${requestScope.findinfo}">&nbsp;&nbsp;  
    <button type="submit" class="btn btn-primary" id="findbtn">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn" onclick="onadd()">新增反馈</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>反馈id</th>
        <th>客户姓名</th>
        <th>反馈内容</th>
        <th>备注</th>
        <th>反馈时间</th>
        <th>接待员工</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${requestScope.fankuilist}" var="fankui">
        <tr>
        	<td><c:out value="${fankui.id}"/></td>
			<td><c:out value="${fankui.personname}"/></td>
			<td><c:out value="${fankui.content}"/></td>
			<td><c:out value="${fankui.reamrk}"/></td>
			<td><c:out value="${fankui.addtime}"/></td>
			<td><c:out value="${fankui.ygname}"/></td>
			<td>
			<c:if test="${requestScope.userid==fankui.yuangongid }">
				<a href="#" onclick="onedit(this)">修改</a>&nbsp;&nbsp;
				<a  href="#" onClick="delcfm('<%=path %>/servlet/FankuiServlet?method=delFankui&userid=${requestScope.userid}&fankuiid=<c:out value="${fankui.id}"/>')">删除</a>
			</c:if>
			</td>
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

<!-- 信息添加-->
<div class="modal fade" id="addModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">添加客户</h4>
      </div>
      <form action="<%=path %>/servlet/FankuiServlet?method=addFankui" method="post">
	      	<div class="modal-body">
	      	<input class="hide" name="userid" value="${requestScope.userid}"/>
	        <div class="form m10">
	        	客户姓名<input type="text" id="addpersonname" name="personname" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	反馈内容
	        	<textarea rows="5" cols="" id="addcontent" name="content" class="form-control">
	        	</textarea>
	        </div>
	        <div class="form m10">
	        	备注
	        	<textarea rows="2" cols="" id="addremark" name="remark" class="form-control">
	        	</textarea>
	        </div>
	        </div>
	        <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-success" onclick="return onaddsave()" >确定</button>
	        </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 信息修改-->
<div class="modal fade" id="editModal">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">修改用户</h4>
      </div>
      <form action="<%=path %>/servlet/FankuiServlet?method=editFankui" method="post">
	      <div class="modal-body">
	      <input class="hide" name="userid" value="${requestScope.userid}"/>
	      <input type="hidden" id="editid" name="fankuiid"/>
	        <div class="form m10">
	        	客户姓名<input type="text" id="editpersonname" name="personname" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	反馈内容
	        	<textarea rows="5" cols="" id="editcontent" name="content" class="form-control">
	        	</textarea>
	        </div>
	        <div class="form m10">
	        	备注
	        	<textarea rows="2" cols="" id="editremark" name="remark" class="form-control">
	        	</textarea>
	        </div>
	      </div>
	      <div class="modal-footer text-center">
	      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	      	 <button type="submit" class="btn btn-success" onclick="return oneditsave()" >确定</button>
	      </div>
      </form>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
<script>
// 编辑
function onedit(obj)
{
	$("#editid").val(obj.parentNode.parentNode.cells[0].innerHTML);	
	$("#editpersonname").val(obj.parentNode.parentNode.cells[1].innerHTML);	
	$("#editcontent").val(obj.parentNode.parentNode.cells[2].innerHTML);	
	$("#editremark").val(obj.parentNode.parentNode.cells[3].innerHTML);		
	$("#editModal").modal(); //修改界面
}
// 保存
function oneditsave()
{
	if($("#editpersonname").val()=="")
	{
	alert("请输入客户姓名");return false;
	}
	if($("#editcontent").val()=="")
	{
	alert("请输入反馈内容");return false;
	}
	return true;
}

function onadd()
{
	$("#addModal").modal(); //添加界面
}
function onaddsave()
{
	if($("#addpersonname").val()=="")
	{
	alert("请输入客户姓名");return false;
	}
	if($("#addcontent").val()=="")
	{
	alert("请输入反馈内容");return false;
	}
	return true;
}
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