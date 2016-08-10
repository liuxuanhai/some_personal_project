<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title>普通招聘查看</title>
    <meta charset="UTF-8">
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<script src="scripts/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/navbar.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
</head>

<div class="container">
<div class="m10"></div>
<!-- Static navbar -->
<div class="row">
<div class="col-sm-12">
      <nav class="navbar navbar-default" >
                <div class="container-fluid">
          <div class="navbar-header" style="font-size: 20px;">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <span class="navbar-brand">高校顶岗实习与就业跟踪系统</span>
            
          </div>
          <div id="navbar" class="navbar-collapse collapse" style="font-size: 18px;">
            <ul class="nav navbar-nav">
              <li ><a href="<%=path %>/index.jsp">首页</a></li>
              <li ><a href="qiantai.do?method=gonggaoIndexExecute">新闻公告</a></li>
              <li class="active"><a href="qiantai.do?method=ptzhaopinIndexExecute">普通招聘</a></li>
              <li><a href="qiantai.do?method=dxzhaopinIndexExecute">大型招聘</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      </div>
</div>

<div class="m10"  style="border:1px solid #ccc;">
	<div class="text-center m10"><h1>${sessionScope.ptzhaopinlook.title}</h1></div>
	<hr />
	<div class="text-center">
	<small>
	发布时间:<em>${sessionScope.ptzhaopinlook.addtime}</em>&nbsp;&nbsp;&nbsp;&nbsp;浏览量:<em>${sessionScope.ptzhaopinlook.looksnum}</em>
	</small></div>
	
	<div class="row">
	 <div class="col-md-10 col-md-offset-1">
 	<div class="m10">
 			<h4 class="title">单位基本信息</h4>
 			<table class="table table-bordered ">
 			<tr>
 			<td width="15%" class="tableleft">单位名称</td>
	        <td width="35%">${sessionScope.ptzhaopinlook.name}</td>
	        <td width="15%" class="tableleft">单位联系电话</td>
	        <td width="35%">${sessionScope.ptzhaopinlook.phone}</td>
 			</tr>
 			<tr>
        <td class="tableleft">单位邮箱地址</td>
        <td>${sessionScope.ptzhaopinlook.email}</td>
        <td class="tableleft">单位传真号码</td>
        <td>${sessionScope.ptzhaopinlook.chuanzhen}</td>
	    </tr>
	    <tr>
	        <td class="tableleft">单位所在省份</td>
	        <td>${sessionScope.ptzhaopinlook.shenfe}</td>
	        <td class="tableleft">单位性质</td>
	        <td>${sessionScope.ptzhaopinlook.xingzhi}</td>
	    </tr>
	    <tr>
	        <td class="tableleft">单位所属行业</td>
	        <td>${sessionScope.ptzhaopinlook.hangye}</td>
	        <td class="tableleft">单位网址主页</td>
	        <td>${sessionScope.ptzhaopinlook.homeurl}</td>
	    </tr>
	    <tr>
	        <td class="tableleft" align="left">单位详细地址</td>
	        <td colspan="3">${sessionScope.ptzhaopinlook.address}</td>
	    </tr>
 			</table>
 	</div>
 	<div class="m20">
 	 	<div>
 		<h4 class="title">招聘会信息</h4>
 		<p>
 		招聘地点：${sessionScope.ptzhaopinlook.zpaddr}
 		</p>
 		<p>
 		开始时间：${sessionScope.ptzhaopinlook.starttime}
 		</p>
 		<p>
 		结束时间：${sessionScope.ptzhaopinlook.endtime}
 		</p>
 		</div>
 		<div class="m20" >
 		<h4 class="title">单位简介</h4>
 		<p style="line-height:200%;">
 		${sessionScope.ptzhaopinlook.dwdescr}
 		</p>
 		</div>
 		<div class="m20">
 		<h4 class="title">单位需求</h4>
 		<p>岗位名称：${sessionScope.ptzhaopinlook.gangwei}</p>
 		<p>学历要求：${sessionScope.ptzhaopinlook.xueli}</p>
 		<p>需求专业：${sessionScope.ptzhaopinlook.zhuanye}</p>
 		<p>需求人数：${sessionScope.ptzhaopinlook.nums}人</p>
 		<p style="line-height:200%;">岗位描述：${sessionScope.ptzhaopinlook.gangweidescr}</p>
 		</div>
 	</div>
 	<hr style="height:3px;border:none;border-top:3px double red;">
	<div class="text-center"><a href="javascirpt:void(0)" onclick="window.close()">关闭页面</a></div>
	 </div>
	</div>
</div>
</div>
<div class="m30"></div>
</body>
</html>
