package com.service;
import com.dao.GoodcommentDAO;
import com.pojo.Goodcomment;

import java.util.List;
//管理员表 逻辑接口封装
public class GoodcommentService {
	//依赖注入
	private GoodcommentDAO goodcommentDAO;

	public GoodcommentDAO getGoodcommentDAO() {
		return goodcommentDAO;
	}

	public void setGoodcommentDAO(GoodcommentDAO goodcommentDAO) {
		this.goodcommentDAO = goodcommentDAO;
	}

	
	// 获得指定管理员
	public Goodcomment goodcommentByID(Integer id)
	{
		return goodcommentDAO.findById(id);
	}
	
	//获得全部管理员 
	public List goodcommentAll()
	{
		//System.out.println("55");
		return goodcommentDAO.findAll();
	}
		
	
	// 添加管理员
	public void goodcommentAdd(Goodcomment user)
	{
		goodcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void goodcommentDelete(Goodcomment user)
	{
		goodcommentDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void goodcommentModify(Goodcomment user)
	{
		goodcommentDAO.merge(user);
	}
	
	
}
