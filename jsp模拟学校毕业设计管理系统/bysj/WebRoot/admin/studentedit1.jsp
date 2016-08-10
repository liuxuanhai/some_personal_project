<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="student" scope="page" class="com.info.studentBean">
<jsp:setProperty name="student" property="*"/>
</jsp:useBean>
<jsp:useBean id="studentservice" scope="page" class="com.service.studentService"/>
<%
	studentservice.setStudentinfo(student);
	studentservice.modify();
    out.println("<script language='javascript'>"+
               "window.location.href='studentmana.jsp';</script>");
%>