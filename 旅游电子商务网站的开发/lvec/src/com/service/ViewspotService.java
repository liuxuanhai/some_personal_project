package com.service;
import com.dao.HotelDAO;
import com.dao.SpotcommentDAO;
import com.dao.ViewspotDAO;
import com.pojo.Viewspot;

import java.util.List;
//管理员表 逻辑接口封装
public class ViewspotService {
	//依赖注入
	private ViewspotDAO viewspotDAO;

	public ViewspotDAO getViewspotDAO() {
		return viewspotDAO;
	}

	public void setViewspotDAO(ViewspotDAO viewspotDAO) {
		this.viewspotDAO = viewspotDAO;
	}
	
	//依赖注入
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	
	// 获得指定城市的酒店
	public List getHotleByCity(String city)
	{
		return hotelDAO.findByHotelcity(city);
	}
	//依赖注入
	private SpotcommentDAO spotcommentDAO;

	public SpotcommentDAO getSpotcommentDAO() {
		return spotcommentDAO;
	}

	public void setSpotcommentDAO(SpotcommentDAO spotcommentDAO) {
		this.spotcommentDAO = spotcommentDAO;
	}
	public List getSpotcommentBySpotid(String id)
	{
		return spotcommentDAO.findBySpotid(new Integer(id));
	}
	
	// 获得指定管理员
	public Viewspot viewspotByID(Integer id)
	{
		return viewspotDAO.findById(id);
	}
	
	
	
	//获得全部管理员 
	public List viewspotAll()
	{
		//System.out.println("55");
		return viewspotDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List viewspotLikeNameOrId(String value)
	{
		return viewspotDAO.findByLikeNameOrId(value);
	}
	//对id或名字进行模糊查询 
	public List viewspotLikeNameOrId(String value,String city)
	{
		return viewspotDAO.findByLikeNameOrId(value,city);
	}	
	
	public List findAllCity()
	{
		return viewspotDAO.findAllCity();
	}
	
	// 添加管理员
	public void viewspotAdd(Viewspot user)
	{
		viewspotDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void viewspotDelete(Viewspot user)
	{
		viewspotDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void viewspotModify(Viewspot user)
	{
		viewspotDAO.merge(user);
	}
	
	
}
