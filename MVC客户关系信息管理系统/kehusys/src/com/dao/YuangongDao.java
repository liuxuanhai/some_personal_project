package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.bean.Yuangong;
import com.util.DBManager;

public class YuangongDao {
	
	Connection con=DBManager.getDBManager().connection;
	    PreparedStatement ps=null;
	    ResultSet rs=null;
	    String sql=null;
	    //修改密码
	    public void modifypwd(String username,String pwd)
	    {
	    	sql="update yuangong set pwd=? where username=?";
	    	try {
				ps=con.prepareStatement(sql);
				ps.setString(1, pwd);
				ps.setString(2, username);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally{
				close();
			}		
	    }
	    
	   //登录
	    public String login(String username, String password,String type) {
			sql="select * from yuangong where username=? and pwd=? and type=?";
			String result="fail";
			try {
				ps=con.prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);
				ps.setString(3, type);
				rs=ps.executeQuery();
				if(rs.next())
					result=String.valueOf(rs.getInt("id"));
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			finally{
				close();
			}
			return result;
		}
	// 获得员工类型
	public String getType(String id)
	{
		sql="select type from yuangong where id=?";
		String result="1";
		try {
			ps=con.prepareStatement(sql);
			ps.setInt(1, new Integer(id));
			rs=ps.executeQuery();
			if(rs.next())
				result=rs.getString("type");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return result;
	}
	
	// 获得员工类型
	public String getName(String id)
	{
		sql="select name from yuangong where id=?";
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
		
	public void delete(Integer id) {
		sql="delete from yuangong where id="+id;
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

	public Yuangong getOneById(Integer id) {
		sql="select * from yuangong where id="+id;
		Yuangong yuangong=new Yuangong();
		try {
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			while (rs.next()) {
				yuangong.setId(rs.getInt("id"));
				yuangong.setAddr(rs.getString("addr"));
				yuangong.setName(rs.getString("name"));
				yuangong.setIdcard(rs.getString("idcard"));
				yuangong.setPhone(rs.getString("phone"));
				yuangong.setPwd(rs.getString("pwd"));
				yuangong.setUsername(rs.getString("username"));
				yuangong.setType(rs.getString("type"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return yuangong;
	}

	public List<Yuangong> getAll(String findinfo) {
		sql="select * from yuangong where name like ? or username like ? or phone like ? or idcard like ?";
		List<Yuangong> list=new ArrayList<Yuangong>();
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, "%"+findinfo+"%");
			ps.setString(2, "%"+findinfo+"%");
			ps.setString(3, "%"+findinfo+"%");
			ps.setString(4, "%"+findinfo+"%");
			rs=ps.executeQuery();
			while (rs.next()) {
				Yuangong yuangong=new Yuangong();
				yuangong.setId(rs.getInt("id"));
				yuangong.setAddr(rs.getString("addr"));
				yuangong.setName(rs.getString("name"));
				yuangong.setIdcard(rs.getString("idcard"));
				yuangong.setPhone(rs.getString("phone"));
				yuangong.setPwd(rs.getString("pwd"));
				yuangong.setUsername(rs.getString("username"));
				yuangong.setType(rs.getString("type"));
				list.add(yuangong);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
			close();
		}
		return list;
	}

	public void insert(Yuangong yuangong) {
		sql="insert into yuangong (idcard,name,username,phone,addr,pwd,type) values(?,?,?,?,?,?,?)";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, yuangong.getIdcard());
			ps.setString(2, yuangong.getName());
			ps.setString(3, yuangong.getUsername());
			ps.setString(4, yuangong.getPhone());
			ps.setString(5, yuangong.getAddr());
			ps.setString(6, yuangong.getPwd());
			ps.setString(7, yuangong.getType());
			ps.execute();
		} catch (SQLException e) {
			System.out.println("添加失败");
		}
		finally{
			close();
		}
		
	}

	public void update(Yuangong yuangong) {
		sql="update yuangong set idcard=?,name=?,username=?,phone=?,addr=?,pwd=?,type=? where id=?";
		try {
			ps=con.prepareStatement(sql);
			ps.setString(1, yuangong.getIdcard());
			ps.setString(2, yuangong.getName());
			ps.setString(3, yuangong.getUsername());
			ps.setString(4, yuangong.getPhone());
			ps.setString(5, yuangong.getAddr());
			ps.setString(6, yuangong.getPwd());
			ps.setString(7, yuangong.getType());
			ps.setInt(8, yuangong.getId());
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
