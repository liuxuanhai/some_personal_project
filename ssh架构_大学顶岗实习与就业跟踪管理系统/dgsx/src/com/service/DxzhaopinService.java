package com.service;
import com.dao.DxzhaopinDAO;
import com.pojo.Dxzhaopin;
import com.util.Page;

import java.util.List;
//管理员表 逻辑接口封装
public class DxzhaopinService {
	//dxzhaopin依赖注入
	private DxzhaopinDAO dxzhaopinDAO;

	public DxzhaopinDAO getDxzhaopinDAO() {
		return dxzhaopinDAO;
	}

	public void setDxzhaopinDAO(DxzhaopinDAO dxzhaopinDAO) {
		this.dxzhaopinDAO = dxzhaopinDAO;
	}
	
	// 获得前7个最新招聘
	public List findTop7() {
		return dxzhaopinDAO.findTop7();
	}
		
	// 获得指定记录dxzhaopin
	public Dxzhaopin dxzhaopinByID(Integer id)
	{
		return dxzhaopinDAO.findById(id);
	}
	
	//查找数目
	public int findNumsByLikeNameOrId(String value)
	{
		return dxzhaopinDAO.findNumsByLikeNameOrId(value);
	}
	
	//查询记录dxzhaopinLikeNameOrId
	public List dxzhaopinLikeNameOrId(String findinfo,Page p)
	{
		return dxzhaopinDAO.dxzhaopinLikeNameOrId(findinfo,p);
	}
	
	//获得全部记录dxzhaopin
	public List dxzhaopinAll()
	{
		return dxzhaopinDAO.findAll();
	}
	

	// 添加记录dxzhaopin
	public void dxzhaopinAdd(Dxzhaopin user)
	{
		dxzhaopinDAO.save(user);
	}
	
	// 删除记录dxzhaopin
	public void dxzhaopinDelete(Dxzhaopin user)
	{
		dxzhaopinDAO.delete(user);
	}
	
	// 修改记录dxzhaopin
	public void dxzhaopinModify(Dxzhaopin user)
	{
		dxzhaopinDAO.merge(user);
	}
	
	
}
