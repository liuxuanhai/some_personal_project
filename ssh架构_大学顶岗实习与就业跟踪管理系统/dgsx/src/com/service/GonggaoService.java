package com.service;
import com.dao.GonggaoDAO;
import com.pojo.Gonggao;
import com.util.Page;

import java.util.List;
//管理员表 逻辑接口封装
public class GonggaoService {
	//gonggao依赖注入
	private GonggaoDAO gonggaoDAO;

	public GonggaoDAO getGonggaoDAO() {
		return gonggaoDAO;
	}

	public void setGonggaoDAO(GonggaoDAO gonggaoDAO) {
		this.gonggaoDAO = gonggaoDAO;
	}
	
	// 获得前7个最新公告
	public List findTop7() {
		return gonggaoDAO.findTop7();
	}
	
	// 获得指定记录gonggao
	public Gonggao gonggaoByID(Integer id)
	{
		return gonggaoDAO.findById(id);
	}
	
	//查找数目
	public int findNumsByLikeNameOrId(String value)
	{
		return gonggaoDAO.findNumsByLikeNameOrId(value);
	}
	
	//查询记录gonggaoLikeNameOrId
	public List gonggaoLikeNameOrId(String findinfo,Page p)
	{
		return gonggaoDAO.gonggaoLikeNameOrId(findinfo,p);
	}
	
	//获得全部记录gonggao
	public List gonggaoAll()
	{
		return gonggaoDAO.findAll();
	}
	

	// 添加记录gonggao
	public void gonggaoAdd(Gonggao user)
	{
		gonggaoDAO.save(user);
	}
	
	// 删除记录gonggao
	public void gonggaoDelete(Gonggao user)
	{
		gonggaoDAO.delete(user);
	}
	
	// 修改记录gonggao
	public void gonggaoModify(Gonggao user)
	{
		gonggaoDAO.merge(user);
	}
	
	
}
