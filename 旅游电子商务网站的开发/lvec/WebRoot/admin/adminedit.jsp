<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Administrator" %>
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
	Administrator admininfo=(Administrator)session.getAttribute("adminmodifyinfo"); //获得session的值  
	//System.out.println(admininfo.getUsername()+admininfo.getPasswd());
%>
<form action="../administrator.do?method=administratorModifyExecute&adminid=<%=admininfo.getAdminid() %>" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">用户名</td>
        <td><input type="text" id="administratorname" name="administratorname"  value="<%=admininfo.getUsername() %>" class="popover-username" data-toggle="popover" data-placement="right" data-content="用户名不能为空" onkeypress="$('.popover-username').popover('hide');$('.popover-userpwd').popover('hide')"/></td>
    </tr>
    <tr>
        <td class="tableleft">用户密码</td>
        <td><input type="password" id="administratorpwd" name="administratorpwd" value="<%=admininfo.getPasswd() %>" class="popover-userpwd" data-toggle="popover" data-placement="right" data-content="用户密码不能为空" onkeypress="$('.popover-username').popover('hide');$('.popover-userpwd').popover('hide')"/></td>
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
				window.location.href="../administrator.do?method=administratorFindExecute";
		 });

    });
     
	function validate_info(form)  
     {  
         if(form.administratorname.value=="")  
         {  
             //alert("请输入正确的名字");  
             $('.popover-username').popover('show');
             return false;  
         }  
         else if(form.administratorpwd.value=="")  
         {  
             //alert("请输入合法ID");  
             $('.popover-userpwd').popover('show');
             return false;  
         }  
         $('.popover-usersave').popover('show');
         return true;  
     }
</script>