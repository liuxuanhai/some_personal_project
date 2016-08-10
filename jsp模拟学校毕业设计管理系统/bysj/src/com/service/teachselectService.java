package com.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dbconn.DBResult;
import com.info.teachselectBean;


public class teachselectService {
	private teachselectBean teachselectinfo;
	  DBResult rst=new DBResult();
	 
	  public void update() throws SQLException, Exception
	  {
		  String sql="select * from teachselect where stuid='"+teachselectinfo.getStuid()+"'";
		 // System.out.println(sql);
		  if(rst.getResult(sql).next())
			  modify();
		  else
			  add();
	  }
	// 添加
	public void add()throws Exception
	  {
	    String sql="insert into teachselect(stuid,teachid1,teachid2,teachid3,status,flag) values(?,?,?,?,?,?)";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,teachselectinfo.getStuid());
	      pstmt.setString(2,teachselectinfo.getTeachid1());
	      pstmt.setString(3,teachselectinfo.getTeachid2());
	      pstmt.setString(4,teachselectinfo.getTeachid3());
	      pstmt.setString(5,"已提交");
	      pstmt.setString(6,"0");
	      pstmt.executeUpdate();
	    }
	    catch(Exception e)
	    {
	      e.printStackTrace();
	      throw e;
	    }
	  }
	//更新 
	public void modify()throws Exception
  {
    String sql="update teachselect set teachid1=?,teachid2=?,teachid3=? where stuid=?";
    try
    {
      PreparedStatement pstmt=rst.getPreparedStatement(sql);
      pstmt.setString(1,teachselectinfo.getTeachid1());
      pstmt.setString(2,teachselectinfo.getTeachid2());
      pstmt.setString(3,teachselectinfo.getTeachid3());
      pstmt.setString(4,teachselectinfo.getStuid());
      pstmt.executeUpdate();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      throw e;
    }
  }
	public teachselectBean getStudentinfo() {
		return teachselectinfo;
	}
	public void setStudentinfo(teachselectBean teachselectinfo) {
		this.teachselectinfo = teachselectinfo;
	}
}
