<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String info="";
if(request.getParameter("info")!=null) info=URLDecoder.decode(request.getParameter("info").toString(),"UTF-8");
String str="select * from student where username like '%"+info+"%' or name like '%"+info+"%'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
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
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="学号/姓名" value="">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>&nbsp;&nbsp; <button type="button" class="btn btn-success" id="addnew">新增学生</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>性别</th>
        <th>班级</th>
        <th>用户名</th>
        <th>密码</th>
        <th>修改</th>
        <th>删除</th>
    </tr>
    </thead>
    <%
    while(rs.next())
    {%>
	    <tr>
		    <td><%=rs.getString("stuid")%></td>
		    <td><%=rs.getString("name")%></td>
		    <td><%=rs.getString("gender")%></td>
		    <td><%=rs.getString("cls")%></td>
		    <td><%=rs.getString("username")%></td>
		    <td><%=rs.getString("passwd")%></td>
		    <td><a href="studentedit.jsp?studentid=<%=rs.getString("stuid")%>">修改</a></td>
		    <td><a  href="#" onClick="delcfm('studentdel.jsp?studentid=<%=rs.getString("stuid")%>')">删除</a></td>
	    </tr>
    <%
    }
    rs.close();
    %>
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
	// 添加按钮的触发
    $(function () {
		$('#addnew').click(function(){
				window.location.href="studentadd.jsp";
		 });
    });
    
 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			//encode两次
			window.location.href="studentmana.jsp?info="+encodeURI(encodeURI($("#usernameorid").val()));
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