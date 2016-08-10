package com.service;
import com.dao.GoodorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Goodorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//管理员表 逻辑接口封装
public class GoodorderService {
	//依赖注入
	private GoodorderDAO goodorderDAO;
	
	public GoodorderDAO getGoodorderDAO() {
		return goodorderDAO;
	}

	public void setGoodorderDAO(GoodorderDAO goodorderDAO) {
		this.goodorderDAO = goodorderDAO;
	}
	
	// 获得指定管理员
	public Goodorder goodorderByID(String id)
	{
		return goodorderDAO.findById(id);
	}
	
	//获得全部管理员 
	public List goodorderAll()
	{
		//System.out.println("55");
		return goodorderDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List goodorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return goodorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// 字符串转日期
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// 添加管理员
	public void goodorderAdd(Goodorder user)
	{
		goodorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void goodorderDelete(Goodorder user)
	{
		goodorderDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void goodorderModify(Goodorder user)
	{
		goodorderDAO.merge(user);
	}	
}
