package com.service;
import com.dao.DxzhaopinDAO;
import com.pojo.Dxzhaopin;
import com.util.Page;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class DxzhaopinService {
	//dxzhaopin����ע��
	private DxzhaopinDAO dxzhaopinDAO;

	public DxzhaopinDAO getDxzhaopinDAO() {
		return dxzhaopinDAO;
	}

	public void setDxzhaopinDAO(DxzhaopinDAO dxzhaopinDAO) {
		this.dxzhaopinDAO = dxzhaopinDAO;
	}
	
	// ���ǰ7��������Ƹ
	public List findTop7() {
		return dxzhaopinDAO.findTop7();
	}
		
	// ���ָ����¼dxzhaopin
	public Dxzhaopin dxzhaopinByID(Integer id)
	{
		return dxzhaopinDAO.findById(id);
	}
	
	//������Ŀ
	public int findNumsByLikeNameOrId(String value)
	{
		return dxzhaopinDAO.findNumsByLikeNameOrId(value);
	}
	
	//��ѯ��¼dxzhaopinLikeNameOrId
	public List dxzhaopinLikeNameOrId(String findinfo,Page p)
	{
		return dxzhaopinDAO.dxzhaopinLikeNameOrId(findinfo,p);
	}
	
	//���ȫ����¼dxzhaopin
	public List dxzhaopinAll()
	{
		return dxzhaopinDAO.findAll();
	}
	

	// ��Ӽ�¼dxzhaopin
	public void dxzhaopinAdd(Dxzhaopin user)
	{
		dxzhaopinDAO.save(user);
	}
	
	// ɾ����¼dxzhaopin
	public void dxzhaopinDelete(Dxzhaopin user)
	{
		dxzhaopinDAO.delete(user);
	}
	
	// �޸ļ�¼dxzhaopin
	public void dxzhaopinModify(Dxzhaopin user)
	{
		dxzhaopinDAO.merge(user);
	}
	
	
}
