<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String str="select taskpath from keti where teachid='"+request.getParameter("teaid").toString()+"' and stuid='"+request.getParameter("stuid").toString()+"'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
//System.out.println(str);
rs.next();
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
<div class="from definewidth m20">
<input class="btn btn-primary" type="button" id="backid" onclick="backlist()" value="返回列表"/>
</div>
<div class="form-inline definewidth m20" action="#" method="post">    
任务书发送状态：
     <%if(rs.getString("taskpath")!=null&&!rs.getString("taskpath").equals("")) {%>
		    已发送&nbsp;&nbsp;<a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("taskpath") %>">查看</a>&nbsp;&nbsp;<a href="../servlet/taskDownloadServlet?taskpath=<%=rs.getString("taskpath") %>&stuid=<%=request.getParameter("stuid").toString() %>">下载</a>
		    <%} else{%>
		    未发送
		    <%} %>
</div>
<form action="../servlet/taskServlet" method="post" enctype="multipart/form-data" id="taskform">
<input type="hidden" value="<%=request.getParameter("teaid").toString() %>" id="teaid" name="teaid"/>
<input type="hidden" value="<%=request.getParameter("stuid").toString() %>" id="stuid" name="stuid"/>
<table class="table table-bordered table-hover definewidth m10">
   <tr>
    <td width="20%">任务书文件(仅支持pdf)</td>
    <td>
    <input type="file" id="taskfile" name="taskfile" accept="application/pdf"/>
    <a href="#" onclick="sendfile()">发送</a>
    </td>
   </tr>
</table>
</form>
</body>
</html>
<script>
function sendfile()
{
	var form = document.forms["taskform"]; 
	if(form["taskfile"].files.length<1)
	{
		alert('请选择需要发送的任务书');	
		return;
	}
	form.submit();

}
function backlist()
{
	window.location.href="studentmana.jsp?teaid="+$("#teaid").val();
}
</script>