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
</head>
<body>
<form id="formadd" action="studentadd1.jsp" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="10%" class="tableleft">学号</td>
        <td><input type="text" id="stuid" name="stuid"  class="popover-stuid" data-toggle="popover" data-placement="right" data-content="学号不能为空" onkeypress="hidepopover()" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td><input type="text" id="name" name="name"  class="popover-name" data-toggle="popover" data-placement="right" data-content="姓名不能为空" onkeypress="hidepopover()"/></td>
    </tr>
	<tr>
        <td class="tableleft">性别</td>
        <td>
        	<input type="radio" id="sex" name="sex" value="男" checked/> 男&nbsp;&nbsp;
            <input type="radio" id="sex" name="sex" value="女"/> 女
        </td>
    </tr>
    <tr>
        <td class="tableleft">班级</td>
        <td><input type="text" id="cls" name="cls" class="popover-cls" data-toggle="popover" data-placement="right" data-content="班级不能为空" onkeypress="hidepopover()"/></td>
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
				window.location.href="studentadd1.jsp";
		 });

    });
     
	function validate_info(form)  
     {  
         if(document.getElementById("stuid").value=="")  
         {   
             $('.popover-stuid').popover('show'); 
         }  
         else if(document.getElementById("name").value=="")  
         {    
             $('.popover-name').popover('show');
         }
         else if(document.getElementById("cls").value=="")  
         {  
             $('.popover-cls').popover('show');
         }  
         document.getElementById("formadd").submit();
     } 
     function hidepopover()
     {
     	$('.popover-passwd').popover('hide');
     	$('.popover-cls').popover('hide');
     	$('.popover-gender').popover('hide');
     	$('.popover-name').popover('hide');
     	$('.popover-stuid').popover('hide');
     	//$('.popover-stuidverify').popover('hide');
     }
</script>