package com.service;
import com.dao.AdministratorDAO;
import com.pojo.Administrator;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class AdministratorService {
	//administrator����ע��
	private AdministratorDAO administratorDAO;

	public AdministratorDAO getAdministratorDAO() {
		return administratorDAO;
	}

	public void setAdministratorDAO(AdministratorDAO administratorDAO) {
		this.administratorDAO = administratorDAO;
	}
	
	// administrator��֤��¼
	public boolean administratorLogin(Administrator user)
	{
		if(administratorDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// ���ָ����¼administrator
	public Administrator administratorByID(Integer id)
	{
		return administratorDAO.findById(id);
	}
	
	//���ȫ����¼administrator
	public List administratorAll()
	{
		return administratorDAO.findAll();
	}
	
	//��administrator���ֽ���ģ����ѯ 
	public List administratorLikeNameOrId(String value)
	{
		return administratorDAO.findByLikeNameOrId(value);
	}

	// ��Ӽ�¼administrator
	public void administratorAdd(Administrator user)
	{
		administratorDAO.save(user);
	}
	
	// ɾ����¼administrator
	public void administratorDelete(Administrator user)
	{
		administratorDAO.delete(user);
	}
	
	// �޸ļ�¼administrator
	public void administratorModify(Administrator user)
	{
		administratorDAO.merge(user);
	}
	
	
}
