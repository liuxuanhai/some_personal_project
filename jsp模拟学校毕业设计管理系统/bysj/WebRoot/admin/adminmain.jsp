<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(request.getParameter("adminname")==null) response.sendRedirect(path+"/admin/index.jsp"); 
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>管理员系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/main-min.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="header">

    <div class="dl-title">
        管理员系统界面
    </div>

    <div class="dl-log">欢迎您，<span class="dl-log-user"><%=request.getParameter("adminname")%></span><a href="../exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">数据管理</div></li>		
			<li class="nav-item dl-selected"><div class="nav-item-inner nav-order">系统管理</div></li>
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
			{id:'1',homePage :'2',menu:[{text:'数据管理',items:
				[{id:'2',text:'学生管理',href:'studentmana.jsp'},{id:'3',text:'教师管理',href:'teachermana.jsp'}
				,{id:'4',text:'课题管理',href:'ketimana.jsp'}]}]},
			{id:'14',homePage :
			'15',menu:[{text:'系统管理',items:
			[{id:'15',text:'用户管理',href:'adminmana.jsp'}]}]}
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>