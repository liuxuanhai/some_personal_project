package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bean.Orderdetail;
import com.util.DBManager;

public class OrderdetailDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	
	
	    
	    // 删除详单 和订单
	public void delete(String id) {
		sql="delete from orderdetail where id="+id;
		try {
			ps=con.prepareStatement(sql);
			ps.execute();	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}	
	}
	
	// 更新订单总额 和客户消费金额
	public void updateOedermanaTotalPrice(String ordernum)
	{
		sql="select sum(totalprice) as totalprice from orderdetail where ordernum=?";
		double prices=0;
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, ordernum);
			rs=ps.executeQuery();
			if(rs.next())
				prices=rs.getDouble("totalprice");
			sql="update ordermana set totalprice=? where ordernum=?";
			ps=con.prepareStatement(sql);
			ps.setDouble(1, prices);
			ps.setString(2, ordernum);
			ps.executeUpdate(); // 更新
			
			
			//获得订单的客户
			sql="select customerid from ordermana where ordernum=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, ordernum);
			rs=ps.executeQuery();
			int khid=0;
			if(rs.next())
				khid=rs.getInt("customerid");
			sql="select sum(totalprice) as totalprice from ordermana where customerid=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,khid);
			rs=ps.executeQuery();
			if(rs.next())
				prices=rs.getDouble("totalprice");
			sql="update customer set totalmoney=? where id=?";
			ps=con.prepareStatement(sql);
			ps.setDouble(1, prices);
			ps.setInt(2,khid);
			ps.executeUpdate(); // 更新
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
	}

	public Orderdetail getOneById(String id) {
		sql="select * from orderdetail where id="+id;
		Orderdetail order=new Orderdetail();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				order.setOrdernum(rs.getString("ordernum"));
				order.setName(rs.getString("name"));
				order.setId(rs.getInt("id"));
				order.setNums(rs.getInt("nums"));
				order.setPrice(rs.getDouble("price"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setAddtime(rs.getTimestamp("addtime"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return order;
	}
	public Orderdetail getOneByName(String name,String ordernum) {
		sql="select * from orderdetail where name=? and ordernum=?";
		Orderdetail order=null;
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, ordernum);
			rs=ps.executeQuery();
			while (rs.next()) {
				order=new Orderdetail();
				order.setOrdernum(rs.getString("ordernum"));
				order.setName(rs.getString("name"));
				order.setId(rs.getInt("id"));
				order.setNums(rs.getInt("nums"));
				order.setPrice(rs.getDouble("price"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setAddtime(rs.getTimestamp("addtime"));
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return order;
	}

	public List<Orderdetail> getAll(String ordernum) {
		sql="select * from orderdetail where ordernum=?";
		List<Orderdetail> list=new ArrayList<Orderdetail>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, ordernum);
			rs=ps.executeQuery();
			while (rs.next()) {
				Orderdetail order=new Orderdetail();
				order.setOrdernum(rs.getString("ordernum"));
				order.setName(rs.getString("name"));
				order.setId(rs.getInt("id"));
				order.setNums(rs.getInt("nums"));
				order.setPrice(rs.getDouble("price"));
				order.setTotalprice(rs.getDouble("totalprice"));
				order.setRemark(rs.getString("remark"));
				order.setAddtime(rs.getTimestamp("addtime"));
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

	public void insert(Orderdetail order) {
		sql="insert into orderdetail (ordernum,name,price,totalprice,nums,remark,addtime) values(?,?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, order.getOrdernum());
			ps.setString(2, order.getName());
			ps.setDouble(3, order.getPrice());
			ps.setDouble(4, order.getTotalprice());
			ps.setInt(5, order.getNums());
			ps.setString(6,order.getRemark());
			ps.setTimestamp(7, order.getAddtime());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}
	
	

	public void update(Orderdetail order) {
		sql="update orderdetail set ordernum=?,name=?,price=?,totalprice=?,nums=?,remark=?,addtime=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			
			ps.setString(1, order.getOrdernum());
			ps.setString(2, order.getName());
			ps.setDouble(3, order.getPrice());
			ps.setDouble(4, order.getTotalprice());
			ps.setInt(5, order.getNums());
			ps.setString(6,order.getRemark());
			ps.setTimestamp(7, order.getAddtime());
			ps.setInt(8, order.getId());
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
