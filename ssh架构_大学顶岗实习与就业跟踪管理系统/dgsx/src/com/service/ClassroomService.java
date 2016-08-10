package com.service;
import com.dao.AcademyDAO;
import com.dao.ClassroomDAO;
import com.pojo.Academy;
import com.pojo.Classroom;
import com.util.Page;

import java.util.List;
//管理员表 逻辑接口封装
public class ClassroomService {
	//classroom依赖注入
	private ClassroomDAO classroomDAO;

	public ClassroomDAO getClassroomDAO() {
		return classroomDAO;
	}

	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
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
	public Academy getAcademyByid(String id)
	{
		return academyDAO.findById(new Integer(id));
	}
	
	// 获得指定记录classroom
	public Classroom classroomByID(Integer id)
	{
		return classroomDAO.findById(id);
	}
	
	// 从名称获得班级
	public List classroomByName(String name)
	{
		return classroomDAO.findByClassname(name);
	}
	
	
	
	//获得全部记录classroom
	public List classroomAll()
	{
		return classroomDAO.findAll();
	}

	// 添加记录classroom
	public void classroomAdd(Classroom user)
	{
		classroomDAO.save(user);
	}
	
	// 删除记录classroom
	public void classroomDelete(Classroom user)
	{
		classroomDAO.delete(user);
	}
	
	// 修改记录classroom
	public void classroomModify(Classroom user)
	{
		classroomDAO.merge(user);
	}
	
	
	//对名字进行模糊查询 
	public List findByLikeNameAndAcademyid(String value,String academyid,Page p)
	{
		return classroomDAO.findByLikeNameAndAcademyid(value,new Integer(academyid.trim()),p);
	}
	
	//获得数目
	public int findNumsByLikeNameAndAcademyid(String value,String academyid)
	{
		return  classroomDAO.findNumsByLikeNameAndAcademyid(value,new Integer(academyid.trim()));
	}
	
}
