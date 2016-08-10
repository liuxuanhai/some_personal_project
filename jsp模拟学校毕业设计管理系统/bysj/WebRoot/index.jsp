<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" />
<title>毕业设计管理系统</title>

<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>

<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>
	<script type='text/javascript' src='dwr/interface/login.js'></script>
<style type="text/css">
html,body {
	height: 100%;
}
.box {
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6699FF', endColorstr='#6699FF'); /*  IE */
	background-image:linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-o-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-moz-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-webkit-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	background-image:-ms-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);
	
	margin: 0 auto;
	position: relative;
	width: 100%;
	height: 100%;
}
.login-box {
	width: 100%;
	max-width:500px;
	height: 400px;
	position: absolute;
	top: 50%;

	margin-top: -200px;
	/*设置负值，为要定位子盒子的一半高度*/
	
}
@media screen and (min-width:500px){
	.login-box {
		left: 50%;
		/*设置负值，为要定位子盒子的一半宽度*/
		margin-left: -250px;
	}
}	

.form {
	width: 100%;
	max-width:500px;
	height: 275px;
	margin: 5px auto 0px auto;
	padding-top: 15px;
}	
.login-content {
	height: 300px;
	width: 100%;
	max-width:500px;
	background-color: rgba(255, 250, 2550, .6);
	float: left;
}		
	
	
.input-group {
	margin: 0px 10px 15px 10px !important;
}
.form-control,
.input-group {
	height: 40px;
}

.form-group {
	margin-bottom: 0px !important;
}
.login-title {
	padding: 20px 10px;
	background-color: rgba(0, 0, 0, .6);
}
.login-title h1 {
	margin-top: 10px !important;
}
.login-title small {
	color: #fff;
}

.link p {
	line-height: 20px;
	margin-top: 30px;
}
.btn-sm {
	padding: 8px 24px !important;
	font-size: 16px !important;
}
.code
    {
       background:url(code_bg.jpg);
       font-family:Arial;
       font-style:italic;
        color:blue;
        font-size:20px;
        border:0;
        padding:1px 1px;
        letter-spacing:1px;
        font-weight:bolder;            
        float:left;           
        cursor:pointer;
        width:100px;
        height:40px;
        line-height:40px;
        text-align:center;
        vertical-align:middle;
    }
</style>

</head>

<body onload="createCode()">
<div class="box">
		<div class="login-box">
			<div class="login-title text-center">
				<h1><small>毕业设计管理系统欢迎您</small></h1>
			</div>
			<div class="login-content ">
			<div class="form">
			<form action="" method="post">
				
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
							<input type="text" id="username" name="username" class="form-control" placeholder="用户名" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="input-group">
							<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
							<input type="password" id="password" name="password" class="form-control" placeholder="密码" />
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12  ">
						<div class="form input-group text-left" >
							<label class="checkbox-inline">
						      <input type="radio" name="optionsRadiosinline" id="optionsRadios1" value="option2" checked /> 学生
						    </label>
						    <label class="checkbox-inline">
						      <input type="radio" name="optionsRadiosinline" id="optionsRadios2" value="option2" /> 教师
						    </label>
						    <label class="checkbox-inline">
						      <input type="radio" name="optionsRadiosinline" id="optionsRadios3" value="option2" /> 管理员
						    </label>
						</div>
					</div>
				</div>
				<div class="form-group ">
					<div  class="text-center">
						<button class="btn btn-primary btn-sm" type="button" onclick="signin()">登录</button>
					</div>
				</div>
				
			</form>
			</div>
		</div>
	</div>
</div>


</body>
<script type="text/javascript">
     function signin()
     {
     	if(document.getElementById("username").value=='')
     	{
     		alert("用户名不能为空！");
     		return;
     	}
     	if(document.getElementById("password").value=='')
     	{
     		alert("密码不能为空！");
     		return;
     	}//checkCode
     	if(document.getElementById("optionsRadios1").checked) {
     		login.loginStudent(document.getElementById("username").value,document.getElementById("password").value,signinCallback);
     	}
     	if(document.getElementById("optionsRadios2").checked) {
     		login.loginTeacher(document.getElementById("username").value,document.getElementById("password").value,signinCallback);
     	}
     	if(document.getElementById("optionsRadios3").checked) {
     		login.loginAdmin(document.getElementById("username").value,document.getElementById("password").value,signinCallback);
     	}
     }
     function signinCallback(data){
		if(data=="fail") alert("用户或密码错误");
		else if(data=="success") 
		{
			if(document.getElementById("optionsRadios1").checked)
				window.location.href="student/stumain.jsp?studentid="+document.getElementById("username").value;
			if(document.getElementById("optionsRadios2").checked)
			{
				//alert("admin/adminmain.jsp?adminname="+document.getElementById("username").value);
				window.location.href="teacher/teachmain.jsp?teachername="+document.getElementById("username").value;
			}
				
			if(document.getElementById("optionsRadios3").checked)
			{
				window.location.href="admin/adminmain.jsp?adminname="+document.getElementById("username").value;
			}
		}
	}
</script>
</html>