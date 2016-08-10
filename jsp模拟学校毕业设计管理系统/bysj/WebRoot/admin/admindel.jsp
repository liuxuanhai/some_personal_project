<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="adminservice" scope="page" class="com.service.adminService"/>
<%
	adminservice.delete(request.getParameter("adminid").toString());
    out.println("<script language='javascript'>"+
               "window.location.href='adminmana.jsp';</script>");
%>