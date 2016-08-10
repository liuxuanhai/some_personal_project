<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<form action="#" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m20">
    <tr>
        <td width="15%" class="tableleft">新密码</td>
        <td><input type="password" id="newpwd" name="newpwd" class="popover-username" data-toggle="popover" data-placement="right" data-content="新密码不能为空" onkeypress="hidepopover()"/></td>
    </tr>
    <tr>
        <td class="tableleft">确认新密码</td>
        <td><input type="password" id="newpwdagain" name="newpwdagain" class="popover-userpwd" data-toggle="popover" data-placement="right" data-content="确认密码不能为空" onkeypress="hidepopover()"/></td>
    </tr>

    <tr>
        <td class="tableleft"></td>
        <td>
            <label id="username" class="sr-only"><%=request.getParameter("userid")%></label>
            <button type="button" class="btn btn-primary popover-usersave" data-toggle="popover" data-placement="bottom" data-content="两次密码输入不一致" id="modifypwd">保存</button> 
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
     $(function () {       
		$('#modifypwd').click(function(){ 
				if(document.getElementById("newpwd").value=="")  
		         {  
		             //alert("请输入正确的名字");  
		             $('.popover-username').popover('show');
		         }  
		         else if(document.getElementById("newpwdagain").value=="")  
		         {  
		             //alert("请输入合法ID");  
		             $('.popover-userpwd').popover('show'); 
		         } else if (document.getElementById("newpwdagain").value!=document.getElementById("newpwd").value)
		         	 $('.popover-usersave').popover('show');
		           else
		           	//alert(document.getElementById("username").innerHTML+document.getElementById("newpwd").value);
		        	   student.studentPWDModify(document.getElementById("username").innerHTML,document.getElementById("newpwd").value,callback);
		           
		 });

    });
    function callback(){
    	document.getElementById("newpwd").value="";
    	document.getElementById("newpwdagain").value="";
    	alert("修改完成");
    }
     function hidepopover()
     {
     	$('.popover-usersave').popover('hide');
     	$('.popover-userpwd').popover('hide');
     	$('.popover-username').popover('hide');
     }
</script>