package com.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dbconn.DBResult;
import com.info.studentBean;


public class studentService {
	private studentBean studentinfo;
	  DBResult rst=new DBResult();
	public boolean isexist() throws SQLException
	{
		String sql="select * from student where stuid='"+studentinfo.getStuid()+"'";
		if(rst.getResult(sql).next())
			return true;
		else
			return false;
	}
	// Ìí¼Ó
	public void add()throws Exception
	  {
	    String sql="insert into student values(?,?,?,?,?,?,?)";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,studentinfo.getStuid());
	      pstmt.setString(2,studentinfo.getStuid());
	      pstmt.setString(3,studentinfo.getStuid());
	      pstmt.setString(4,studentinfo.getName());
	      pstmt.setString(5,studentinfo.getSex());
	      pstmt.setString(6,"");
	      pstmt.setString(7,studentinfo.getCls());
	      pstmt.executeUpdate();
	    }
	    catch(Exception e)
	    {
	      e.printStackTrace();
	      throw e;
	    }
	  }
	//¸üÐÂ 
	public void modify()throws Exception
	  {
	    String sql="update student set name=?,gender=?,cls=? where stuid=?";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,studentinfo.getName());
	      pstmt.setString(2,studentinfo.getSex());
	      pstmt.setString(3,studentinfo.getCls());
	      pstmt.setString(4,studentinfo.getStuid());
	      pstmt.executeUpdate();
	    }
	    catch(Exception e)
	    {
	      e.printStackTrace();
	      throw e;
	    }
	  }
	// É¾³ý
	public void delete(String id)throws Exception
	  {
	    String sql="delete from student where stuid=?";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,id);
	      pstmt.executeUpdate();
	    }
	    catch(Exception e)
	    {
	      e.printStackTrace();
	      throw e;
	    }
	  }
	public studentBean getStudentinfo() {
		return studentinfo;
	}
	public void setStudentinfo(studentBean studentinfo) {
		this.studentinfo = studentinfo;
	}
}
