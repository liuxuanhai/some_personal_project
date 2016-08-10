<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String str="select ktname,ktpath from keti where stuid='"+request.getParameter("stuid").toString()+"'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
//System.out.println(str);
boolean flag=rs.next();
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
<%if(flag) { %>
<div class="form-inline definewidth m20">    
<h3>
课题：<%=rs.getString("ktname") %>
</h3>
</div>

<div class="form-inline definewidth m20">    
<h4>开题报告状态：
     <%if(rs.getString("ktpath")!=null&&!rs.getString("ktpath").equals("")) {%>
		    已提交&nbsp;&nbsp;<a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("ktpath") %>">查看</a>&nbsp;&nbsp;<a href="../servlet/fileDownloadServlet?filepath=<%=rs.getString("ktpath") %>&stuid=<%=request.getParameter("stuid").toString() %>">下载</a>
		    <%} else{%>
		    未提交，请及时上传开题报告。
		    <%} %>
		    </h4>
</div>

<form action="../servlet/fileUploadServlet" method="post" enctype="multipart/form-data" id="fileform" class="m20">
<input type="hidden" value="<%=request.getParameter("stuid").toString() %>" id="stuid" name="stuid"/>
<input type="hidden" value="ktpath" id="pathtype" name="pathtype"/>
<table class="table table-bordered table-hover definewidth m10">
   <tr>
    <td width="20%">开题报告文件(仅支持pdf)</td>
    <td>
    <input type="file" id="file" name="file" accept="application/pdf"/>
    <a href="#" onclick="sendfile()">提交开题</a>
    </td>
   </tr>
</table>
</form>
<%} else{%>
<h3>
你还没有确认课题，请申请课题或进行导师互选！
</h3>
<%} %>
</body>
</html>
<script>
function sendfile()
{
	var form = document.forms["fileform"]; 
	if(form["file"].files.length<1)
	{
		alert('请选择需要发送的开题报告，仅支持pdf文件');	
		return;
	}
	form.submit();
}
</script>