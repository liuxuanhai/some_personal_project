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
	<script type='text/javascript' src='../dwr/interface/teacher.js'></script>
</head>
<body>
<form id="formadd" action="teacheradd1.jsp" method="post" class="form-inline definewidth m20" >
<input type="hidden" id="username" name="username"  />
<input type="hidden" id="school" name="school"  />
<input type="hidden" id="passwd" name="passwd" />
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">教师工号</td>
        <td><input type="text" id="teacherid" name="teacherid"  class="popover-teachid" data-toggle="popover" data-placement="right" data-content="工号不能为空" onkeypress="hidepopover()" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td><input type="text" id="name" name="name"  class="popover-name" data-toggle="popover" data-placement="right" data-content="姓名不能为空" onkeypress="hidepopover()"/></td>
    </tr>
	<tr>
        <td class="tableleft">性别</td>
        <td>
        	<input type="radio" id="gender" name="gender" value="男" checked/> 男&nbsp;&nbsp;
            <input type="radio" id="gender" name="gender" value="女"/> 女
        </td>
    </tr>
    <tr>
        <td class="tableleft">研究方向</td>
        <td><input type="text" id="subject" name="subject" class="popover-subject" data-toggle="popover" data-placement="right" data-content="课程不能为空" onkeypress="hidepopover()"/></td>
    </tr>

    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="button" onclick="validate_info()" class="btn btn-primary popover-usersave"  data-toggle="popover" data-placement="bottom" data-content="保存完成">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
	
    $(function () {       
		$('#backid').click(function(){
				window.location.href="teachermana.jsp";
		 });

    });
     
	function validate_info(form)  
     {  
         if(document.getElementById("teacherid").value=="")  
         {   
             $('.popover-teachid').popover('show'); 
         }  
         else if(document.getElementById("name").value=="")  
         {    
             $('.popover-name').popover('show');
         }
         else if(document.getElementById("subject").value=="")  
         {  
             $('.popover-subject').popover('show');
         }  
         document.getElementById("formadd").submit();
     }
     function hidepopover()
     {
     	$('.popover-passwd').popover('hide');
     	$('.popover-subject').popover('hide');
     	$('.popover-gender').popover('hide');
     	$('.popover-name').popover('hide');
     	$('.popover-teachid').popover('hide');
     }
</script>