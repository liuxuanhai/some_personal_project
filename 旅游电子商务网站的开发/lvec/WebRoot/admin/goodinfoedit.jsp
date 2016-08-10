<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Goodinfo" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
        <script type='text/javascript' src='../dwr/util.js'></script>
	<script type='text/javascript' src='../dwr/engine.js'></script>
	<script type='text/javascript' src='../dwr/interface/goodtype.js'></script>
</head>
<body>
<input type="hidden" value="${sessionScope.goodinfomodifyinfo.typeid}" id="goodtypeid"/>
<form action="../servlet/goodinfoEditServlet" enctype="multipart/form-data" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<input type="hidden" value="${sessionScope.goodinfomodifyinfo.goodid}" id="goodid" name="goodid"/>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="15%" class="tableleft">所属类别</td>
        <td>
		<select id="typeid" name="typeid" class="form-control">
		</select>
		</td>
    </tr>
    <tr>
        <td class="tableleft">产品名称</td>
        <td><input type="text" id="goodname" name="goodname" value="${sessionScope.goodinfomodifyinfo.goodname}" class="form-control"/></td>
    </tr>
    
    <tr>
        <td class="tableleft">产品描述</td>
        <td>
        <textarea rows="3" id="gooddescr" name="gooddescr" cols="" class="form-control">
        ${sessionScope.goodinfomodifyinfo.gooddescr}
        </textarea>
        </td>
    </tr>
	<tr>
        <td class="tableleft">产品单价(元)</td>
        <td><input type="text" id="goodprice" name="goodprice" value="${sessionScope.goodinfomodifyinfo.goodprice}" class="form-control"  onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/></td>
    </tr>
	<tr>
        <td class="tableleft">库存量</td>
        <td>
        <input type="text" id="goodnum" name="goodnum" value="${sessionScope.goodinfomodifyinfo.goodnum}" class="form-control"  onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
        </td>
    </tr>
    <tr>
        <td class="tableleft">产品图片</td>
        <td >
	    <input id="fileImage" type="file"  class="form-control popover-image" name="fileselect[]" accept="image/*" multiple />
	    <div id="imagepreview" class="form text-left m20">
			
			<c:set var="goodimagelist" value="${fn:split(sessionScope.goodinfomodifyinfo.goodimage, '#')}" />
			<c:forEach items="${goodimagelist}" var="goodimage">
				<c:choose>
				       <c:when test="${goodimage!=''}">
				       	<img  src="<%=path %>/upload/${goodimage}" width="300" height="200">
				       </c:when>
				       <c:otherwise>
				       </c:otherwise>
				</c:choose>
			</c:forEach>
	    </div>
	    
        </td>
    </tr>
    <tr>
        <td class="tableleft"></td>
        <td>
            <button type="submit" class="btn btn-primary " type="button">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
document.getElementById('fileImage').onchange = function(evt) {
    // 如果浏览器不支持FileReader，则不处理
    if (!window.FileReader) return;
    var files = evt.target.files;
    //document.getElementById('imagepreview').innerHTML="";
    for (var i = 0, f; f = files[i]; i++) {
        if (!f.type.match('image.*')) {
            continue;
        }
        
        var reader = new FileReader();
        reader.onload = (function(theFile) {
            return function(e) {
                // img 元素
                var img = document.createElement("img"); 
                img.src=e.target.result;
                img.setAttribute("class", "img-thumbnail");
                img.setAttribute("width", "300");
                img.setAttribute("height", "200");
                document.getElementById('imagepreview').appendChild(img); 
            };
        })(f);
        reader.readAsDataURL(f);
    }
}

    $(function () {       
		$('#backid').click(function(){
				window.location.href="../goodinfo.do?method=goodinfoFindExecute";
		 });
		 goodtype.getGoodType(gettypecallback);  //获得产品类别
    });
    // 产品类别
    function gettypecallback(data)
    {
    	for(var i=0;i<data.length;++i)
    	 	$("#typeid").append("<option value='"+data[i][0]+"'>"+data[i][1]+"</option>");
    	$("#typeid").val($('#goodtypeid').val());
    }
     
	function validate_info(form)  
     {  
     	if($("#typeid").val()=="")
     	{
     		alert('产品类别不能为空');return false;
     	}
         if(form.goodname.value=="")  
         {   
             alert('产品名称不能为空');
             return false;  
         }  
         else if(form.gooddescr.value=="")  
         {  
             alert('产品描述不能为空');
             return false;  
         }  
         else if(form.goodprice.value=="")  
         {  
             alert('产品单价不能为空');
             return false;  
         }  
         else if(form.goodnum.value=="")  
         {  
             alert('产品库存不能为空');
             return false;  
         }  
         return true;  
     }
</script>
