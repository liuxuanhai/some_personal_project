<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("adminname")==null) response.sendRedirect(path+"/exit.jsp"); 
if(request.getSession().getAttribute("academyteacher")==null) response.sendRedirect(path+"/exit.jsp");
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>院系管理员系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/css/main-min.css" rel="stylesheet" type="text/css" />
        <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/teacher.js'></script>
</head>
<body>

<div class="header">

    <div class="dl-title">
        <!--<img src="/chinapost/Public/assets/img/top.png">-->
    </div>
<input type="hidden" value="${sessionScope.academyteacher.teaid }" id="userid"/>
    <div class="dl-log"><span class="glyphicon glyphicon-user dl-log-user" id="username">欢迎您,${sessionScope.academyteacher.name }</span>&nbsp;&nbsp;
    <a href="../exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">日常管理</div></li>
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">系统管理</div></li>			
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
			{id:'1',homePage :'2',menu:[
				{text:'日常管理',items: //第一个主菜单
				[{id:'2',text:'院系班级',href:'../classroom.do?method=academyClassroomFindExecute&academyid=${sessionScope.academyteacher.academy.academyid}'},
				 {id:'3',text:'院系教师',href:'../teacher.do?method=academyTeacherFindByAcademyIDExecute&academyid=${sessionScope.academyteacher.academy.academyid}'},
				 {id:'4',text:'院系就业',href:'../academy.do?method=getAcademyByIDExecute&academyid=${sessionScope.academyteacher.academy.academyid}'},
				 {id:'5',text:'班级就业',href:'../student.do?method=classJobsFindByAcademyIDExecute&academyid=${sessionScope.academyteacher.academy.academyid}'}
				]},
				//第二个主菜单
				]},
			{id:'14',homePage :
				'15',menu:[{text:'系统管理',items:
				[{id:'15',text:'个人信息',href:'../teacher.do?method=getAcademyAdminTeacherExecute&teacherid=${sessionScope.academyteacher.teaid }'},
				 {id:'16',text:'修改密码',href:'modifypwd.jsp?userid=${sessionScope.academyteacher.teaid }'}]}]}
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>