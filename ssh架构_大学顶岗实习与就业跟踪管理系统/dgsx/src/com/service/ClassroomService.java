package com.service;
import com.dao.AcademyDAO;
import com.dao.ClassroomDAO;
import com.pojo.Academy;
import com.pojo.Classroom;
import com.util.Page;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class ClassroomService {
	//classroom����ע��
	private ClassroomDAO classroomDAO;

	public ClassroomDAO getClassroomDAO() {
		return classroomDAO;
	}

	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}
	
	//academy����ע��
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	//���Ժϵ
	public Academy getAcademyByid(String id)
	{
		return academyDAO.findById(new Integer(id));
	}
	
	// ���ָ����¼classroom
	public Classroom classroomByID(Integer id)
	{
		return classroomDAO.findById(id);
	}
	
	// �����ƻ�ð༶
	public List classroomByName(String name)
	{
		return classroomDAO.findByClassname(name);
	}
	
	
	
	//���ȫ����¼classroom
	public List classroomAll()
	{
		return classroomDAO.findAll();
	}

	// ��Ӽ�¼classroom
	public void classroomAdd(Classroom user)
	{
		classroomDAO.save(user);
	}
	
	// ɾ����¼classroom
	public void classroomDelete(Classroom user)
	{
		classroomDAO.delete(user);
	}
	
	// �޸ļ�¼classroom
	public void classroomModify(Classroom user)
	{
		classroomDAO.merge(user);
	}
	
	
	//�����ֽ���ģ����ѯ 
	public List findByLikeNameAndAcademyid(String value,String academyid,Page p)
	{
		return classroomDAO.findByLikeNameAndAcademyid(value,new Integer(academyid.trim()),p);
	}
	
	//�����Ŀ
	public int findNumsByLikeNameAndAcademyid(String value,String academyid)
	{
		return  classroomDAO.findNumsByLikeNameAndAcademyid(value,new Integer(academyid.trim()));
	}
	
}
