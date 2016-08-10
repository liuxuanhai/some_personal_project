<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String teaid=request.getParameter("teaid").toString();
String stuid=request.getParameter("stuid").toString();
String yesorno=request.getParameter("yesorno").toString();
String str="select flag from teachselect where stuid='"+stuid+"'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
rs.next();
String flag=rs.getString("flag");
if(yesorno.equals("yes")||flag.equals("2"))
{
	str="select name from teacher where teachid='"+teaid+"'";
	 rs=rst.getResult(str);//执行SQL语句获得结果集对象
	rs.next();
	str="update teachselect set flag='3',status='导师已互选，导师为"+rs.getString("name")+"' where stuid='"+stuid+"'";
	rst.doExecute(str); //已经互选了
	str="update keti set teachid='"+teaid+"' where stuid='"+stuid+"'";
	rst.doExecute(str); //已经互选了
}else
{
	if(flag.equals("0"))
	{
		
		str="update teachselect set flag='1',status='志愿一导师已拒绝' where stuid='"+stuid+"'";	
		rst.doExecute(str); 
	}else if(flag.equals("1"))
	{
		str="update teachselect set flag='2',status='志愿二导师已拒绝' where stuid='"+stuid+"'";	
		rst.doExecute(str); 
	}
}
out.println("<script language='javascript'>"+
        "window.location.href='studentmana.jsp?teaid="+teaid+"';</script>");
%>