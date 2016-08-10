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
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="../bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<body>
<form id="addform" action="../ptzhaopin.do?method=ptzhaopinAddExecute" method="post" class="definewidth m20" >
<table class="table table-bordered table-hover definewidth m10">
<caption class="text-center">普通招聘会信息添加</caption>
	<tr>
        <td class="tableleft">招聘题目</td>
        <td colspan="3"><input type="text" id="title" name="title" class="form-control"/></td>
    </tr>
    <tr>
        <td width="15%" class="tableleft">单位名称</td>
        <td width="35%"><input type="text" id="name" name="name" class="form-control"/></td>
        <td width="15%" class="tableleft">单位联系电话</td>
        <td width="35%"><input type="text" id="phone" name="phone" class="form-control"/></td>
    </tr>

    <tr>
        <td class="tableleft">单位邮箱地址</td>
        <td><input type="text" id="email" name="email" class="form-control"/></td>
        <td class="tableleft">单位传真号码</td>
        <td><input type="text" id="chuanzhen" name="chuanzhen" class="form-control"/></td>
    </tr>
    <tr>
        <td class="tableleft">单位所在省份</td>
        <td><input type="text" id="shenfe" name="shenfe" class="form-control"/></td>
        <td class="tableleft">单位性质</td>
        <td><input type="text" id="xingzhi" name="xingzhi" class="form-control"/></td>
    </tr>
    <tr>
        <td class="tableleft">单位所属行业</td>
        <td><input type="text" id="hangye" name="hangye" class="form-control"/></td>
        <td class="tableleft">单位网址主页</td>
        <td><input type="text" id="homeurl" name="homeurl" class="form-control"/></td>
    </tr>
    <tr>
        <td class="tableleft">单位详细地址</td>
        <td colspan="3"><input type="text" id="address" name="address" class="form-control"/></td>
    </tr>

    <tr>
        <td class="tableleft">招聘会地址</td>
        <td><input type="text" id="zpaddr" name="zpaddr" class="form-control"/></td>
        <td class="tableleft">招聘会起止时间</td>
        <td>
        	<div class="form-inline">
        	<input type="text" id="starttime" name="starttime" placeholder="2016-5-1 15:00" readonly class="form_datetime form-control"/>
        	至
        	<input type="text" id="endtime" name="endtime" placeholder="2016-5-1 15:00" readonly class="form_datetime form-control"/>
        	</div>
        </td>
    </tr>
    <tr>
        <td class="tableleft">招聘岗位</td>
        <td><input type="text" id="gangwei" name="gangwei" class="form-control"/></td>
                <td class="tableleft">学历要求</td>
        <td><input type="text" id="xueli" name="xueli" class="form-control"/></td>
    </tr>

    <tr>
        <td class="tableleft">需求专业</td>
        <td><input type="text" id="zhuanye" name="zhuanye" class="form-control"/></td>
                <td class="tableleft">需求人数</td>
        <td><input type="text" id="nums" name="nums" class="form-control" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/></td>
    </tr>

    <tr>
        <td class="tableleft">招聘岗位描述</td>
        <td colspan="3"><textarea rows="2" cols="" id="gangweidescr" name="gangweidescr" class="form-control"></textarea></td>
    </tr>
    <tr>
        <td class="tableleft">单位详细描述</td>
        <td colspan="3"><textarea rows="4" cols="" id="dwdescr" name="dwdescr" class="form-control"></textarea>
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td colspan="3">
            <button type="button" class="btn btn-primary" onclick="onadd()">保存</button> 
            &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>

//时间控件初始化
$(".form_datetime").datetimepicker({
	language:  'zh-CN',
	format: 'yyyy-mm-dd hh:ii',
	autoclose: true,
	weekStart: 1,
    todayBtn:  1,
    todayHighlight: 1
	});
$(".form_datetime").datetimepicker( 'update', new Date() );	
	
    $(function () {       
		$('#backid').click(function(){
				window.location.href="../ptzhaopin.do?method=ptzhaopinFindExecute";
		 });
    });
    function onadd()
    {
    	if($("#title").val()=="")
   		{
    		alert("请输入招聘题目");  
            return; 
   		}
    	if($("#name").val()=="")
    	{  
             alert("请输入单位名字");  
             return;  
         }  
        if($("#shenfe").val()=="")  
         {  
             alert("请输入单位所在省份");  
             return;  
         } 
        if($("#xingzhi").val()=="")  
        {  
            alert("请输入单位性质");  
            return;  
        }
        if($("#hangye").val()=="")  
        {  
            alert("请输入单位所属行业");  
            return;  
        }
        if($("#address").val()=="")  
        {  
            alert("请输入单位详细地址");  
            return;  
        }
        if($("#zpaddr").val()=="")  
        {  
            alert("请输入招聘会地址");  
            return;  
        }
        if($("#starttime").val()=="")
       	{
        	alert("请选择的招聘会开始时间，如2016-5-1 15:00");  
            return;
       	}
        if($("#endtime").val()=="")
       	{
        	alert("请选择招聘会结束时间，如2016-5-1 15:00");  
            return;
       	}
        if($("#dwdescr").val()=="")  
        {  
            alert("请输入单位详细描述");  
            return;  
        }
        if($("#gangwei").val()=="")  
        {  
            alert("请输入招聘岗位");  
            return;  
        }
        if($("#xueli").val()=="")  
        {  
            alert("请输入学历要求");  
            return;  
        }
        if($("#zhuanye").val()=="")  
        {  
            alert("请输入需求专业");  
            return;  
        }
        if($("#nums").val()=="")  
        {  
            alert("请输入需求人数");  
            return;  
        }
        if($("#gangweidescr").val()=="")  
        {  
            alert("请输入招聘岗位描述");  
            return;  
        }
        
        $("#addform").submit(); // 添加到数据库中
    }
    
</script>