package com.service;
import com.dao.HotelcommentDAO;
import com.pojo.Hotelcomment;

import java.util.List;
//管理员表 逻辑接口封装
public class HotelcommentService {
	//依赖注入
	private HotelcommentDAO hotelcommentDAO;

	public HotelcommentDAO getHotelcommentDAO() {
		return hotelcommentDAO;
	}

	public void setHotelcommentDAO(HotelcommentDAO hotelcommentDAO) {
		this.hotelcommentDAO = hotelcommentDAO;
	}

	
	// 获得指定管理员
	public Hotelcomment hotelcommentByID(Integer id)
	{
		return hotelcommentDAO.findById(id);
	}
	
	//获得全部管理员 
	public List hotelcommentAll()
	{
		//System.out.println("55");
		return hotelcommentDAO.findAll();
	}
		
	
	// 添加管理员
	public void hotelcommentAdd(Hotelcomment user)
	{
		hotelcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void hotelcommentDelete(Hotelcomment user)
	{
		hotelcommentDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void hotelcommentModify(Hotelcomment user)
	{
		hotelcommentDAO.merge(user);
	}
	
	
}
