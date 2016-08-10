package com.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dbconn.DBResult;
import com.info.teacherBean;


public class teacherService {
	private teacherBean teacherinfo;
	  DBResult rst=new DBResult();
	public boolean isexist() throws SQLException
	{
		String sql="select * from teacher where teachid='"+teacherinfo.getTeacherid()+"'";
		if(rst.getResult(sql).next())
			return true;
		else
			return false;
	}
	// Ìí¼Ó
	public void add()throws Exception
	  {
	    String sql="insert into teacher values(?,?,?,?,?,?,?)";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,teacherinfo.getTeacherid());
	      pstmt.setString(2,teacherinfo.getTeacherid());
	      pstmt.setString(3,teacherinfo.getTeacherid());
	      pstmt.setString(4,teacherinfo.getName());
	      pstmt.setString(5,teacherinfo.getGender());
	      pstmt.setString(6,"");
	      pstmt.setString(7,teacherinfo.getSubject());
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
	    String sql="update teacher set name=?,gender=?,subject=? where teachid=?";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,teacherinfo.getName());
	      pstmt.setString(2,teacherinfo.getGender());
	      pstmt.setString(3,teacherinfo.getSubject());
	      pstmt.setString(4,teacherinfo.getTeacherid());
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
	    String sql="delete from teacher where teachid=?";
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
	public teacherBean getTeacherinfo() {
		return teacherinfo;
	}
	public void setTeacherinfo(teacherBean teacherinfo) {
		this.teacherinfo = teacherinfo;
	}
}
