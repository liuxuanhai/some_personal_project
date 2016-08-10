<%@ page language="java" import="java.util.*,java.net.URLDecoder" pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.sql.*"%>  
<jsp:useBean id="rst" scope="page" class="com.dbconn.DBResult"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String str="select kttype,ktcome,flag,teachselect.stuid,student.name,keti.ktname,case flag when '0' then '志愿一' when '1' then '志愿二' when '2' then '志愿三' else '已选择' end as zhiyuan from (teachselect  left join student on student.stuid=teachselect.stuid) left join keti on keti.stuid=teachselect.stuid"+
" where (teachid1='"+request.getParameter("teaid").toString()+"' and flag='0') or (teachid2='"+request.getParameter("teaid").toString()+"' and flag='1') or (teachid3='"+request.getParameter("teaid").toString()+"' and flag='2') or (flag='3' and (teachid3='"+
		request.getParameter("teaid").toString()+"' or teachid1='"+request.getParameter("teaid").toString()+"' or teachid2='"+
				request.getParameter("teaid").toString()+"'))";
ResultSet rs=rst.getResult(str);//执行SQL语句获得结果集对象
//System.out.println(str);
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
<form class="form-inline definewidth m20" action="#" method="post">    
    
    <label  for="name">已经选择您为导师的学生列表</label>
</form>
<input type="hidden" value="<%=request.getParameter("teaid").toString() %>" id="teaid"/>
<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>课题</th>
        <th>课题类型</th>
        <th>课题来源</th>
        <th>志愿</th>
        <th>操作</th>
    </tr>
    </thead>
    <%
    while(rs.next())
    {%>
	    <tr>
		    <td><%=rs.getString("stuid")%></td>
		    <td><%=rs.getString("name")%></td>
		     <td><%=rs.getString("ktname")%></td>
		      <td><%=rs.getString("kttype")%></td>
		       <td><%=rs.getString("ktcome")%></td>
		    <td><%=rs.getString("zhiyuan")%></td>
		    <td><%if(!rs.getString("flag").equals("3")) {%>
		    <a href="stuchoice.jsp?teaid=<%=request.getParameter("teaid").toString() %>&stuid=<%=rs.getString("stuid")%>&yesorno=yes">同意</a>&nbsp;&nbsp;
		    <a href="stuchoice.jsp?teaid=<%=request.getParameter("teaid").toString() %>&stuid=<%=rs.getString("stuid")%>&yesorno=no">拒绝</a>
		    <%} else{%>
		    <a href="taskreseale.jsp?teaid=<%=request.getParameter("teaid").toString() %>&stuid=<%=rs.getString("stuid")%>">任务书管理</a>
		    <%} %>
		    </td>
	    </tr>
    <%
    }
    rs.close();
    %>
</table>
</body>
</html>
<script>

</script>