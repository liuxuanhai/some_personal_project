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
<form id="addform" action="../teacher.do?method=teacherModifyExecute" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="20%" class="tableleft">工号</td>
        <td width="80%"><input type="text" id="teaid" name="teaid" style="width:300px;" value="${sessionScope.teachermodifyinfo.teaid}" readonly/></td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td>
        <input type="text" id="name" name="name" style="width:300px;" value="${sessionScope.teachermodifyinfo.name}"/>
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
		   <input type="hidden" value="${sessionScope.teachermodifyinfo.sex}" id="hidesex"/>
	    </div>
        </td>
    </tr>
	<tr>
        <td class="tableleft" >院系</td>
        <td>
        <select id="academy" name="academyid" style="width:300px;">
        <c:forEach items="${sessionScope.teaacademylist}" var="teaacademy">
       	<option value="<c:out value="${teaacademy.academyid}"/>">
       	<c:out value="${teaacademy.academyname}"/>
       	</option>
		</c:forEach>
        </select>
        <input type="hidden" value="${sessionScope.teachermodifyinfo.academy.academyid}" id="hideacademy"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">职称</td>
        <td>
        <input type="text" id="level" name="level" style="width:300px;" value="${sessionScope.teachermodifyinfo.level}"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">研究方向</td>
        <td>
        <input type="text" id="direction" name="direction" style="width:300px;" value="${sessionScope.teachermodifyinfo.direction}"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">电话</td>
        <td>
        <input type="text" value="${sessionScope.teachermodifyinfo.phone}" id="phone" name="phone" style="width:300px;" placeholder="11位手机号" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">身份证</td>
        <td>
        <input type="text" value="${sessionScope.teachermodifyinfo.idcard}" id="idcard" name="idcard" style="width:300px;" placeholder="15位或18位" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
    <c:set var="stringtime" value="${fn:split(sessionScope.teachermodifyinfo.schooltime, ' ')}" />
        <td class="tableleft">入职日期</td>
        <td>
        <input type="text" value="${stringtime[0]}" id="schooltime" name="schooltime" style="width:300px;" placeholder="格式如:2016-9-1"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">QQ号码</td>
        <td>
        <input type="text" value="${sessionScope.teachermodifyinfo.qqid}" id="qqid" name="qqid" style="width:300px;" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">角色类型</td>
        <td>
        <div class="radio">
		   <label>
		   <input type="radio" name="roletype" value="0" checked  />普通角色
		   </label>&nbsp;&nbsp;
		   <label>
		   <input type="radio" name="roletype" value="1"  />院系管理员
		   </label>
	    </div>
	    <input type="hidden" value="${sessionScope.teachermodifyinfo.roletype}" id="hideroletype"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="button" class="btn btn-primary" onclick="onadd()">保存</button> 
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
				window.location.href="../teacher.do?method=teacherFindExecute";
		 });
		if($("#hidesex").val()=="女") $("input:radio[name=sex]:eq(1)").attr("checked",'checked');
		$("#academy").val($("#hideacademy").val());
		if($("#hideroletype").val()=="1") $("input:radio[name=roletype]:eq(1)").attr("checked",'checked');
    });
    
  //判断是否为有效日期
    function isDate(str)
    {
        if(!/^(\d{4})\-(\d{1,2})\-(\d{1,2})$/.test(str))
            return false;
        var year = RegExp.$1-0;
        var month = RegExp.$2-1;
        var date = RegExp.$3-0;
        var obj = new Date(year,month,date);
        return !!(obj.getFullYear()==year && obj.getMonth()==month && obj.getDate()==date);
    }
  //保存验证
    function onadd()
    {
        if($("#name").val()=="")  
        {  
            alert("请输入教师姓名");  
            return;  
        }
        if($("#academy").val()==""||$("#academy").val()==null)
    	{  
             alert("请选择院系");  
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
        if($("#schooltime").val()!=""&&!isDate($("#schooltime").val()))
        {
        	alert("请输入有效的入学日期,如2016-9-1");  
            return; 
       	}
        $("#addform").submit(); // 添加到数据库中
    }
</script>