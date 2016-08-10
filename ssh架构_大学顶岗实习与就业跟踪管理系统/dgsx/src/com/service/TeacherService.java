package com.service;
import com.dao.AcademyDAO;
import com.dao.TeacherDAO;
import com.pojo.Academy;
import com.pojo.Teacher;
import com.util.Page;

import java.util.List;
//管理员表 逻辑接口封装
public class TeacherService {
	//teacher依赖注入
	private TeacherDAO teacherDAO;

	public TeacherDAO getTeacherDAO() {
		return teacherDAO;
	}

	public void setTeacherDAO(TeacherDAO teacherDAO) {
		this.teacherDAO = teacherDAO;
	}
	//academy依赖注入
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	
	//获得院系
	public List getAcademyName()
	{
		return academyDAO.findAll();
	}
	//获得院系
	public Academy getAcademyByacademyid(String id)
	{
		return academyDAO.findById(new Integer(id));
	}
	
	// teacher验证登录
	public boolean teacherLogin(Teacher user)
	{
		if(teacherDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// 获得指定记录teacher
	public Teacher teacherByID(String id)
	{
		return teacherDAO.findById(id);
	}
	
	//获得全部记录teacher
	public List teacherAll()
	{
		return teacherDAO.findAll();
	}
	
	//获得教师数目
	public int findNumsByLikeNameOrId(String value)
	{
		return teacherDAO.findNumsByLikeNameOrId(value);
	}
	
	//对teacher名字进行模糊查询 
	public List teacherLikeNameOrId(String value,Page p)
	{
		return teacherDAO.findByLikeNameOrId(value, p);
	}
	
	//获得教师数目
	public int findNumsByLikeNameAndAcademyid(String value,String academyid)
	{
		return teacherDAO.findNumsByLikeNameAndAcademyid(value,new Integer(academyid.trim()));
	}
	
	//对teacher名字进行模糊查询 
	public List teacherLikeNameAndAcademyid(String value,String academyid,Page p)
	{
		return teacherDAO.findByLikeNameAndAcademyid(value,new Integer(academyid.trim()), p);
	}

	// 添加记录teacher
	public void teacherAdd(Teacher user)
	{
		teacherDAO.save(user);
	}
	
	// 删除记录teacher
	public void teacherDelete(Teacher user)
	{
		teacherDAO.delete(user);
	}
	
	// 修改记录teacher
	public void teacherModify(Teacher user)
	{
		teacherDAO.merge(user);
	}
	
	
}
