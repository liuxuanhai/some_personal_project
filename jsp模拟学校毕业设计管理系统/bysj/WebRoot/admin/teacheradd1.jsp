<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="teacher" scope="page" class="com.info.teacherBean">
<jsp:setProperty name="teacher" property="*"/>
</jsp:useBean>
<jsp:useBean id="teacherservice" scope="page" class="com.service.teacherService"/>
<%
	teacherservice.setTeacherinfo(teacher);
	if(teacherservice.isexist())  // 如果学号存在
		out.println("<script language='javascript'>alert('此工生已经存在，添加失败');"+
               "window.location.href='teachermana.jsp';</script>");
    else
    {
    	teacherservice.add();
	
    out.println("<script language='javascript'>"+
               "window.location.href='teachermana.jsp';</script>");
    }
%>