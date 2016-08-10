<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="teacherservice" scope="page" class="com.service.teacherService"/>
<%
	teacherservice.delete(request.getParameter("teacherid").toString());
    out.println("<script language='javascript'>"+
               "window.location.href='teachermana.jsp';</script>");
%>