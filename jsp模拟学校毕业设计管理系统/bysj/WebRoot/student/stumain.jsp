<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>学生系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/main-min.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='../dwr/util.js'></script>
<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/login.js'></script>
	<script type="text/javascript">
	window.onload=function(){ //加载时执行一个dwr调用ajax方法
		login.getStudentName(document.getElementById("userid").value,callback);
	} 
	function callback(data)
	{
		document.getElementById("username").innerHTML=data;
	}
	</script>
</head>
<body>

<div class="header">
<input type="hidden" value="<%=request.getParameter("studentid")%>" id="userid"/>
    <div class="dl-title">
        学生管理界面
    </div>
    <div class="dl-log">欢迎您，<span class="dl-log-user" id="username"></span><a href="../exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">毕设管理</div></li>		
        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">

    </ul>
</div>
<script type="text/javascript" src="../assets/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="../assets/js/bui-min.js"></script>
<script type="text/javascript" src="../assets/js/common/main-min.js"></script>
<script type="text/javascript" src="../assets/js/config-min.js"></script>
<script>
    BUI.use('common/main',function(){
        var config = [
			{id:'1',homePage :'2',menu:[{text:'毕设管理',items:
				[{id:'2',text:'申报课题',href:'ketishenbao.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'3',text:'选择导师',href:'teachselect.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'4',text:'查看任务书',href:'taskpaper.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'5',text:'开题报告',href:'kaitipaper.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'6',text:'中期检查',href:'zhongqipaper.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'7',text:'论文草稿',href:'lwcgpaper.jsp?stuid=<%=request.getParameter("studentid")%>'},
				 {id:'8',text:'论文定稿',href:'lwpaper.jsp?stuid=<%=request.getParameter("studentid")%>'}
				]},
				{text:'系统管理',items:
					[{id:'13',text:'修改密码',href:'modifypwd.jsp?userid=<%=request.getParameter("studentid")%>'}]}
			]},
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>