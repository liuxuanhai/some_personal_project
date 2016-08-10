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
</head>
<body>
<div class="m30"></div>
<div class="container" style="border:1px solid #ccc;">
	<div class="text-center m20"><h1>${sessionScope.ptzhaopininfolook.title}</h1></div>
	
	<div class="text-center m20">
	<small>
	发布时间:<em>${sessionScope.ptzhaopininfolook.addtime}</em>&nbsp;&nbsp;&nbsp;&nbsp;浏览量:<em>${sessionScope.ptzhaopininfolook.looksnum}</em>
	</small></div>
	
	<div class="row">
	 <div class="col-md-10 col-md-offset-1">
 	<div class="m10">
 			<h4 class="title">单位基本信息</h4>
 			<table class="table table-bordered ">
 			<tr>
 			<td width="15%" class="tableleft">单位名称</td>
	        <td width="35%">${sessionScope.ptzhaopininfolook.name}</td>
	        <td width="15%" class="tableleft">单位联系电话</td>
	        <td width="35%">${sessionScope.ptzhaopininfolook.phone}</td>
 			</tr>
 			<tr>
        <td class="tableleft">单位邮箱地址</td>
        <td>${sessionScope.ptzhaopininfolook.email}</td>
        <td class="tableleft">单位传真号码</td>
        <td>${sessionScope.ptzhaopininfolook.chuanzhen}</td>
	    </tr>
	    <tr>
	        <td class="tableleft">单位所在省份</td>
	        <td>${sessionScope.ptzhaopininfolook.shenfe}</td>
	        <td class="tableleft">单位性质</td>
	        <td>${sessionScope.ptzhaopininfolook.xingzhi}</td>
	    </tr>
	    <tr>
	        <td class="tableleft">单位所属行业</td>
	        <td>${sessionScope.ptzhaopininfolook.hangye}</td>
	        <td class="tableleft">单位网址主页</td>
	        <td>${sessionScope.ptzhaopininfolook.homeurl}</td>
	    </tr>
	    <tr>
	        <td class="tableleft" align="left">单位详细地址</td>
	        <td colspan="3">${sessionScope.ptzhaopininfolook.address}</td>
	    </tr>
 			</table>
 	</div>
 	<div class="m20">
 	 	<div>
 		<h4 class="title">招聘会信息</h4>
 		<p>
 		招聘地点：${sessionScope.ptzhaopininfolook.zpaddr}
 		</p>
 		<p>
 		开始时间：${sessionScope.ptzhaopininfolook.starttime}
 		</p>
 		<p>
 		结束时间：${sessionScope.ptzhaopininfolook.endtime}
 		</p>
 		</div>
 		<div class="m20" >
 		<h4 class="title">单位简介</h4>
 		<p style="line-height:200%;">
 		${sessionScope.ptzhaopininfolook.dwdescr}
 		</p>
 		</div>
 		<div class="m20">
 		<h4 class="title">单位需求</h4>
 		<p>岗位名称：${sessionScope.ptzhaopininfolook.gangwei}</p>
 		<p>学历要求：${sessionScope.ptzhaopininfolook.xueli}</p>
 		<p>需求专业：${sessionScope.ptzhaopininfolook.zhuanye}</p>
 		<p>需求人数：${sessionScope.ptzhaopininfolook.nums}人</p>
 		<p style="line-height:200%;">岗位描述：${sessionScope.ptzhaopininfolook.gangweidescr}</p>
 		</div>
 	</div>
 	<hr style="height:3px;border:none;border-top:3px double red;">
	<div class="text-center"><a href="javascirpt:void(0)" onclick="window.close()">关闭页面</a></div>
	 </div>
	</div>
</div>
<div class="m30"></div>
</body>
</html>
