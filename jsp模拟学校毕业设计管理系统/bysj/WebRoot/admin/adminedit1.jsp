<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="admin" scope="page" class="com.info.adminBean">
<jsp:setProperty name="admin" property="*"/>
</jsp:useBean>
<jsp:useBean id="adminservice" scope="page" class="com.service.adminService"/>
<%
	adminservice.setAdmininfo(admin);
	adminservice.modify();
    out.println("<script language='javascript'>"+
               "window.location.href='adminmana.jsp';</script>");
%>