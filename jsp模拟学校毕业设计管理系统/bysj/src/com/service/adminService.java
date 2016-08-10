package com.service;

import java.sql.PreparedStatement;

import com.dbconn.DBResult;
import com.info.adminBean;


public class adminService {
	private adminBean admininfo;
	  DBResult rst=new DBResult();

	// Ìí¼Ó
	public void add()throws Exception
	  {
	    String sql="insert into administrator(username,passwd) values(?,?)";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,admininfo.getUsername());
	      pstmt.setString(2,admininfo.getPsswd());
	     
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
	    String sql="update administrator set username=?,passwd=? where adminid=?";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,admininfo.getUsername());
	      pstmt.setString(2,admininfo.getPsswd());
	      pstmt.setString(3,admininfo.getAdminid());
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
	    String sql="delete from administrator where adminid=?";
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
	public adminBean getAdmininfo() {
		return admininfo;
	}

	public void setAdmininfo(adminBean admininfo) {
		this.admininfo = admininfo;
	} 
}
