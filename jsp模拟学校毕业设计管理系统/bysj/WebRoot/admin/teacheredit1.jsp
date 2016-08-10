<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="teacher" scope="page" class="com.info.teacherBean">
<jsp:setProperty name="teacher" property="*"/>
</jsp:useBean>
<jsp:useBean id="teacherservice" scope="page" class="com.service.teacherService"/>
<%
	teacherservice.setTeacherinfo(teacher);
	teacherservice.modify();
    out.println("<script language='javascript'>"+
               "window.location.href='teachermana.jsp';</script>");
%>