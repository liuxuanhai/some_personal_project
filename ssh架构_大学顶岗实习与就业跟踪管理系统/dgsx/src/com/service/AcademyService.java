package com.service;
import com.dao.AcademyDAO;
import com.pojo.Academy;
import java.util.List;
//管理员表 逻辑接口封装
public class AcademyService {
	//academy依赖注入
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	
	// 获得指定记录academy
	public Academy academyByID(Integer id)
	{
		return academyDAO.findById(id);
	}
	
	// 获得指定记录academy
	public List academyByName(String name)
	{
		return academyDAO.findByAcademyname(name);
	}
	
	//获得全部记录academy
	public List academyAll()
	{
		return academyDAO.findAll();
	}
	
	//对academy名字进行模糊查询 
	public List academyLikeNameOrId(String value)
	{
		return academyDAO.findByLikeNameOrId(value);
	}

	// 添加记录academy
	public void academyAdd(Academy user)
	{
		academyDAO.save(user);
	}
	
	// 删除记录academy
	public void academyDelete(Academy user)
	{
		academyDAO.delete(user);
	}
	
	// 修改记录academy
	public void academyModify(Academy user)
	{
		academyDAO.merge(user);
	}
	
	
}
