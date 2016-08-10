package com.service;
import com.dao.AcademyDAO;
import com.pojo.Academy;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class AcademyService {
	//academy����ע��
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	
	// ���ָ����¼academy
	public Academy academyByID(Integer id)
	{
		return academyDAO.findById(id);
	}
	
	// ���ָ����¼academy
	public List academyByName(String name)
	{
		return academyDAO.findByAcademyname(name);
	}
	
	//���ȫ����¼academy
	public List academyAll()
	{
		return academyDAO.findAll();
	}
	
	//��academy���ֽ���ģ����ѯ 
	public List academyLikeNameOrId(String value)
	{
		return academyDAO.findByLikeNameOrId(value);
	}

	// ��Ӽ�¼academy
	public void academyAdd(Academy user)
	{
		academyDAO.save(user);
	}
	
	// ɾ����¼academy
	public void academyDelete(Academy user)
	{
		academyDAO.delete(user);
	}
	
	// �޸ļ�¼academy
	public void academyModify(Academy user)
	{
		academyDAO.merge(user);
	}
	
	
}
