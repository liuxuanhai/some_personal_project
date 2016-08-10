package com.login;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.dbconn.DBResult;

public class login {
	public String loginAdmin(String username,String pwd) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from administrator where username='"+username+"'and passwd='"+pwd+"'";
		ResultSet rs=db.getResult(sql);
		if(rs.next())
			return "success";
		else
			return "fail";
	}
	public String loginStudent(String username,String pwd) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from student where username='"+username+"'and passwd='"+pwd+"'";
		ResultSet rs=db.getResult(sql);
		if(rs.next())
			return "success";
		else
			return "fail";
	}
	public String loginTeacher(String username,String pwd) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from teacher where username='"+username+"'and passwd='"+pwd+"'";
		ResultSet rs=db.getResult(sql);
		if(rs.next())
			return "success";
		else
			return "fail";
	}
	//获得教师姓名
	public String getTeacherName(String id) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from teacher where username='"+id+"'";
		ResultSet rs=db.getResult(sql);
		rs.next();
		return rs.getString("name");
	}
	//获得学生姓名
	public String getStudentName(String id) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from student where username='"+id+"'";
		ResultSet rs=db.getResult(sql);
		rs.next();
		return rs.getString("name");
	}
	
	// 修改教师密码
	public void teacherModifyPwd(String id,String pwd)
	{
		DBResult db=new DBResult();
		db.doExecute("update teacher set passwd='"+pwd+"' where teachid='"+id+"'");
		//System.out.println("update teacher set passwd='"+pwd+"' where teachid='"+id+"'");
	}
	
	// 修改学生密码
	public void studentModifyPwd(String id,String pwd)
	{
		DBResult db=new DBResult();
		db.doExecute("update student set passwd='"+pwd+"' where stuid='"+id+"'");
	}
	
	//设置课题状态
	public void setKetiStatus(String stuid,String status)
	{
		DBResult db=new DBResult();
		db.doExecute("update keti set status='"+status+"' where stuid='"+stuid+"'");
	}
	
	//设置分数
	public void setScore(String stuid,String score)
	{
		DBResult db=new DBResult();
		db.doExecute("update keti set score="+score+" where stuid='"+stuid+"'");
	}
}
