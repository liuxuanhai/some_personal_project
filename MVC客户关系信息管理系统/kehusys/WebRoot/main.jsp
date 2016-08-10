<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if(request.getParameter("adminname")==null) response.sendRedirect(path+"/index.jsp"); 
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>管理员系统</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/main-min.css" rel="stylesheet" type="text/css" />
    <script type='text/javascript' src='dwr/util.js'></script>
	<script type='text/javascript' src='dwr/engine.js'></script>
	<script type='text/javascript' src='dwr/interface/doajax.js'></script>
</head>
<body>

<div class="header">

    <div class="dl-title text-center">
        客户关系管理系统
    </div>
	<input class="hide" id="yuangongtype" value="<%=request.getParameter("yuangongtype")%>"/>
	<input class="hide" id="userid" value="<%=request.getParameter("userid")%>"/>
    <div class="dl-log">欢迎您，<span class="dl-log-user" id="welcome"><%=request.getParameter("adminname")%></span><a href="exit.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
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
<script type="text/javascript" src="assets/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="assets/js/bui-min.js"></script>
<script type="text/javascript" src="assets/js/common/main-min.js"></script>
<script type="text/javascript" src="assets/js/config-min.js"></script>
<script>
    BUI.use('common/main',function(){
    	if($("#yuangongtype").val()=="0")
    	{
        var config = [
			{id:'1',homePage :'2',menu:[
			                            {text:'日常管理',items:
				[{id:'2',text:'员工管理',href:'servlet/YuangongServlet?method=getYuangong&userid=<%=request.getParameter("userid")%>'},
				 {id:'3',text:'客户管理',href:'servlet/CustomerServlet?method=getCustomer&userid=<%=request.getParameter("userid")%>'},
				 {id:'4',text:'销售管理',href:'servlet/OrdermanaServlet?method=getOrdermana&userid=<%=request.getParameter("userid")%>'},
				 {id:'5',text:'客户分析',href:'servlet/OrdermanaServlet?method=getCustomerStat&userid=<%=request.getParameter("userid")%>'}
				]},
				{text:'客户服务',items:
					[{id:'6',text:'反馈管理',href:'servlet/FankuiServlet?method=getFankui&userid=<%=request.getParameter("userid")%>'},
	   				 {id:'7',text:'投诉管理',href:'servlet/TousuServlet?method=getTousu&userid=<%=request.getParameter("userid")%>'}
					]}
			]},
			{id:'14',homePage :
			'15',menu:[{text:'系统管理',items:
			[{id:'15',text:'修改密码',href:'modifypwd.jsp?username=<%=request.getParameter("adminname")%>'}]}]}
			];
        
        new PageUtil.MainPage({
            modulesConfig : config
        });
   	 	}else
   	 	{
   	        var config = [
   				{id:'1',homePage :'3',menu:[
   				                            {text:'日常管理',items:
   					[
   					 {id:'3',text:'客户管理',href:'servlet/CustomerServlet?method=getCustomer&userid=<%=request.getParameter("userid")%>'},
   					 {id:'4',text:'销售管理',href:'servlet/OrdermanaServlet?method=getOrdermana&userid=<%=request.getParameter("userid")%>'},
   					{id:'5',text:'客户分析',href:'servlet/OrdermanaServlet?method=getCustomerStat&userid=<%=request.getParameter("userid")%>'}
   					]},
   					{text:'客户服务',items:
   						[{id:'6',text:'反馈管理',href:'servlet/FankuiServlet?method=getFankui&userid=<%=request.getParameter("userid")%>'},
   		   				 {id:'7',text:'投诉管理',href:'servlet/TousuServlet?method=getTousu&userid=<%=request.getParameter("userid")%>'}
   						]}
   				]},
   				{id:'14',homePage :
   				'15',menu:[{text:'系统管理',items:
   				[{id:'15',text:'修改密码',href:'modifypwd.jsp?username=<%=request.getParameter("adminname")%>'}]}]}
   				];
   	        
   	        new PageUtil.MainPage({
   	            modulesConfig : config
   	        });
   	   	 	}
    });
    $(function(){
    	doajax.getUserName($("#userid").val(),callback);
    });
    function callback(data)
    {
    	if($("#yuangongtype").val()=="0")
    	$("#welcome").html(data+"(店长)");
    	else
    		$("#welcome").html(data+"(业务员)");
    }
</script>
</body>
</html>