package com.service;
import com.dao.SpotorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Spotorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//管理员表 逻辑接口封装
public class SpotorderService {
	//依赖注入
	private SpotorderDAO spotorderDAO;
	
	public SpotorderDAO getSpotorderDAO() {
		return spotorderDAO;
	}

	public void setSpotorderDAO(SpotorderDAO spotorderDAO) {
		this.spotorderDAO = spotorderDAO;
	}
	
	// 获得指定管理员
	public Spotorder spotorderByID(String id)
	{
		return spotorderDAO.findById(id);
	}
	
	//获得全部管理员 
	public List spotorderAll()
	{
		//System.out.println("55");
		return spotorderDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List spotorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return spotorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// 字符串转日期
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// 添加管理员
	public void spotorderAdd(Spotorder user)
	{
		spotorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void spotorderDelete(Spotorder user)
	{
		spotorderDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void spotorderModify(Spotorder user)
	{
		spotorderDAO.merge(user);
	}	
}
