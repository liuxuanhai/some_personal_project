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
        <!--<img src="/chinapost/Public/assets/img/top.png">-->
    </div>

    <div class="dl-log">欢迎您，<span class="dl-log-user"><%=request.getParameter("adminname")%></span><a href="exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">日常管理</div></li>		
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
			{id:'1',homePage :'2',menu:[
				{text:'日常管理',items:
				[{id:'2',text:'会员管理',href:'../spotuser.do?method=spotuserFindExecute'},
				 {id:'3',text:'景点管理',href:'../viewspot.do?method=viewspotFindExecute'},
				 {id:'4',text:'酒店管理',href:'../hotel.do?method=hotelFindExecute'},
				 {id:'5',text:'产品分类',href:'../goodtype.do?method=goodtypeAllExecute'},
				 {id:'6',text:'产品管理',href:'../goodinfo.do?method=goodinfoFindExecute'},
				]},
				{text:'订单管理',items:
				[{id:'7',text:'景点订单',href:'../spotorder.do?method=spotorderFindExecute'},
				 {id:'8',text:'酒店订单',href:'../hotelorder.do?method=hotelorderFindExecute'},
				 {id:'9',text:'产品订单',href:'../goodorder.do?method=goodorderFindExecute'}
				]}
				]},
			{id:'15',homePage :
			'16',menu:[{text:'系统管理',items:
			[{id:'16',text:'用户管理',href:'../administrator.do?method=administratorFindExecute'}]}]}
			];
        new PageUtil.MainPage({
            modulesConfig : config
        });
    });
</script>
</body>
</html>