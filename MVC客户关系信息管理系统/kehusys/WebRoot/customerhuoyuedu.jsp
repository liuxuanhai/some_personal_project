<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=path %>/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=path %>/css/style.css" />
    <script type="text/javascript" src="<%=path %>/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path %>/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="<%=path %>/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
	<script src="<%=path %>/js/highcharts.js"></script>
	<script src="<%=path %>/js/modules/data.js"></script>
	<script src="<%=path %>/js/modules/drilldown.js"></script>
	<script src="<%=path %>/js/modules/exporting.js"></script>
</head>
<body>
<div class="container m20">
	<form class="form-inline definewidth m20" action="<%=path %>/servlet/OrdermanaServlet?method=getCustomerStat" method="post">    
	<input class="hide" id="userid" name="userid" value="${requestScope.userid}"/>
	    <input type="text" id="starttime" name="starttime" placeholder="2016-5-1" value="${requestScope.starttime}" readonly class="form_datetime form-control"/>
	     	至
	     	<input type="text" id="endtime" name="endtime" placeholder="2016-5-1" value="${requestScope.endtime}" readonly class="form_datetime form-control"/>
	    <button type="submit" class="btn btn-primary" id="findbtn">统计分析</button>&nbsp;&nbsp;
	    <button type="button" class="btn btn-success" onclick="exportPdf()">打印</button>
	</form>
	<!--startprint-->
	<table class="table table-bordered table-hover definewidth m10" id="kehutable">
	<caption class="text-center"><h2>表格统计</h2></caption>
	    <thead>
	    <tr>
	        <th>客户id</th>
	        <th>客户姓名</th>
	        <th>联系方式</th>
	        <th>消费次数</th>
	        <th>消费金额</th>
	        <th>负责员工</th>
	        <th>活跃级别</th>
	    </tr>
	    </thead>
	        <c:forEach items="${requestScope.customerlist}" var="customer">
	        <tr>
	        	<td><c:out value="${customer.id}"/></td>
				<td><c:out value="${customer.name}"/></td>
				<td><c:out value="${customer.phone}"/></td>
				<td><c:out value="${customer.huoyuedu}"/></td>
				<td><c:out value="${customer.totalmoney}"/></td>
				<td><c:out value="${customer.ygname}"/></td>
				<td>
					<c:choose>
						<c:when test="${customer.huoyuedu<4 }">临时</c:when>
						<c:when test="${customer.huoyuedu<10 }">一般</c:when>
						<c:otherwise>稳定</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
	</table>
</div>

<div class="m20">
</div>
<div id="customerhuoyuedu" class="container m30" style="min-width: 310px; height: 500px; margin: 0 auto"></div>

<div class="m20">
</div>
<div id="customercontribute" class="container m30" style="min-width: 310px; height: 500px; margin: 0 auto"></div>




<!--endprint-->
</body>
</html>
<script>
//时间控件初始化
//时间控件初始化
$(".form_datetime").datetimepicker({
	language:  'zh-CN',
	format: 'yyyy-mm-dd',
	autoclose: true,
	weekStart: 1,
    todayBtn:  1,
    todayHighlight: 1,
    minView:3
	});
	

//页面的DOM加载完后执行这些ajax异步获取数据
$(function(){
		huoyueduStat();
});
function huoyueduStat()
{
	 //下面新建统计表
	 var options1 = {
			 chart : {
			     renderTo : 'customercontribute',
			     type : 'column',
			     },
			title:{
			    text:"客户贡献分析",
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
	                text: '客户姓名',
	                style:{
	   			    	fontSize: '15px'
	   			 	}
	        	},
	        },
	        yAxis:{
	        	title:{
	                text: '贡献金额',
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
				filename:"customercontribute",
			}	
		};
	 
	
	 var options2 = {
			 chart : {
			     renderTo : 'customerhuoyuedu',
			     type : 'column',
			     },
			title:{
			    text:"客户活跃度分析",
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
	                text: '客户姓名',
	                style:{
	   			    	fontSize: '15px'
	   			 	}
	        	},
	        },
	        yAxis:{
	        	title:{
	                text: '活跃次数',
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
				filename:"customercontribute",
			}	
		};
	 
	 //下面提取数据
	 var table=document.getElementById("kehutable");
	 var data1=new Array();
	 var data2=new Array();
	 for(var i=1;i<table.rows.length;++i)
	 {
		 var ques1={
					"name":table.rows[i].cells[1].innerHTML,
				 	"y":parseFloat(table.rows[i].cells[4].innerHTML),
				 };
		 data1.push(ques1);
		 var ques2={
					"name":table.rows[i].cells[1].innerHTML,
				 	"y":parseFloat(table.rows[i].cells[3].innerHTML),
				 };
		 data2.push(ques2);
	 }
	 var myseries1={
			 "colorByPoint": true,
			 "data":data1,
			 "dataLabels":{
    			 enabled: true,
                 format: '{point.y}元' 
    	 	}
	 }
	 options1.series.push(myseries1);
	 var chartQuestionStat1=new Highcharts.Chart(options1); 
	 
	 
	 var myseries2={
			 "colorByPoint": true,
			 "data":data2,
			 "dataLabels":{
    			 enabled: true,
                 format: '{point.y}次' 
    	 	}
	 }
	 options2.series.push(myseries2);
	 var chartQuestionStat2=new Highcharts.Chart(options2);
}


//导出为pdf
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
</script>