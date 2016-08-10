<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="teachselect" scope="page" class="com.info.teachselectBean">
<jsp:setProperty name="teachselect" property="*"/>
</jsp:useBean>
<jsp:useBean id="teachselectservice" scope="page" class="com.service.teachselectService"/>
<%
	teachselectservice.setStudentinfo(teachselect);
	teachselectservice.update();
    out.println("<script language='javascript'>"+
               "window.location.href='teachselect.jsp?stuid="+teachselect.getStuid()+"';</script>");
%>