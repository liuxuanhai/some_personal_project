<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="keti" scope="page" class="com.info.ketiBean">
<jsp:setProperty name="keti" property="*"/>
</jsp:useBean>
<jsp:useBean id="ketiservice" scope="page" class="com.service.ketiService"/>
<%
	ketiservice.setStudentinfo(keti);
	ketiservice.update();
    out.println("<script language='javascript'>"+
               "window.location.href='ketishenbao.jsp?stuid="+keti.getStuid()+"';</script>");
%>