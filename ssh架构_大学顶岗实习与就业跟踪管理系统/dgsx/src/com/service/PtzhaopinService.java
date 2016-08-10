package com.service;
import com.dao.PtzhaopinDAO;
import com.pojo.Ptzhaopin;
import com.util.Page;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class PtzhaopinService {
	//ptzhaopin����ע��
	private PtzhaopinDAO ptzhaopinDAO;

	public PtzhaopinDAO getPtzhaopinDAO() {
		return ptzhaopinDAO;
	}

	public void setPtzhaopinDAO(PtzhaopinDAO ptzhaopinDAO) {
		this.ptzhaopinDAO = ptzhaopinDAO;
	}
	

	// ���ǰ7��������Ƹ
	public List findTop7() {
		return ptzhaopinDAO.findTop7();
	}
	
	// ���ָ����¼ptzhaopin
	public Ptzhaopin ptzhaopinByID(Integer id)
	{
		return ptzhaopinDAO.findById(id);
	}
	
	//������Ŀ
	public int findNumsByLikeNameOrId(String value)
	{
		return ptzhaopinDAO.findNumsByLikeNameOrId(value);
	}
	
	//��ѯ��¼ptzhaopinLikeNameOrId
	public List ptzhaopinLikeNameOrId(String findinfo,Page p)
	{
		return ptzhaopinDAO.ptzhaopinLikeNameOrId(findinfo,p);
	}
	
	//���ȫ����¼ptzhaopin
	public List ptzhaopinAll()
	{
		return ptzhaopinDAO.findAll();
	}
	

	// ��Ӽ�¼ptzhaopin
	public void ptzhaopinAdd(Ptzhaopin user)
	{
		ptzhaopinDAO.save(user);
	}
	
	// ɾ����¼ptzhaopin
	public void ptzhaopinDelete(Ptzhaopin user)
	{
		ptzhaopinDAO.delete(user);
	}
	
	// �޸ļ�¼ptzhaopin
	public void ptzhaopinModify(Ptzhaopin user)
	{
		ptzhaopinDAO.merge(user);
	}
	
	
}
