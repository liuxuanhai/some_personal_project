<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("mess")=="wrong") out.println("<script type=text/javascript>$('.popover-user').popover('show')</script>");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="登录界面">
    <meta name="author" content="jly">

    <title>管理员登录界面</title>

    <!-- Bootstrap core CSS -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="../scripts/jquery.js"></script>
    <script src="../bootstrap/js/bootstrap.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="../css/login.css" rel="stylesheet">
    
<script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/administrator.js'></script>
    
    <script type="text/javascript">
	function onValidation()
	{
		administrator.administratorLogin(document.getElementById("administratorname").value,document.getElementById("administratorpwd").value,signinCallback);
	}
	function signinCallback(data){
		if(data=="fail") $('.popover-user').popover('show');
		else if(data=="success") 
			window.location.href="adminmain.jsp?adminname="+document.getElementById("administratorname").value;
	}
	</script>
  </head>

  <body>

    <div class="container">

      <form class="form-signin"> 
        <h2 class="form-signin-heading " id="usertitle" name="usertitle">管理员登录</h2>
        <label for="inputEmail" class="sr-only">用户名</label>
        <input type="text" id="administratorname" name="administratorname" class="form-control" placeholder="用户名" required autofocus onfocus="$('.popover-user').popover('hide')" >
        <label for="inputPassword" class="sr-only">密码</label>
        <input type="password" id="administratorpwd" name="administratorpwd" class="form-control" placeholder="密码" required onfocus="$('.popover-user').popover('hide')" >

        <button class="btn btn-lg btn-primary btn-block popover-user" type="button" data-toggle="popover" data-placement="bottom" data-content="用户或密码错误" onclick="onValidation()">登录</button>
      </form>

    </div> <!-- /container -->
  </body>
</html>
