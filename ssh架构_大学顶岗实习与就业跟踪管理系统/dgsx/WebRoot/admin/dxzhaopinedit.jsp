<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../bootstrap/css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="../ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<form id="addform" action="../dxzhaopin.do?method=dxzhaopinModifyExecute&dxzhaopinid=${sessionScope.dxzhaopinmodifyinfo.id}" method="post" class="definewidth m20" >
<div class="text-center m10"><h3>大型招聘会添加</h3></div>
<div class="m10">
大型招聘会题目
<input type="text" id="title" name="title" class="form-control" value="${sessionScope.dxzhaopinmodifyinfo.title}"/>
</div>
<div  class="m10">
招聘会内容编辑区
<div>
<script id="editor" type="text/plain" style="width:100%;height:300px;" name="content"> ${sessionScope.dxzhaopinmodifyinfo.content}</script>
</div>
</div>
<div class="120">
参与单位
<textarea rows="2" cols="" class="form-control" id="cydw" name="cydw">${sessionScope.dxzhaopinmodifyinfo.cydw}</textarea>
</div>
<div class="text-center m30">
 <button type="button" class="btn btn-primary" onclick="onadd()">保存</button> 
            &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid" >返回列表</button>
</div>
<div class="m30"></div>
<div class="m30"></div>
<div class="m30"></div>
</form>
</body>
</html>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var ue = UE.getEditor('editor');
ue.ready(function() {
    //设置编辑器的内容
    //ue.setContent('');
});
$(function () {       
	$('#backid').click(function(){
			window.location.href="../dxzhaopin.do?method=dxzhaopinFindExecute";
	 });
});	

    function onadd()
    {
    	if($("#title").val()=="")
   		{
    		alert("请输入招聘题目");  
            return; 
   		}
    	if($("#cydw").val()=="")
    	{  
             alert("请输入参与单位名称");  
             return;  
         }  
        if(UE.getEditor('editor').getContent()=="")  
        {  
            alert("请输入招聘会内容");  
            return;  
        }
        $("#addform").submit(); // 添加到数据库中
    }
</script>