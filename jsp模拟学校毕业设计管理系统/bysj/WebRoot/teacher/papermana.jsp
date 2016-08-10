<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
String info="";
if(request.getParameter("info")!=null) info=URLDecoder.decode(request.getParameter("info").toString(),"UTF-8");
String str="select keti.*,name from keti left join student on student.stuid=keti.stuid where teachid='"+request.getParameter("teaid").toString()+"' and name like '%"+info+"%'";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
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
	<script type='text/javascript' src='../dwr/interface/login.js'></script>
</head>
<body>
<form class="form-inline definewidth m20" action="#" method="post">    
    
   <input type="hidden" value="<%=request.getParameter("teaid").toString() %>" id="teaid"/>
    <label  for="name">已经与您互选的学生列表</label>
</form>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>毕业题目</th>
        <th>开题报告</th>
        <th>中期报告</th>
        <th>论文草稿</th>
        <th>论文终稿</th>
        <th>综合评分</th>
    </tr>
    </thead>
    <%
    while(rs.next())
    {%>
	    <tr>
		    <td><%=rs.getString("stuid")%></td>
		    <td><%=rs.getString("name")%></td>
		    <td><%=rs.getString("ktname")%></td>
		    <td>
		    <%if(rs.getString("ktpath")==null||rs.getString("ktpath").equals("")){ %>
		    未提交
		    <%}else{ %>
		    <a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("ktpath") %>">查看</a>&nbsp;&nbsp;
		    <a href="../servlet/fileDownloadServlet?filepath=<%=rs.getString("ktpath") %>&stuid=<%=rs.getString("stuid")%>">下载</a>
		    <%} %>
		    </td>
		    <td>
		    <%if(rs.getString("zqpath")==null||rs.getString("zqpath").equals("")){ %>
		    未提交
		    <%}else{ %>
		    <a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("zqpath") %>">查看</a>&nbsp;&nbsp;
		    <a href="../servlet/fileDownloadServlet?filepath=<%=rs.getString("zqpath") %>&stuid=<%=rs.getString("stuid")%>">下载</a>
		    <%} %>
		    </td>
		    <td>
		    <%if(rs.getString("lwpath")==null||rs.getString("lwpath").equals("")){ %>
		    未提交
		    <%}else{ %>
		    <a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("lwpath") %>">查看</a>&nbsp;&nbsp;
		    <a href="../servlet/fileDownloadServlet?filepath=<%=rs.getString("lwpath") %>&stuid=<%=rs.getString("stuid")%>">下载</a>
		    <%} %>
		    </td>
		    <td>
		    <%if(rs.getString("lastlwpath")==null||rs.getString("lastlwpath").equals("")){ %>
		    未提交
		    <%}else{ %>
		    <a target="_blank" href="../pdfjs/web/viewer.html?file=<%=path %>/upload/<%=rs.getString("lastlwpath") %>">查看</a>&nbsp;&nbsp;
		    <a href="../servlet/fileDownloadServlet?filepath=<%=rs.getString("lastlwpath") %>&stuid=<%=rs.getString("stuid")%>">下载</a>
		    <%} %>
		    </td>
		    <td>
		    <%
		    if(rs.getDouble("score")>0){ %>
		    当前得分:<%=rs.getDouble("score") %>&nbsp;&nbsp;
		    <%} %>
		    <a href="#" onclick="onstartpf(this)">评分</a>
		    </td>
	    </tr>
    <%
    }
    rs.close();
    %>
</table>

<!-- 评分确认 -->
<div class="modal fade" id="pfModel">
  <div class="modal-dialog">
    <div class="modal-content message_align">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
        <h4 class="modal-title">综合评分</h4>
      </div>
      <div class="modal-body">
      <input id="pfstuid"value="" type="hidden"/>
       <div class="form form-inline m20">
       学生姓名:<label for="name" id="pfstuname"></label>
       </div>
       <div class="form form-inline m20">
       综合得分:<input type="text" value="" class="form-control" id="defen" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();"/>
       </div>
      </div>
      <div class="modal-footer">
      	 <input type="hidden" id="url"/>
      	 <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
      	 <a  onclick="onPingFen()" class="btn btn-success" data-dismiss="modal">确定</a>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
<script>


// 开始评分
function onstartpf(obj)
{
	
	$("#pfstuid").val(obj.parentNode.parentNode.cells[0].innerHTML);
	$("#pfstuname").text(obj.parentNode.parentNode.cells[1].innerHTML);
	$('#pfModel').modal();  
}
function onPingFen()
{
	if($("#defen").val()=="")
	{
		alert("请输入得分");
		return;
	}
	login.setScore($("#pfstuid").val(),$("#defen").val(),callback);
}
function callback()
{
	window.location.href="papermana.jsp?teaid="+$("#teaid").val();	
}
</script>