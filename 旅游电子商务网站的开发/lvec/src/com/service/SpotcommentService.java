package com.service;
import com.dao.SpotcommentDAO;
import com.pojo.Spotcomment;

import java.util.List;
//管理员表 逻辑接口封装
public class SpotcommentService {
	//依赖注入
	private SpotcommentDAO spotcommentDAO;

	public SpotcommentDAO getSpotcommentDAO() {
		return spotcommentDAO;
	}

	public void setSpotcommentDAO(SpotcommentDAO spotcommentDAO) {
		this.spotcommentDAO = spotcommentDAO;
	}

	
	// 获得指定管理员
	public Spotcomment spotcommentByID(Integer id)
	{
		return spotcommentDAO.findById(id);
	}
	
	//获得全部管理员 
	public List spotcommentAll()
	{
		//System.out.println("55");
		return spotcommentDAO.findAll();
	}
		
	
	// 添加管理员
	public void spotcommentAdd(Spotcomment user)
	{
		spotcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void spotcommentDelete(Spotcomment user)
	{
		spotcommentDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void spotcommentModify(Spotcomment user)
	{
		spotcommentDAO.merge(user);
	}
	
	
}
