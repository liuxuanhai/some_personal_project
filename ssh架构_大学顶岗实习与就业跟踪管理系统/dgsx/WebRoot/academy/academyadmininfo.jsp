<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<form id="addform" action="../teacher.do?method=academyAdminInfoModifyExecute" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="20%" class="tableleft">工号</td>
        <td width="80%"><input type="text" id="teaid" name="teaid" style="width:300px;" value="${sessionScope.academyadmininfo.teaid}" readonly/></td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td>
        <input type="text" id="name" name="name" style="width:300px;" value="${sessionScope.academyadmininfo.name}"/>
        </td>
    </tr>
	
	<tr>
        <td class="tableleft">性别</td>
        <td>
        <div class="radio">
		   <label>
		   <input type="radio" name="sex" value="男" checked  />男
		   </label>&nbsp;&nbsp;
		   <label>
		   <input type="radio" name="sex" value="女"  />女
		   </label>
		   <input type="hidden" value="${sessionScope.academyadmininfo.sex}" id="hidesex"/>
	    </div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">研究方向</td>
        <td>
        <input type="text" id="direction" name="direction" style="width:300px;" value="${sessionScope.academyadmininfo.direction}"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">电话</td>
        <td>
        <input type="text" value="${sessionScope.academyadmininfo.phone}" id="phone" name="phone" style="width:300px;" placeholder="11位手机号" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">身份证</td>
        <td>
        <input type="text" value="${sessionScope.academyadmininfo.idcard}" id="idcard" name="idcard" style="width:300px;" placeholder="15位或18位" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">QQ号码</td>
        <td>
        <input type="text" value="${sessionScope.academyadmininfo.qqid}" id="qqid" name="qqid" style="width:300px;" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="button" class="btn btn-primary" onclick="onadd()">保存</button> 
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>

    $(function () {       
		if($("#hidesex").val()=="女") $("input:radio[name=sex]:eq(1)").attr("checked",'checked');
    });
    
  //保存验证
    function onadd()
    {
        if($("#name").val()=="")  
        {  
            alert("请输入姓名");  
            return;  
        } 
        if($("#qqid").val()=="")  
        {  
            alert("请输入QQ号码");  
            return;  
        }
        var myreg1 = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        if($("#phone").val()!=""&&!myreg1.test($("#phone").val()))
       	{
        	alert("请输入有效的手机号");  
            return;  
       	}
        if($("#idcard").val()!=""&&$("#idcard").val().length!=15&&$("#idcard").val().length!=18)
       	{
        	alert("请输入有效的身份证号");  
            return; 
       	}
        //$("#addform").submit(); // 添加到数据库中
        var data=new Array();
        data.push($("#teaid").val());
        data.push($("#name").val());
        data.push($('input[name="sex"]:checked').val());
        data.push($("#direction").val());
        data.push($("#phone").val());
        data.push($("#idcard").val());
        data.push($("#qqid").val());
        teacher.teacherInfoModify(data,callback);
    }
  function callback()
  {
	  alert('保存完成');
  }
</script>