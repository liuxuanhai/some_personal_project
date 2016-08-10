package com.service;
import com.dao.HotelDAO;
import com.dao.RoomtypeDAO;
import com.pojo.Hotel;
import com.pojo.Roomtype;

import java.util.List;
//管理员表 逻辑接口封装
public class RoomtypeService {
	//依赖注入
	private RoomtypeDAO roomtypeDAO;

	public RoomtypeDAO getRoomtypeDAO() {
		return roomtypeDAO;
	}

	public void setRoomtypeDAO(RoomtypeDAO roomtypeDAO) {
		this.roomtypeDAO = roomtypeDAO;
	}
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	// 获得酒店名称
	public String getHotelNameByHotelid(Integer id)
	{
		Hotel item=hotelDAO.findById(id);
		return item.getHotelname();
	}
	// 获得指定管理员
	public Roomtype roomtypeByID(Integer id)
	{
		return roomtypeDAO.findById(id);
	}
	
	//获得全部管理员 
	public List roomtypeAll()
	{
		//System.out.println("55");
		return roomtypeDAO.findAll();
	}
	
	
	//获得指定酒店的房型
	public List roomtypeAll(Integer hotelid)
	{
		//System.out.println("55");
		return roomtypeDAO.findByHotelid(hotelid);
	}
	
	// 添加管理员
	public void roomtypeAdd(Roomtype user)
	{
		roomtypeDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void roomtypeDelete(Roomtype user)
	{
		roomtypeDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void roomtypeModify(Roomtype user)
	{
		roomtypeDAO.merge(user);
	}
	
	
}
