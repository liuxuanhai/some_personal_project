<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.pojo.Viewspot" %>
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
</head>
<body>
<form action="../servlet/viewspotEditServlet" enctype="multipart/form-data" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<input type="hidden" id="spotid" name="spotid" value="${sessionScope.viewspotmodifyinfo.spotid}"/>
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="15%" class="tableleft">景点名称</td>
        <td><input type="text" id="spotname" name="spotname"  value="${sessionScope.viewspotmodifyinfo.spotname}" class="form-control" /></td>
    </tr>
    <tr>
        <td class="tableleft">景点城市</td>
        <td><input type="text" id="spotcity" name="spotcity" value="${sessionScope.viewspotmodifyinfo.spotcity}" class="form-control"/></td>
    </tr>
    
    <tr>
        <td class="tableleft">详细地址</td>
        <td><input type="text" id="spotaddr" name="spotaddr" value="${sessionScope.viewspotmodifyinfo.spotaddr}" class="form-control"/></td>
    </tr>
	<tr>
        <td class="tableleft">门票(元/张)</td>
        <td><input type="text" id="spotprice" name="spotprice" value="${sessionScope.viewspotmodifyinfo.spotprice}" class="form-control"  onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/></td>
    </tr>
	<tr>
        <td class="tableleft">景点描述</td>
        <td>
        <textarea id="spotdescr" name="spotdescr" class="form-control" rows="5" >
        ${sessionScope.viewspotmodifyinfo.spotdescr}
        </textarea>
        </td>
    </tr>
     <tr>
        <td class="tableleft">备注</td>
        <td>
        <textarea id="spotremark" name="spotremark" class="form-control" rows="2" >
        ${sessionScope.viewspotmodifyinfo.spotremark}
        </textarea>
        </td>
    </tr>
    <tr>
        <td class="tableleft">景点图片</td>
        <td >
	    <input id="fileImage" type="file"  class="form-control popover-image" name="fileselect[]" accept="image/*" multiple />
	    <div id="imagepreview" class="form text-left m20">
		<c:set var="spotimagelist" value="${fn:split(sessionScope.viewspotmodifyinfo.sportimage, '#')}" />
		<c:forEach items="${spotimagelist}" var="spotimage">
			<c:choose>
			       <c:when test="${spotimage!=''}">
			       	<img  src="<%=path %>/upload/${spotimage}" width="300" height="200">
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
				window.location.href="../viewspot.do?method=viewspotFindExecute";
		 });

    });
     
     
	function validate_info(form)  
     {  
         if(form.spotname.value=="")  
         {   
             alert('景点名称不能为空');
             return false;  
         }  
         else if(form.spotcity.value=="")  
         {  
             alert('景点城市不能为空');
             return false;  
         }  
         else if(form.spotaddr.value=="")  
         {  
             alert('景点地址不能为空');
             return false;  
         }  
         else if(form.spotdescr.value=="")  
         {  
             alert('景点描述不能为空');
             return false;  
         }  
         return true;  
     }
</script>
