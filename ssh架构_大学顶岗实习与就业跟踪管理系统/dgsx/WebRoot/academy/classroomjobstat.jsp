<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title>院系就业统计信息</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    
    <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/student.js'></script>
	
	<link rel="stylesheet" type="text/css" href="../css/resultstyle.css" />
	<script src="../js/highcharts.js"></script>
	<script src="../js/modules/data.js"></script>
	<script src="../js/modules/drilldown.js"></script>
	<script src="../js/modules/exporting.js"></script>
</head>
<body>
<div class="container m20 text-right">
	<form id="formadd" class="form-inline form-group definewidth m20" action="#" method="post">  
	<input type="hidden" value="${sessionScope.classroom.academy.academyid}" id="academyid"/>
	<input type="hidden" value="${sessionScope.classroom.classid}" id="classid"/>
	<a  class="btn btn-primary" href="../student.do?method=classJobsFindByAcademyIDExecute&academyid=${sessionScope.classroom.academy.academyid}">返回列表</a>&nbsp;&nbsp;
    <button type="button" class="btn btn-success" onclick="exportPdf()">打印pdf</button>
	</form>
</div>
<!--startprint-->
<div class="container m10" style="min-width: 310px; height: 100px; margin: 0 auto" id="classJobsdiv">
	   <table class="table table-bordered table-hover definewidth m10" id="classJobs" >
	   <caption class="m10 text-center"><h2><span id="academyname">${sessionScope.classroom.academy.academyname}</span>&nbsp;&nbsp;<span id="classname">${sessionScope.classroom.classname}</span>就业统计表</h2>
	    </caption>
		</table>
 </div> <!-- /container -->
    <br><br>
<div id="containerClassroomJobs" class="container m30" style="min-width: 310px; height: 500px; margin: 0 auto"></div>
<!--endprint-->
</body>
</html>
<script>
// 页面的DOM加载完后执行这些ajax异步获取数据
$(function(){
	 	 student.getClassJobsStat($("#classid").val(),getClassJobsStatCallback); //获得工作统计
	});
function getClassJobsStatCallback(obj)
{
	 //下面生成表格
	 var table=document.getElementById("classJobs");
	 var newrow,newcell;
	 newrow=table.insertRow(-1);
	 newcell=newrow.insertCell(-1);
     newcell.innerHTML="去向类型";
    
     newcell=newrow.insertCell(-1);
     newcell.innerHTML="人数统计";
	 for(var i=0;i<obj.length;++i)
   	 {
   	    newrow=table.insertRow(-1);
    	newcell=newrow.insertCell(-1);
    	newcell.innerHTML=obj[i][0];
		newcell=newrow.insertCell(-1);
    	newcell.innerHTML=obj[i][1];
   	 }
	 document.getElementById("classJobsdiv").style.height=table.style.height;
	 
	 //下面新建统计表
	 var options = {
			 chart : {
			     renderTo : 'containerClassroomJobs',
			     type : 'column',
			     },
			title:{
			    text:$("#academyname").html()+"   "+$("#classname").html()+"就业统计图",
			    style:{
			    	color:"#999",
			    	fontSize: '30px'
			    }
			},
			subtitle:{
				 useHTML:true,
				 text:''
		 	},
			xAxis: {
				type: 'category',
				title:{
	                text: '就业类型',
	                style:{
	   			    	fontSize: '15px'
	   			 	}
	        	},
	        },
	        yAxis:{
	        	title:{
	                text: '人数统计',
	                style:{
	   			    	fontSize: '15px'
	   			 	}
	        	},
	        },
	        legend: {
	            enabled: false
	        },
	        //plotOptions:plotOptions1,
	        tooltip: {
	        	enabled :false,
	        },
	        series: [],
			credits:{
				 enabled:false//不显示highCharts版权信息
				},
			exporting:
			{
				filename:"classroomjobstat",
			}	
		};
	 var data=new Array();
	 for(var i=0;i<obj.length;++i)
	 {
		 var n=i+1;
		 var ques={
					"name":obj[i][0],
				 	"y":parseInt(obj[i][1]),
				 };
		 data.push(ques);
	 }
	 var myseries={
			 "colorByPoint": true,
			 "data":data,
			 "dataLabels":{
    			 enabled: true,
                 format: '{point.y}人' 
    	 	}
	 }
	 options.series.push(myseries);
	 var chartQuestionStat=new Highcharts.Chart(options);
}


//下面是问题统计模型的生成
Highcharts.setOptions({ // 全局语言设置
   lang:{
      contextButtonTitle:"图表导出菜单",
      decimalPoint:".",
      downloadJPEG:"下载JPEG图片",
      downloadPDF:"下载PDF文件",
      downloadPNG:"下载PNG文件",
      downloadSVG:"下载SVG文件",
      drillUpText:"返回 {series.name}",
      loading:"加载中",
      months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
      noData:"没有数据",
      numericSymbols: [ "千" , "兆" , "G" , "T" , "P" , "E"],
      printChart:"打印图表",
      resetZoom:"恢复缩放",
      resetZoomTitle:"恢复图表",
      shortMonths: [ "Jan" , "Feb" , "Mar" , "Apr" , "May" , "Jun" , "Jul" , "Aug" , "Sep" , "Oct" , "Nov" , "Dec"],
      thousandsSep:",",
      weekdays: ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六","星期天"]
   }
});


// 导出为pdf
function exportPdf() {  
	 
	 //window.print();    
	 bdhtml=window.document.body.innerHTML;  
    sprnstr="<!--startprint-->";  
    eprnstr="<!--endprint-->";  
    prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+17);  
    prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));  
    window.document.body.innerHTML=prnhtml;  
    window.print();
    window.history.go(0);   // 回到原来网页
} 
</script>