package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Fankui;
import com.util.DBManager;

public class FankuiDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	public void delete(Integer id) {
		sql="delete from fankui where id="+id;
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

	public Fankui getOneById(Integer id) {
		sql="select * from fankui where id="+id;
		Fankui fankui=new Fankui();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				fankui.setId(rs.getInt("id"));
				fankui.setName(rs.getString("name"));
				fankui.setPersonname(rs.getString("personname"));
				fankui.setContent(rs.getString("content"));
				fankui.setAddtime(rs.getTimestamp("addtime"));
				fankui.setReamrk(rs.getString("remark"));
				fankui.setYuangongid(rs.getInt("yuangongid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return fankui;
	}

	public List<Fankui> getAll(String findinfo) {
		sql="select * from fankui where name like ? or personname like ? or content like ?";
		List<Fankui> list=new ArrayList<Fankui>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setString(3, "%"+findinfo+"%");
			rs=ps.executeQuery();
			while (rs.next()) {
				Fankui fankui=new Fankui();
				fankui.setId(rs.getInt("id"));
				fankui.setName(rs.getString("name"));
				fankui.setPersonname(rs.getString("personname"));
				fankui.setContent(rs.getString("content"));
				fankui.setAddtime(rs.getTimestamp("addtime"));
				fankui.setReamrk(rs.getString("remark"));
				fankui.setYuangongid(rs.getInt("yuangongid"));
				list.add(fankui);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}
	public List<Fankui> getAll(String findinfo,String id) {
		sql="select * from fankui where (name like ? or personname like ? or content like ?) and yuangongid=?";
		List<Fankui> list=new ArrayList<Fankui>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setString(3, "%"+findinfo+"%");
			ps.setInt(4, new Integer(id));
			rs=ps.executeQuery();
			while (rs.next()) {
				Fankui fankui=new Fankui();
				fankui.setId(rs.getInt("id"));
				fankui.setName(rs.getString("name"));
				fankui.setPersonname(rs.getString("personname"));
				fankui.setContent(rs.getString("content"));
				fankui.setAddtime(rs.getTimestamp("addtime"));
				fankui.setReamrk(rs.getString("remark"));
				fankui.setYuangongid(rs.getInt("yuangongid"));
				list.add(fankui);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}

	public void insert(Fankui fankui) {
		sql="insert into fankui (content,name,personname,addtime,remark,yuangongid) values(?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, fankui.getContent());
			ps.setString(2, fankui.getName());
			ps.setString(3, fankui.getPersonname());
			ps.setTimestamp(4, fankui.getAddtime());
			ps.setString(5, fankui.getReamrk());
			ps.setInt(6,fankui.getYuangongid());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}

	public void update(Fankui fankui) {
		sql="update fankui set content=?,name=?,personname=?,remark=?,yuangongid=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, fankui.getContent());
			ps.setString(2, fankui.getName());
			ps.setString(3, fankui.getPersonname());
			ps.setString(4, fankui.getReamrk());
			ps.setInt(5,fankui.getYuangongid());
			ps.setInt(6, fankui.getId());
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
