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
<script type='text/javascript' src='../dwr/interface/academy.js'></script>
</head>
<body>
<form id="addform" action="../academy.do?method=academyModifyExecute&academyid=${sessionScope.academymodifyinfo.academyid}" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="20%" class="tableleft">院系名称</td>
        <td><input type="text" id="academyname" name="academyname" class="form-control" value="${sessionScope.academymodifyinfo.academyname}"/>
        <input type="hidden" value="${sessionScope.academymodifyinfo.academyname}" id="hidentext"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">院系简介</td>
        <td>
        <textarea rows="4" cols="" id="academydescr" name="academydescr" class="form-control">
        ${sessionScope.academymodifyinfo.academydescr}
        </textarea>
        </td>
    </tr>

    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="button" class="btn btn-primary" onclick="onsave()">保存</button> 
            &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
    $(function () {       
		$('#backid').click(function(){
				window.location.href="../academy.do?method=academyFindExecute";
		 });

    });
    function onsave()
    {
    	if($("#academyname").val()=="")
    	{  
             alert("请输入院系名称名字");  
             return;  
         }  
         else if($("#academydescr").val()=="")  
         {  
             alert("请输入院系简介");  
             return;  
         } 
         if($("#hidentext").val()==$("#academyname").val().trim())
         	$("#addform").submit(); // 添加到数据库中
         else
         	academy.findAcademyName($("#academyname").val(),callback);
    }
	function callback(data)
	{
		if(data==true)
		{
			alert('院系名称已经存在，请修改');return;
		}
		$("#addform").submit(); // 添加到数据库中
	}  

</script>