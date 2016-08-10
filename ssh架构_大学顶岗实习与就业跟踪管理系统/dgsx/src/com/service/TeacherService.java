package com.service;
import com.dao.AcademyDAO;
import com.dao.TeacherDAO;
import com.pojo.Academy;
import com.pojo.Teacher;
import com.util.Page;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class TeacherService {
	//teacher����ע��
	private TeacherDAO teacherDAO;

	public TeacherDAO getTeacherDAO() {
		return teacherDAO;
	}

	public void setTeacherDAO(TeacherDAO teacherDAO) {
		this.teacherDAO = teacherDAO;
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
	public List getAcademyName()
	{
		return academyDAO.findAll();
	}
	//���Ժϵ
	public Academy getAcademyByacademyid(String id)
	{
		return academyDAO.findById(new Integer(id));
	}
	
	// teacher��֤��¼
	public boolean teacherLogin(Teacher user)
	{
		if(teacherDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// ���ָ����¼teacher
	public Teacher teacherByID(String id)
	{
		return teacherDAO.findById(id);
	}
	
	//���ȫ����¼teacher
	public List teacherAll()
	{
		return teacherDAO.findAll();
	}
	
	//��ý�ʦ��Ŀ
	public int findNumsByLikeNameOrId(String value)
	{
		return teacherDAO.findNumsByLikeNameOrId(value);
	}
	
	//��teacher���ֽ���ģ����ѯ 
	public List teacherLikeNameOrId(String value,Page p)
	{
		return teacherDAO.findByLikeNameOrId(value, p);
	}
	
	//��ý�ʦ��Ŀ
	public int findNumsByLikeNameAndAcademyid(String value,String academyid)
	{
		return teacherDAO.findNumsByLikeNameAndAcademyid(value,new Integer(academyid.trim()));
	}
	
	//��teacher���ֽ���ģ����ѯ 
	public List teacherLikeNameAndAcademyid(String value,String academyid,Page p)
	{
		return teacherDAO.findByLikeNameAndAcademyid(value,new Integer(academyid.trim()), p);
	}

	// ��Ӽ�¼teacher
	public void teacherAdd(Teacher user)
	{
		teacherDAO.save(user);
	}
	
	// ɾ����¼teacher
	public void teacherDelete(Teacher user)
	{
		teacherDAO.delete(user);
	}
	
	// �޸ļ�¼teacher
	public void teacherModify(Teacher user)
	{
		teacherDAO.merge(user);
	}
	
	
}
