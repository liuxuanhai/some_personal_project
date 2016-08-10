<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<form action="../administrator.do?method=administratorModifyExecute&adminid=${sessionScope.adminmodifyinfo.adminid}" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="15%" class="tableright" >新密码</td>
        <td><input type="password" id="administratorname" name="administratorname"/></td>
    </tr>
    <tr>
        <td class="tableleft">确认密码</td>
        <td><input type="password" id="administratorpwd" name="administratorpwd"/></td>
    </tr>

    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary" type="button">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
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
             alert("请输入新密码");  
             return false;  
         }  
         else if(form.administratorpwd.value=="")  
         {  
             alert("请输入确认密码");  
             return false;  
         } else if(form.administratorpwd.value!=form.administratorname.value)
         {
         	alert("两次密码输入不一致");  
             return false;
         }else if(form.administratorpwd.value.length<4||form.administratorpwd.value>15)
         {
         	alert('必须保证密码大于4位数且小于15位数');return false;
         }
         return true;  
     }
</script>