package com.service;
import com.dao.HotelDAO;
import com.dao.HotelcommentDAO;
import com.dao.RoomtypeDAO;
import com.dao.ViewspotDAO;
import com.pojo.Hotel;

import java.util.List;
//管理员表 逻辑接口封装
public class HotelService {
	//依赖注入
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	
	//依赖注入
	private RoomtypeDAO roomtypeDAO;

	public RoomtypeDAO getRoomtypeDAO() {
		return roomtypeDAO;
	}

	public void setRoomtypeDAO(RoomtypeDAO roomtypeDAO) {
		this.roomtypeDAO = roomtypeDAO;
	}
	// 获得酒店房型
	public List getRoomtypeByHotelid(String id)
	{
		return roomtypeDAO.findByHotelid(new Integer(id));
	}
	//依赖注入
	private ViewspotDAO viewspotDAO;

	public ViewspotDAO getViewspotDAO() {
		return viewspotDAO;
	}

	// 获得指定城市的景点
	public List getViewspotByCity(String city)
	{
		return viewspotDAO.findBySpotcity(city);
	}
	
	public void setViewspotDAO(ViewspotDAO viewspotDAO) {
		this.viewspotDAO = viewspotDAO;
	}
	//依赖注入
	private HotelcommentDAO hotelcommentDAO;

	public HotelcommentDAO getHotelcommentDAO() {
		return hotelcommentDAO;
	}

	public void setHotelcommentDAO(HotelcommentDAO hotelcommentDAO) {
		this.hotelcommentDAO = hotelcommentDAO;
	}
	//获得景点评论
	public List getHotelcommentByHotelid(String id)
	{
		return hotelcommentDAO.findByHotelid(new Integer(id));
	}
	// 获得指定管理员
	public Hotel hotelByID(Integer id)
	{
		return hotelDAO.findById(id);
	}
	
	//获得全部管理员 
	public List hotelAll()
	{
		//System.out.println("55");
		return hotelDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List hotelLikeNameOrId(String value)
	{
		return hotelDAO.findByLikeNameOrId(value);
	}
	
	//对id或名字进行模糊查询 
	public List hotelLikeNameAndCity(String value,String city)
	{
		return hotelDAO.findByLikeNameOrId(value,city);
	}
	
	public List findAllCity()
	{
		return hotelDAO.findAllCity();
	}	
	
	// 添加管理员
	public void hotelAdd(Hotel user)
	{
		hotelDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void hotelDelete(Hotel user)
	{
		hotelDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void hotelModify(Hotel user)
	{
		hotelDAO.merge(user);
	}
	
	
}
