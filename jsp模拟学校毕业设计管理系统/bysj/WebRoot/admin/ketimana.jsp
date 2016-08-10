<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String info="";
if(request.getParameter("info")!=null) info=URLDecoder.decode(request.getParameter("info").toString(),"UTF-8");
String str="select * from keti where ktname like '%"+info+"%' or stuid like '%"+info+"%'  or kttype like '%"+info+"%'";
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
        <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/login.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label class="sr-only" for="name">用户名：</label>
    <input type="text" name="usernameorid" id="usernameorid"class="abc input-default form-control" placeholder="课题信息" value="">&nbsp;&nbsp;  
    <button type="button" class="btn btn-primary" id="findinfo">查询</button>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>课题名称</th>
        <th>课题类型</th>
        <th>课题来源</th>
        <th>课题描述</th>
        <th>申请学生学号</th>
        <th>审批</th>
    </tr>
    </thead>
    <%
    while(rs.next())
    {%>
	    <tr>
		    <td><%=rs.getString("ktname")%></td>
		    <td><%=rs.getString("kttype")%></td>
		    <td><%=rs.getString("ktcome")%></td>
		    <td><%=rs.getString("ktdescr")%></td>
		    <td><%=rs.getString("stuid")%></td>
		    <td>
		    <%if(rs.getString("status").equals("0")) {%>
		    <a href="#" onclick="setStatus(this,1)">通过</a>&nbsp;&nbsp;<a href="#" onclick="setStatus(this,2)">不通过</a>
		    <%} else if(rs.getString("status").equals("1")) {%>
		    已通过
		    <%} else{ %>
		    未通过
		    <%} %>
		    </td>
	    </tr>
    <%
    }
    rs.close();
    %>
</table>
</body>
</html>
<script>
	// 添加按钮的触发
   function setStatus(obj,status)
	{
	   //alert(obj.parentNode.parentNode.cells[4].innerHTML);
	   login.setKetiStatus(obj.parentNode.parentNode.cells[4].innerHTML,status,callback);
	}
	function callback()
	{
		window.location.href="ketimana.jsp?info="+encodeURI(encodeURI($("#usernameorid").val()));
	}
 // 查询按钮的触发
    $(function () {
		$('#findinfo').click(function(){
			//encode两次
			window.location.href="ketimana.jsp?info="+encodeURI(encodeURI($("#usernameorid").val()));
		 });
    });
</script>