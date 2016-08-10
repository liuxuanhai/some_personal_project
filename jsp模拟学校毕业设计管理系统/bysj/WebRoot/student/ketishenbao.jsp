<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String str="select * from keti where stuid='"+request.getParameter("stuid").toString()+"'";
	ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
	boolean flag=rs.next();  // 是否已经申请了课题
	boolean shenhetongguo=false;
	String status="未审核";
	if(flag)
	{
		if(rs.getString("status").equals("1")) {
			status="审核通过";
			shenhetongguo=true;
		}
		if(rs.getString("status").equals("2")) status="审核未通过";
	}
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
<%if(flag) {%>
<div class="text-center m20"><h4>你已经提交了课题申请，状态为<b><%=status %></b>
</h4></div>
<%} %>
<form action="ketishenbao1.jsp" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<input type="hidden" value="<%=request.getParameter("stuid").toString() %>" id="stuid" name="stuid" />
<table class="table table-bordered table-hover definewidth m20">
    <%if(flag) {%>
    
    <tr>
        <td width="10%" class="tableleft">课题名称
        </td>
        <td><input type="text" id="ktname" name="ktname" class="form-control" value="<%=rs.getString("ktname") %>"/></td>
    </tr>
    <tr>
        <td class="tableleft">课题类型</td>
        <td><input type="text" id="kttype" name="kttype" class="form-control" value="<%=rs.getString("kttype") %>"/></td>
    </tr>
 		<tr>
        <td class="tableleft">课题来源</td>
        <td><input type="text" id="ktcome" name="ktcome" class="form-control" value="<%=rs.getString("ktcome") %>"/></td>
    </tr>
    <tr>
        <td class="tableleft">课题描述</td>
        <td>
        <textarea rows="5" cols="" class="form-control" id="ktdescr" name="ktdescr" ><%=rs.getString("ktdescr") %></textarea>  
    </tr>
    <%} else{ %>
    <tr>
        <td width="10%" class="tableleft">课题名称
        </td>
        <td><input type="text" id="ktname" name="ktname" class="form-control" value=""/></td>
    </tr>
    <tr>
        <td class="tableleft">课题类型</td>
        <td><input type="text" id="kttype" name="kttype" class="form-control" value=""/></td>
    </tr>
 		<tr>
        <td class="tableleft">课题来源</td>
        <td><input type="text" id="ktcome" name="ktcome" class="form-control" value=""/></td>
    </tr>
    <tr>
        <td class="tableleft">课题描述</td>
        <td>
        <textarea rows="5" cols="" class="form-control" id="ktdescr" name="ktdescr" ></textarea>  
    </tr>
    <%} %>
    <tr>
        <td class="tableleft"></td>
        <td>
        <%if(!shenhetongguo) {%>
            <button type="submit" class="btn btn-primary" >提交课题</button>
            <%} %>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>   
	function validate_info(form)  
     {  
     	 //alert(form.administratorname.value);
         if(form.ktname.value=="")  
         {  
             alert("请输入课题名称");  
             return false;  
         }  
         else if(form.kttype.value=="")  
         {  
             alert("请输入课题类型");  
             return false;  
         } 
         else if(form.ktcome.value=="")  
         {  
             alert("请输入课题来源");  
             return false;  
         }
         else if(form.ktdescr.value=="")  
         {  
             alert("请输入课题描述");  
             return false;  
         } 
         return true;  
     }
</script>