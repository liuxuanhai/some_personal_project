package com.service;
import com.dao.AdministratorDAO;
import com.pojo.Administrator;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class AdministratorService {
	//����ע��
	private AdministratorDAO administratorDAO;

	public AdministratorDAO getAdministratorDAO() {
		return administratorDAO;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}
	
	// ��֤��¼
	public boolean administratorLogin(Administrator user)
	{
		if(administratorDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// ���ָ������Ա
	public Administrator administratorByID(Integer id)
	{
		return administratorDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List administratorAll()
	{
		//System.out.println("55");
		return administratorDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List administratorLikeNameOrId(String value)
	{
		return administratorDAO.findByLikeNameOrId(value);
	}
		
	
	// ��ӹ���Ա
	public void administratorAdd(Administrator user)
	{
		administratorDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void administratorDelete(Administrator user)
	{
		administratorDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void administratorModify(Administrator user)
	{
		administratorDAO.merge(user);
	}
	
	
}
