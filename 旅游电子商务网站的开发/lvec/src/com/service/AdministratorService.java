package com.service;
import com.dao.AdministratorDAO;
import com.pojo.Administrator;

import java.util.List;
//管理员表 逻辑接口封装
public class AdministratorService {
	//依赖注入
	private AdministratorDAO administratorDAO;

	public AdministratorDAO getAdministratorDAO() {
		return administratorDAO;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}
	
	// 验证登录
	public boolean administratorLogin(Administrator user)
	{
		if(administratorDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// 获得指定管理员
	public Administrator administratorByID(Integer id)
	{
		return administratorDAO.findById(id);
	}
	
	//获得全部管理员 
	public List administratorAll()
	{
		//System.out.println("55");
		return administratorDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List administratorLikeNameOrId(String value)
	{
		return administratorDAO.findByLikeNameOrId(value);
	}
		
	
	// 添加管理员
	public void administratorAdd(Administrator user)
	{
		administratorDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void administratorDelete(Administrator user)
	{
		administratorDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void administratorModify(Administrator user)
	{
		administratorDAO.merge(user);
	}
	
	
}
