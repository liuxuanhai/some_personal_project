<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String str="select ktname,taskpath from keti where stuid='"+request.getParameter("stuid").toString()+"'";
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
<h4>任务书状态：
     <%if(rs.getString("taskpath")!=null&&!rs.getString("taskpath").equals("")) {%>
		    已发布&nbsp;&nbsp;<a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("taskpath") %>">查看</a>&nbsp;&nbsp;
		    <a href="../servlet/fileDownloadServlet?taskpath=<%=rs.getString("taskpath") %>&stuid=<%=request.getParameter("stuid").toString() %>">下载</a>
		    <%} else{%>
		    未发布，请联系指导老师发布任务书。
		    <%} %>
		    </h4>
</div>
<%} else{%>
<h3>
你还没有确认课题，请申请课题或进行导师互选！
</h3>
<%} %>
</body>
</html>