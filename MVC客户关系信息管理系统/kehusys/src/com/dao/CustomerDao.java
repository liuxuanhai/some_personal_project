package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Customer;
import com.util.DBManager;

public class CustomerDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	public void delete(Integer id) {
		sql="delete from customer where id="+id;
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

	// 获得员工类型
	public String getName(String id)
	{
		sql="select name from customer where id=?";
		String result="";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, new Integer(id));
			rs=ps.executeQuery();
			if(rs.next())
				result=rs.getString("name");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return result;
	}
	
	public Customer getOneById(Integer id) {
		sql="select * from customer where id="+id;
		Customer customer=new Customer();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				customer.setId(rs.getInt("id"));
				customer.setAddr(rs.getString("addr"));
				customer.setAddr(rs.getString("addr"));
				customer.setName(rs.getString("name"));
				customer.setRemark(rs.getString("remark"));
				customer.setPhone(rs.getString("phone"));
				customer.setTotalmoney(rs.getDouble("totalmoney"));
				customer.setYuangongid(rs.getInt("yuangongid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return customer;
	}

	public List<Customer> getAll(String findinfo) {
		sql="select * from customer where name like ? or phone like ?";
		List<Customer> list=new ArrayList<Customer>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			rs=ps.executeQuery();
			while (rs.next()) {
				Customer customer=new Customer();
				customer.setId(rs.getInt("id"));
				customer.setAddr(rs.getString("addr"));
				customer.setAddr(rs.getString("addr"));
				customer.setName(rs.getString("name"));
				customer.setRemark(rs.getString("remark"));
				customer.setPhone(rs.getString("phone"));
				customer.setTotalmoney(rs.getDouble("totalmoney"));
				customer.setYuangongid(rs.getInt("yuangongid"));
				list.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}
	public List<Customer> getAll(String findinfo,String yuangongid) {
		sql="select * from customer where (name like ? or phone like ?) and yuangongid=?";
		List<Customer> list=new ArrayList<Customer>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setInt(3, new Integer(yuangongid));
			rs=ps.executeQuery();
			while (rs.next()) {
				Customer customer=new Customer();
				customer.setId(rs.getInt("id"));
				customer.setAddr(rs.getString("addr"));
				customer.setAddr(rs.getString("addr"));
				customer.setName(rs.getString("name"));
				customer.setRemark(rs.getString("remark"));
				customer.setPhone(rs.getString("phone"));
				customer.setTotalmoney(rs.getDouble("totalmoney"));
				customer.setYuangongid(rs.getInt("yuangongid"));
				list.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}

	public void insert(Customer customer) {
		sql="insert into customer (totalmoney,name,remark,phone,addr,yuangongid) values(?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setDouble(1, customer.getTotalmoney());
			ps.setString(2, customer.getName());
			ps.setString(3, customer.getRemark());
			ps.setString(4, customer.getPhone());
			ps.setString(5, customer.getAddr());
			ps.setInt(6, customer.getYuangongid());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}

	public void update(Customer customer) {
		sql="update customer set totalmoney=?,name=?,remark=?,phone=?,addr=?,yuangongid=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setDouble(1, customer.getTotalmoney());
			ps.setString(2, customer.getName());
			ps.setString(3, customer.getRemark());
			ps.setString(4, customer.getPhone());
			ps.setString(5, customer.getAddr());
			ps.setInt(6, customer.getYuangongid());
			ps.setInt(7, customer.getId());
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
