<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="studentservice" scope="page" class="com.service.studentService"/>
<%
	studentservice.delete(request.getParameter("studentid").toString());
    out.println("<script language='javascript'>"+
               "window.location.href='studentmana.jsp';</script>");
%>