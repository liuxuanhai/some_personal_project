<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String str="select ktname,status from keti where stuid='"+request.getParameter("stuid").toString()+"'";
	ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
	boolean flag=rs.next();  // 是否已经申请了课题
	boolean shenhetongguo=false;
	String ktname="";
	if(flag&&rs.getString("status").equals("1"))
	{
		ktname=rs.getString("ktname");
		shenhetongguo=true;
	}
	// 教师表
	if(flag)ktname=rs.getString("ktname");
	str="select * from teachselect where stuid='"+request.getParameter("stuid").toString()+"'"; // 查询是否已经选择导师了
	rs=rst.getResult(str);//执行SQL语句获得结果集对象
	String t1="",t2="",t3="",selectstatus="未提交";
	if(rs.next()){
		t1=rs.getString("teachid1");
		t2=rs.getString("teachid2");
		t3=rs.getString("teachid3");
		selectstatus=rs.getString("status");
	}
	
	str="select * from teacher";
	rs=rst.getResult(str);//执行SQL语句获得结果集对象
 %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<input type="hidden" value="<%=t1 %>" id="t1" name="t1" />
<input type="hidden" value="<%=t2 %>" id="t2" name="t2" />
<input type="hidden" value="<%=t3 %>" id="t3" name="t3" />
<%if(shenhetongguo) {%>
<div class="text-center m20">课题名称 :<b><%=ktname %></b>
</div>
<div class="text-center m20">志愿状态 :<b><%=selectstatus %></b></div>
<%if(selectstatus.indexOf("导师已互选")<0) {%>

<form action="teachselect1.jsp" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<input type="hidden" value="<%=request.getParameter("stuid").toString() %>" id="stuid" name="stuid" />
<table class="table table-bordered table-hover definewidth m20">
    <tr>
        <td width="10%" class="tableleft">第一志愿
        </td>
        <td>
<select class="form-control" id="teachid1" name="teachid1">
<%rs.first();
while(rs.next()) {%>
<option value="<%=rs.getString("teachid") %>"><%=rs.getString("name") %></option>
<%} %>
</select>
</td>
    </tr>
    <tr>
        <td class="tableleft">第二志愿</td>
        <td>
        <select class="form-control" id="teachid2" name="teachid2">
<%rs.first();
while(rs.next()) {%>
<option value="<%=rs.getString("teachid") %>"><%=rs.getString("name") %></option>
<%} %>
</select>
        </td>
    </tr>
 		<tr>
        <td class="tableleft">第三志愿</td>
        <td>
        <select class="form-control" id="teachid3" name="teachid3">
<%rs.first();
while(rs.next()) {%>
<option value="<%=rs.getString("teachid") %>"><%=rs.getString("name") %></option>
<%} %>
</select>
        </td>
    </tr>
    <tr>
    <td></td><td><input type="submit" class="btn btn-success" value="保存"/></td>
    </tr>
</table>
</form>
<%}
} else if(flag){%>
<div class="text-center m20">课题名称 :<b><%=ktname %>,课题尚未审批通过，不允许选择导师。</b>
<%} else{ %>
<div class="text-center m20">你尚未申报课题，不允许选择导师。</b>
<%}  %>
</body>
</html>
<script>   
window.onload=function(){ //加载时执行一个dwr调用ajax方法
		$("#teachid1").val($("#t1").val());
		$("#teachid2").val($("#t2").val());
		$("#teachid3").val($("#t3").val());
	}
	function validate_info(form)  
     {  
     if($("#teachid1").val()==$("#teachid2").val()||$("#teachid1").val()==$("#teachid3").val()||$("#teachid3").val()==$("#teachid2").val())
     {
     	alert('导师不能相同');return false;
     }
         return true;  
     }
</script>