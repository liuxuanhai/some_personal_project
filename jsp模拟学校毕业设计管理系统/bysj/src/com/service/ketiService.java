package com.service;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dbconn.DBResult;
import com.info.ketiBean;


public class ketiService {
	private ketiBean ketiinfo;
	  DBResult rst=new DBResult();
	 
	  public void update() throws SQLException, Exception
	  {
		  String sql="select * from keti where stuid='"+ketiinfo.getStuid()+"'";
		 // System.out.println(sql);
		  if(rst.getResult(sql).next())
			  modify();
		  else
			  add();
	  }
	// 添加
	public void add()throws Exception
	  {
	    String sql="insert into keti values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    try
	    {
	      PreparedStatement pstmt=rst.getPreparedStatement(sql);
	      pstmt.setString(1,ketiinfo.getKtname());
	      pstmt.setString(2,ketiinfo.getKttype());
	      pstmt.setString(3,ketiinfo.getKtcome());
	      pstmt.setString(4,ketiinfo.getKtdescr());
	      pstmt.setString(5,ketiinfo.getStuid());
	      pstmt.setString(6,"0");
	      pstmt.setString(7,"");  //导师
	      pstmt.setString(8,"");
	      pstmt.setString(9,"");
	      pstmt.setString(10,"");
	      pstmt.setString(11,"");
	      pstmt.setString(12,"");
	      pstmt.setString(13,"0");
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
    String sql="update keti set ktname=?,kttype=?,ktcome=?,ktdescr=?,status='0' where stuid=?";
    try
    {
      PreparedStatement pstmt=rst.getPreparedStatement(sql);
      pstmt.setString(1,ketiinfo.getKtname());
      pstmt.setString(2,ketiinfo.getKttype());
      pstmt.setString(3,ketiinfo.getKtcome());
      pstmt.setString(4,ketiinfo.getKtdescr());
      pstmt.setString(5,ketiinfo.getStuid());
      pstmt.executeUpdate();
    }
    catch(Exception e)
    {
      e.printStackTrace();
      throw e;
    }
  }
	public ketiBean getStudentinfo() {
		return ketiinfo;
	}
	public void setStudentinfo(ketiBean ketiinfo) {
		this.ketiinfo = ketiinfo;
	}
}
