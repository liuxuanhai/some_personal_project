<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(request.getParameter("adminname")==null) response.sendRedirect(path+"/exit.jsp"); 
//if(request.getSession().getAttribute("adminname")==null) response.sendRedirect("../exit.jsp");
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
        <!--<img src="/chinapost/Public/assets/img/top.png">-->
    </div>

    <div class="dl-log"><span class="glyphicon glyphicon-user dl-log-user">欢迎您,<%=request.getParameter("adminname")%></span><a href="../exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">日常管理</div></li>		
			<li class="nav-item dl-selected"><div class="nav-item-inner nav-order">信息发布</div></li>
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
				[{id:'2',text:'用户管理',href:'../administrator.do?method=administratorFindExecute'},
				 {id:'3',text:'院系班级',href:'../academy.do?method=academyFindExecute'},
				 {id:'4',text:'学生管理',href:'../student.do?method=studentFindExecute'},
				 {id:'5',text:'教师管理',href:'../teacher.do?method=teacherFindExecute'}
				]}
				//第二个主菜单
				]},
			{id:'15',homePage :  //第二个大模块
			'16',menu:[{text:'信息发布理',items:
			[{id:'16',text:'普通招聘',href:'../ptzhaopin.do?method=ptzhaopinFindExecute'},
			 {id:'17',text:'大型招聘',href:'../dxzhaopin.do?method=dxzhaopinFindExecute'},
			 {id:'18',text:'通知公告',href:'../gonggao.do?method=gonggaoFindExecute'}
			 ]}]}
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>