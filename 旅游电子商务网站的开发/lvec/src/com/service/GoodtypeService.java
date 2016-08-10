package com.service;
import com.dao.GoodtypeDAO;
import com.pojo.Goodtype;

import java.util.List;
//管理员表 逻辑接口封装
public class GoodtypeService {
	//依赖注入
	private GoodtypeDAO goodtypeDAO;

	public GoodtypeDAO getGoodtypeDAO() {
		return goodtypeDAO;
	}

	public void setGoodtypeDAO(GoodtypeDAO goodtypeDAO) {
		this.goodtypeDAO = goodtypeDAO;
	}
	
	// 获得指定管理员
	public Goodtype goodtypeByID(Integer id)
	{
		return goodtypeDAO.findById(id);
	}
	
	//获得全部管理员 
	public List goodtypeAll()
	{
		//System.out.println("55");
		return goodtypeDAO.findAll();
	}
		
	
	// 添加管理员
	public void goodtypeAdd(Goodtype user)
	{
		goodtypeDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void goodtypeDelete(Goodtype user)
	{
		goodtypeDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void goodtypeModify(Goodtype user)
	{
		goodtypeDAO.merge(user);
	}
	
	
}
