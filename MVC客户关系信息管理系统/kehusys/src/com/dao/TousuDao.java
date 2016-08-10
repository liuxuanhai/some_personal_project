package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Tousu;
import com.util.DBManager;

public class TousuDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	public void delete(Integer id) {
		sql="delete from tousu where id="+id;
		try {
			ps=con.prepareStatement(sql);
			ps.execute();
			try {
			ps=con.prepareStatement(sql);
			ps.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}	
	}

	public Tousu getOneById(Integer id) {
		sql="select * from tousu where id="+id;
		Tousu tousu=new Tousu();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				tousu.setId(rs.getInt("id"));
				tousu.setName(rs.getString("name"));
				tousu.setPersonname(rs.getString("personname"));
				tousu.setContent(rs.getString("content"));
				tousu.setAddtime(rs.getTimestamp("addtime"));
				tousu.setReamrk(rs.getString("remark"));
				tousu.setYuangongid(rs.getInt("yuangongid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return tousu;
	}

	public List<Tousu> getAll(String findinfo) {
		sql="select * from tousu where name like ? or personname like ? or content like ?";
		List<Tousu> list=new ArrayList<Tousu>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setString(3, "%"+findinfo+"%");
			rs=ps.executeQuery();
			while (rs.next()) {
				Tousu tousu=new Tousu();
				tousu.setId(rs.getInt("id"));
				tousu.setName(rs.getString("name"));
				tousu.setPersonname(rs.getString("personname"));
				tousu.setContent(rs.getString("content"));
				tousu.setAddtime(rs.getTimestamp("addtime"));
				tousu.setReamrk(rs.getString("remark"));
				tousu.setYuangongid(rs.getInt("yuangongid"));
				list.add(tousu);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}
	
	public List<Tousu> getAll(String findinfo,String id) {
		sql="select * from tousu where (name like ? or personname like ? or content like ?) and yuangongid=?";
		List<Tousu> list=new ArrayList<Tousu>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setString(3, "%"+findinfo+"%");
			ps.setInt(4, new Integer(id));
			rs=ps.executeQuery();
			while (rs.next()) {
				Tousu tousu=new Tousu();
				tousu.setId(rs.getInt("id"));
				tousu.setName(rs.getString("name"));
				tousu.setPersonname(rs.getString("personname"));
				tousu.setContent(rs.getString("content"));
				tousu.setAddtime(rs.getTimestamp("addtime"));
				tousu.setReamrk(rs.getString("remark"));
				tousu.setYuangongid(rs.getInt("yuangongid"));
				list.add(tousu);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}

	public void insert(Tousu tousu) {
		sql="insert into tousu (content,name,personname,addtime,remark,yuangongid) values(?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, tousu.getContent());
			ps.setString(2, tousu.getName());
			ps.setString(3, tousu.getPersonname());
			ps.setTimestamp(4, tousu.getAddtime());
			ps.setString(5, tousu.getReamrk());
			ps.setInt(6,tousu.getYuangongid());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}

	public void update(Tousu tousu) {
		sql="update tousu set content=?,name=?,personname=?,remark=?,yuangongid=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, tousu.getContent());
			ps.setString(2, tousu.getName());
			ps.setString(3, tousu.getPersonname());
			ps.setString(4, tousu.getReamrk());
			ps.setInt(5,tousu.getYuangongid());
			ps.setInt(6, tousu.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}

	}
	private void close(){
		try{
			if(rs!=null){
				rs.close();
			}
			if(ps!=null){
				ps.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
			System.out.println("---------------------关闭rs，ps，con出现异常--------------------");
		}
	
	}

}
