package com.service;
import com.dao.HotelorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Hotelorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//管理员表 逻辑接口封装
public class HotelorderService {
	//依赖注入
	private HotelorderDAO hotelorderDAO;
	public HotelorderDAO getHotelorderDAO() {
		return hotelorderDAO;
	}

	public void setHotelorderDAO(HotelorderDAO hotelorderDAO) {
		this.hotelorderDAO = hotelorderDAO;
	}
	
	// 获得指定管理员
	public Hotelorder hotelorderByID(String id)
	{
		return hotelorderDAO.findById(id);
	}
	
	//获得全部管理员 
	public List hotelorderAll()
	{
		//System.out.println("55");
		return hotelorderDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List hotelorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return hotelorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// 字符串转日期
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// 添加管理员
	public void hotelorderAdd(Hotelorder user)
	{
		hotelorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void hotelorderDelete(Hotelorder user)
	{
		hotelorderDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void hotelorderModify(Hotelorder user)
	{
		hotelorderDAO.merge(user);
	}
}
