package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bean.Ordermana;
import com.util.DBManager;

public class OrdermanaDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	    
	    // 删除详单 和订单
	public void delete(String id) {
		sql="delete from ordermana where ordernum="+id;
		try {
			ps=con.prepareStatement(sql);
			ps.execute();
			sql="delete from orderdetail where ordernum="+id;
			ps=con.prepareStatement(sql);
			ps.execute();
	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}	
	}

	public Ordermana getOneById(String id) {
		sql="select * from ordermana where ordernum="+id;
		Ordermana order=new Ordermana();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				order.setOrdernum(rs.getString("ordernum"));
				order.setCustomerid(rs.getInt("customerid"));
				order.setYuangongid(rs.getInt("yuangongid"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setOrdertime(rs.getTimestamp("ordertime"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return order;
	}

	public List<Ordermana> getAll(Timestamp t1,Timestamp t2) {
		sql="select * from ordermana where ordertime between ? and ?";
		List<Ordermana> list=new ArrayList<Ordermana>();
		try {
			ps=con.prepareStatement(sql);
			ps.setTimestamp(1, t1);
			ps.setTimestamp(2, t2);
			rs=ps.executeQuery();
			while (rs.next()) {
				Ordermana order=new Ordermana();
				order.setOrdernum(rs.getString("ordernum"));
				order.setCustomerid(rs.getInt("customerid"));
				order.setYuangongid(rs.getInt("yuangongid"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setOrdertime(rs.getTimestamp("ordertime"));
				list.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}
	public List<Ordermana> getAll(Timestamp t1,Timestamp t2,String yuangongid) {
		sql="select * from ordermana where ordertime between ? and ? and yuangongid=?";
		List<Ordermana> list=new ArrayList<Ordermana>();
		try {
			ps=con.prepareStatement(sql);
			ps.setTimestamp(1, t1);
			ps.setTimestamp(2, t2);
			ps.setInt(3, new Integer(yuangongid));
			rs=ps.executeQuery();
			while (rs.next()) {
				Ordermana order=new Ordermana();
				order.setOrdernum(rs.getString("ordernum"));
				order.setCustomerid(rs.getInt("customerid"));
				order.setYuangongid(rs.getInt("yuangongid"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setOrdertime(rs.getTimestamp("ordertime"));
				list.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}

	public List<Ordermana> getCustomerOrder(Timestamp t1,Timestamp t2,String customerid) {
		sql="select * from ordermana where ordertime between ? and ? and customerid=?";
		List<Ordermana> list=new ArrayList<Ordermana>();
		try {
			ps=con.prepareStatement(sql);
			ps.setTimestamp(1, t1);
			ps.setTimestamp(2, t2);
			ps.setInt(3, new Integer(customerid));
			rs=ps.executeQuery();
			while (rs.next()) {
				Ordermana order=new Ordermana();
				order.setOrdernum(rs.getString("ordernum"));
				order.setCustomerid(rs.getInt("customerid"));
				order.setYuangongid(rs.getInt("yuangongid"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setOrdertime(rs.getTimestamp("ordertime"));
				list.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}
	
	public void insert(Ordermana order) {
		sql="insert into ordermana (ordernum,customerid,yuangongid,totalprice,ordertime,remark) values(?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, order.getOrdernum());
			ps.setInt(2, order.getCustomerid());
			ps.setInt(3, order.getYuangongid());
			ps.setDouble(4, order.getTotalprice());
			ps.setTimestamp(5, order.getOrdertime());
			ps.setString(6,order.getRemark());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}

	public void update(Ordermana order) {
		sql="update ordermana set customerid=?,yuangongid=?,totalprice=?,ordertime=?,remark=? where ordernum=?";
		try {
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, order.getCustomerid());
			ps.setInt(2, order.getYuangongid());
			ps.setDouble(3, order.getTotalprice());
			ps.setTimestamp(4, order.getOrdertime());
			ps.setString(5,order.getRemark());
			ps.setString(6, order.getOrdernum());
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
