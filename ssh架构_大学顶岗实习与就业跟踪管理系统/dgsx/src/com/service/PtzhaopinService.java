package com.service;
import com.dao.PtzhaopinDAO;
import com.pojo.Ptzhaopin;
import com.util.Page;

import java.util.List;
//管理员表 逻辑接口封装
public class PtzhaopinService {
	//ptzhaopin依赖注入
	private PtzhaopinDAO ptzhaopinDAO;

	public PtzhaopinDAO getPtzhaopinDAO() {
		return ptzhaopinDAO;
	}

	public void setPtzhaopinDAO(PtzhaopinDAO ptzhaopinDAO) {
		this.ptzhaopinDAO = ptzhaopinDAO;
	}
	

	// 获得前7个最新招聘
	public List findTop7() {
		return ptzhaopinDAO.findTop7();
	}
	
	// 获得指定记录ptzhaopin
	public Ptzhaopin ptzhaopinByID(Integer id)
	{
		return ptzhaopinDAO.findById(id);
	}
	
	//查找数目
	public int findNumsByLikeNameOrId(String value)
	{
		return ptzhaopinDAO.findNumsByLikeNameOrId(value);
	}
	
	//查询记录ptzhaopinLikeNameOrId
	public List ptzhaopinLikeNameOrId(String findinfo,Page p)
	{
		return ptzhaopinDAO.ptzhaopinLikeNameOrId(findinfo,p);
	}
	
	//获得全部记录ptzhaopin
	public List ptzhaopinAll()
	{
		return ptzhaopinDAO.findAll();
	}
	

	// 添加记录ptzhaopin
	public void ptzhaopinAdd(Ptzhaopin user)
	{
		ptzhaopinDAO.save(user);
	}
	
	// 删除记录ptzhaopin
	public void ptzhaopinDelete(Ptzhaopin user)
	{
		ptzhaopinDAO.delete(user);
	}
	
	// 修改记录ptzhaopin
	public void ptzhaopinModify(Ptzhaopin user)
	{
		ptzhaopinDAO.merge(user);
	}
	
	
}
