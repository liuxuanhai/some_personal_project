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
	//��ý�ʦ����
	public String getTeacherName(String id) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from teacher where username='"+id+"'";
		ResultSet rs=db.getResult(sql);
		rs.next();
		return rs.getString("name");
	}
	//���ѧ������
	public String getStudentName(String id) throws SQLException
	{
		DBResult db=new DBResult();
		String sql="select * from student where username='"+id+"'";
		ResultSet rs=db.getResult(sql);
		rs.next();
		return rs.getString("name");
	}
	
	// �޸Ľ�ʦ����
	public void teacherModifyPwd(String id,String pwd)
	{
		DBResult db=new DBResult();
		db.doExecute("update teacher set passwd='"+pwd+"' where teachid='"+id+"'");
		//System.out.println("update teacher set passwd='"+pwd+"' where teachid='"+id+"'");
	}
	
	// �޸�ѧ������
	public void studentModifyPwd(String id,String pwd)
	{
		DBResult db=new DBResult();
		db.doExecute("update student set passwd='"+pwd+"' where stuid='"+id+"'");
	}
	
	//���ÿ���״̬
	public void setKetiStatus(String stuid,String status)
	{
		DBResult db=new DBResult();
		db.doExecute("update keti set status='"+status+"' where stuid='"+stuid+"'");
	}
	
	//���÷���
	public void setScore(String stuid,String score)
	{
		DBResult db=new DBResult();
		db.doExecute("update keti set score="+score+" where stuid='"+stuid+"'");
	}
}
