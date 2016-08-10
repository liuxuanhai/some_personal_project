<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//if(request.getParameter("adminname")==null) response.sendRedirect(path+"/exit.jsp"); 
if(request.getSession().getAttribute("teacher")==null) response.sendRedirect(path+"/exit.jsp");
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>教师系统</title>
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
<input type="hidden" value="${sessionScope.teacher.teaid }" id="userid"/>
    <div class="dl-log"><span class="glyphicon glyphicon-user dl-log-user" id="username">欢迎您,${sessionScope.teacher.name }</span>&nbsp;&nbsp;
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
				[{id:'2',text:'负责班级',href:'../teacher.do?method=getTeacherClassExecute&teacherid=${sessionScope.teacher.teaid }'},
				 {id:'3',text:'实习周记',href:'../studentdocument.do?method=studentdocumentByTeacherFindExecute1&papertype=0&teacherid=${sessionScope.teacher.teaid}'},
				 {id:'4',text:'实习报告',href:'../studentdocument.do?method=studentdocumentByTeacherFindExecute&papertype=1&teacherid=${sessionScope.teacher.teaid}'},
				 {id:'5',text:'三方协议',href:'../studentdocument.do?method=studentdocumentByTeacherFindExecute&papertype=2&teacherid=${sessionScope.teacher.teaid}'},
				 {id:'6',text:'离校手续',href:'../studentdocument.do?method=studentdocumentByTeacherFindExecute&papertype=3&teacherid=${sessionScope.teacher.teaid}'},
				 {id:'7',text:'待审材料',href:'../studentdocument.do?method=studocReviewByTeacherFindExecute&teacherid=${sessionScope.teacher.teaid}'}
				]},
				//第二个主菜单
				]},
			{id:'14',homePage :
				'15',menu:[{text:'系统管理',items:
				[{id:'15',text:'个人信息',href:'../teacher.do?method=getPersonTeacherExecute&teacherid=${sessionScope.teacher.teaid }'},
				 {id:'16',text:'修改密码',href:'modifypwd.jsp?userid=${sessionScope.teacher.teaid }'}]}]}
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>