<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<%
 String str="select * from student where stuid='"+request.getParameter("studentid").toString()+"'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
rs.next();
 %>
<form action="studentedit1.jsp" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">学号</td>
        <td><input type="text" id="stuid" name="stuid" readonly="readonly" value="<%=rs.getString("stuid") %>" class="popover-stuid" data-toggle="popover" data-placement="right" data-content="学号不能为空" onkeypress="hidepopover()"/></td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td><input type="text" id="name" name="name" value="<%=rs.getString("name")%>" class="popover-name" data-toggle="popover" data-placement="right" data-content="姓名不能为空" onkeypress="hidepopover()"/></td>
    </tr>
	<tr>
        <td class="tableleft">性别</td>
        <td>
        <% if(rs.getString("gender").equals("男")) {%>
        <input type="radio" id="sex" name="sex" value="男" checked/> 男&nbsp;&nbsp;
        <input type="radio" id="sex" name="sex" value="女" /> 女
        <%} else {%>
        <input type="radio" id="sex" name="sex" value="男" /> 男&nbsp;&nbsp;
        <input type="radio" id="sex" name="sex" value="女" checked/> 女
        <%} %>
        </td>
    </tr>
    <tr>
        <td class="tableleft">班级</td>
        <td><input type="text" id="cls" name="cls" value="<%=rs.getString("cls") %>" class="popover-cls" data-toggle="popover" data-placement="right" data-content="班级不能为空" onkeypress="hidepopover()"/></td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary popover-usersave" type="button" data-toggle="popover" data-placement="bottom" data-content="保存完成">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
    $(function () {       
		$('#backid').click(function(){
				window.location.href="studentmana.jsp";
		 });

    });
     
	function validate_info(form)  
     {  
         if(form.stuid.value=="")  
         {  
             //alert("请输入正确的名字");  
             $('.popover-stuid').popover('show');
             return false;  
         }  
         else if(form.name.value=="")  
         {  
             //alert("请输入合法ID");  
             $('.popover-name').popover('show');
             return false;  
         }
         else if(form.cls.value=="")  
         {  
             //alert("请输入合法ID");  
             $('.popover-cls').popover('show');
             return false;  
         }  
         else if(form.passwd.value=="")  
         {  
             //alert("请输入合法ID");  
             $('.popover-passwd').popover('show');
             return false;  
         } 
         $('.popover-usersave').popover('show');
         return true;  
     }
     function hidepopover()
     {
     	$('.popover-passwd').popover('hide');
     	$('.popover-cls').popover('hide');
     	$('.popover-gender').popover('hide');
     	$('.popover-name').popover('hide');
     	$('.popover-stuid').popover('hide');
     }
</script>