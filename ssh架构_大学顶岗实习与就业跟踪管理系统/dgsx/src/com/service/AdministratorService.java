package com.service;
import com.dao.AdministratorDAO;
import com.pojo.Administrator;
import java.util.List;
//管理员表 逻辑接口封装
public class AdministratorService {
	//administrator依赖注入
	private AdministratorDAO administratorDAO;

	public AdministratorDAO getAdministratorDAO() {
		return administratorDAO;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}
	
	// administrator验证登录
	public boolean administratorLogin(Administrator user)
	{
		if(administratorDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// 获得指定记录administrator
	public Administrator administratorByID(Integer id)
	{
		return administratorDAO.findById(id);
	}
	
	//获得全部记录administrator
	public List administratorAll()
	{
		return administratorDAO.findAll();
	}
	
	//对administrator名字进行模糊查询 
	public List administratorLikeNameOrId(String value)
	{
		return administratorDAO.findByLikeNameOrId(value);
	}

	// 添加记录administrator
	public void administratorAdd(Administrator user)
	{
		administratorDAO.save(user);
	}
	
	// 删除记录administrator
	public void administratorDelete(Administrator user)
	{
		administratorDAO.delete(user);
	}
	
	// 修改记录administrator
	public void administratorModify(Administrator user)
	{
		administratorDAO.merge(user);
	}
	
	
}
