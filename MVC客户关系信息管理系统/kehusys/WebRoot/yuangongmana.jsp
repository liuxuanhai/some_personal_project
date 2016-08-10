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
<form class="form-inline definewidth m20" action="<%=path %>/servlet/YuangongServlet?method=getYuangong" method="post">    
    <input class="hide" id="userid" name="userid" value="${requestScope.userid}"/>
    <label class="sr-only" for="name">用户名：</label>
    <input type="text" name="findinfo" id="findinfo" name="findinfo" class="form-control" placeholder="员工信息" value="${requestScope.findinfo}">&nbsp;&nbsp;  
    <button type="submit" class="btn btn-primary" id="findbtn">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addbtn" onclick="onadd()">新增员工</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>员工id</th>
        <th>员工类型</th>
        <th>姓名</th>
        <th>联系号码</th>
        <th>联系地址</th>
        <th>身份证</th>
        <th>登录用户名</th>
        <th>操作</th>
    </tr>
    </thead>
        <c:forEach items="${requestScope.yuangonglist}" var="yuangong">
        <tr>
        	<td><c:out value="${yuangong.id}"/></td>
        	<td>
        	<c:choose>
        		<c:when test="${yuangong.type=='0'}">店长</c:when>
        		<c:when test="${yuangong.type=='1'}">业务员</c:when>
        	</c:choose>
        	</td>
			<td><c:out value="${yuangong.name}"/></td>
			<td><c:out value="${yuangong.phone}"/></td>
			<td><c:out value="${yuangong.addr}"/></td>
			<td><c:out value="${yuangong.idcard}"/></td>
			<td><c:out value="${yuangong.username}"/></td>
			<td><a href="#" onclick="onedit(this)">修改</a>&nbsp;&nbsp;
			<c:if test="${requestScope.userid!=yuangong.id}">
				<a  href="#" onClick="delcfm('<%=path %>/servlet/YuangongServlet?method=delYuangong&userid=${requestScope.userid}&yuangongid=<c:out value="${yuangong.id}"/>')">删除</a>
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
        <h4 class="modal-title">添加员工</h4>
      </div>
      <form action="<%=path %>/servlet/YuangongServlet?method=addYuangong" method="post">
	      	<div class="modal-body">
	      	<input class="hide" name="userid" value="${requestScope.userid}"/>
	      	<div class="form m10">
	        	员工类型
				<select id="addtype" name="type" class="form-control">
				<option value="1">业务员</option>
				<option value="0">店长</option>
				</select>
	        </div>
	        <div class="form m10">
	        	员工名称<input type="text" id="addname" name="name" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	联系电话<input type="text" id="addphone" name="phone" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	联系地址<input type="text" id="addaddr" name="addr" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	身份证号<input type="text" id="addidcard" name="idcard" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	登录用户<input type="text" id="addusername" name="username" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	登录密码<input type="password" id="addpwd" name="pwd" class="form-control"/>
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
        <h4 class="modal-title">修改员工</h4>
      </div>
      <form action="<%=path %>/servlet/YuangongServlet?method=editYuangong" method="post">
	      <div class="modal-body">
	      <input class="hide" name="userid" value="${requestScope.userid}"/>
	      <input type="hidden" id="editid" name="yuangongid"/>
	      <div class="form m10">
	        	员工类型
				<select id="edittype" name="type" class="form-control">
				<option value="1">业务员</option>
				<option value="0">店长</option>
				</select>
	        </div>
	        <div class="form m10">
	        	员工名称<input type="text" id="editname" name="name" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	联系电话<input type="text" id="editphone" name="phone" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	联系地址<input type="text" id="editaddr" name="addr" class="form-control"/>
	        </div>
	        <div class="form m10">
	        	身份证号<input type="text" id="editidcard" name="idcard" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
	        </div>
	        <div class="form m10">
	        	登录用户<input type="text" id="editusername" name="username" class="form-control"/>
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
	$("#edittype").val('1');
	if(obj.parentNode.parentNode.cells[1].innerHTML.trim()=='店长') $("#edittype").val('0');
	$("#editname").val(obj.parentNode.parentNode.cells[2].innerHTML);	
	$("#editphone").val(obj.parentNode.parentNode.cells[3].innerHTML);	
	$("#editaddr").val(obj.parentNode.parentNode.cells[4].innerHTML);	
	$("#editidcard").val(obj.parentNode.parentNode.cells[5].innerHTML);	
	$("#editusername").val(obj.parentNode.parentNode.cells[6].innerHTML);		
	$("#editModal").modal(); //修改界面
}
// 保存
function oneditsave()
{
	if($("#editname").val()=="")
	{
	alert("请输入员工姓名");return false;
	}
	
	if($("#editphone").val()=="")
	{
	alert("请输入联系电话");return false;
	}
	if($("#editusername").val()=="")
	{
	alert("请输入登录用户");return false;
	}
	return true;
}

function onadd()
{
	$("#addModal").modal(); //添加界面
}
function onaddsave()
{
	if($("#addname").val()=="")
	{
	alert("请输入员工姓名");return false;
	}
	
	if($("#addphone").val()=="")
	{
	alert("请输入联系电话");return false;
	}
	if($("#addusername").val()=="")
	{
	alert("请输入登录用户");return false;
	}
	if($("#addpwd").val()=="")
	{
	alert("请输入登录密码");return false;
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