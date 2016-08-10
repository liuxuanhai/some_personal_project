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
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <script type="text/javascript" src="../scripts/jquery.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<form action="../servlet/hotelAddServlet" enctype="multipart/form-data" method="post" class="definewidth m20" onsubmit="return validate_info(this);">
<table class="table table-bordered table-hover definewidth m10">
    <tr>
        <td width="15%" class="tableleft">酒店名称</td>
        <td><input type="text" id="hotelname" name="hotelname"  value="" class="form-control" /></td>
    </tr>
    <tr>
        <td class="tableleft">酒店城市</td>
        <td><input type="text" id="hotelcity" name="hotelcity" value="" class="form-control"/></td>
    </tr>
    
    <tr>
        <td class="tableleft">详细地址</td>
        <td><input type="text" id="hoteladdr" name="hoteladdr" value="" class="form-control"/></td>
    </tr>
	<tr>
        <td class="tableleft">预订价格(元/天)</td>
        <td><input type="text" id="hotelprice" name="hotelprice" value="" class="form-control"  onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/></td>
    </tr>
	<tr>
        <td class="tableleft">酒店描述</td>
        <td>
        <textarea id="hoteldescr" name="hoteldescr" class="form-control" rows="5" >
        </textarea>
        </td>
    </tr>
    <tr>
        <td class="tableleft">备注</td>
        <td>
        <textarea id="hotelremark" name="hotelremark" class="form-control" rows="2" >
        </textarea>
        </td>
    </tr>
    <tr>
        <td class="tableleft">酒店图片</td>
        <td >
	    <input id="fileImage" type="file"  class="form-control popover-image" name="fileselect[]" accept="image/*" multiple />
	    <div id="imagepreview" class="form text-left m20">

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
    document.getElementById('imagepreview').innerHTML="";
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
				window.location.href="../hotel.do?method=hotelFindExecute";
		 });

    });
     
     
	function validate_info(form)  
     {  
         if(form.hotelname.value=="")  
         {   
             alert('酒店名称不能为空');
             return false;  
         }  
         else if(form.hotelcity.value=="")  
         {  
             alert('酒店城市不能为空');
             return false;  
         }  
         else if(form.hoteladdr.value=="")  
         {  
             alert('酒店地址不能为空');
             return false;  
         }  
         else if(form.hoteldescr.value=="")  
         {  
             alert('酒店描述不能为空');
             return false;  
         }  
         return true;  
     }
</script>
