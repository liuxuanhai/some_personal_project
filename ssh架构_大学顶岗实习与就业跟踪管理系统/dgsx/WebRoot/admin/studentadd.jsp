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
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
<script type='text/javascript' src='../dwr/interface/student.js'></script>
</head>
<body>
<form id="addform" action="../student.do?method=studentAddExecute" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="20%" class="tableleft">学号</td>
        <td width="80%"><input type="text" id="stuid" name="stuid" style="width:300px;" onkeyup="value=value.replace(/[^\w\/]/ig,'')"/></td>
    </tr>
    <tr>
        <td class="tableleft">姓名</td>
        <td>
        <input type="text" id="name" name="name" style="width:300px;"/>
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
	    </div>
        </td>
    </tr>
	<tr>
        <td class="tableleft" >院系</td>
        <td>
        <select id="academy" name="academy" style="width:300px;" onchange="changeacademy()">
        <c:forEach items="${sessionScope.stuacademylist}" var="stuacademy">
       	<option value="<c:out value="${stuacademy.academyid}"/>">
       	<c:out value="${stuacademy.academyname}"/>
       	</option>
		</c:forEach>
        </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">班级</td>
        <td>
        <select id="classroom" name="classid" style="width:300px;">
        </select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">电话</td>
        <td>
        <input type="text" id="phone" name="phone" style="width:300px;" placeholder="11位手机号" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">身份证</td>
        <td>
        <input type="text" id="idcard" name="idcard" style="width:300px;" placeholder="15位或18位" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">入学日期</td>
        <td>
        <input type="text" id="schooltime" name="schooltime" style="width:300px;" placeholder="格式如:2016-9-1"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">QQ号码</td>
        <td>
        <input type="text" id="qqid" name="qqid" style="width:300px;" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
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
	//获得院系的班级
	function changeacademy()
	{
		student.getAcademyClassroom($("#academy").val(),getAcademyClassroomCallback);
	}
	//初始化院系班级
	function getAcademyClassroomCallback(data)
	{
		$("#classroom").html(""); 
		for(var i=0;i<data.length;++i)
			$("#classroom").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>");
	}

    $(function () {       
		$('#backid').click(function(){
				window.location.href="../student.do?method=studentFindExecute";
		 });
		changeacademy();
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
    	if($("#stuid").val()=="")
    	{  
             alert("请输学生学号");  
             return;  
        }  
        if($("#name").val()=="")  
        {  
            alert("请输入学生姓名");  
            return;  
        }
        if($("#academy").val()==""||$("#academy").val()==null)
    	{  
             alert("请选择院系");  
             return;  
        }  
        if($("#classroom").val()==""||$("#classroom").val()==null)  
        {  
            alert("请选择班级");  
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
        student.findStudentStuid($("#stuid").val(),callback);
    }
    
	function callback(data)
	{
		if(data==true)
		{
			alert('该学号已经存在，请修改');return;
		}
		$("#addform").submit(); // 添加到数据库中
	}  

</script>