package com.service;
import com.dao.GonggaoDAO;
import com.pojo.Gonggao;
import com.util.Page;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GonggaoService {
	//gonggao����ע��
	private GonggaoDAO gonggaoDAO;

	public GonggaoDAO getGonggaoDAO() {
		return gonggaoDAO;
	}

	public void setGonggaoDAO(GonggaoDAO gonggaoDAO) {
		this.gonggaoDAO = gonggaoDAO;
	}
	
	// ���ǰ7�����¹���
	public List findTop7() {
		return gonggaoDAO.findTop7();
	}
	
	// ���ָ����¼gonggao
	public Gonggao gonggaoByID(Integer id)
	{
		return gonggaoDAO.findById(id);
	}
	
	//������Ŀ
	public int findNumsByLikeNameOrId(String value)
	{
		return gonggaoDAO.findNumsByLikeNameOrId(value);
	}
	
	//��ѯ��¼gonggaoLikeNameOrId
	public List gonggaoLikeNameOrId(String findinfo,Page p)
	{
		return gonggaoDAO.gonggaoLikeNameOrId(findinfo,p);
	}
	
	//���ȫ����¼gonggao
	public List gonggaoAll()
	{
		return gonggaoDAO.findAll();
	}
	

	// ��Ӽ�¼gonggao
	public void gonggaoAdd(Gonggao user)
	{
		gonggaoDAO.save(user);
	}
	
	// ɾ����¼gonggao
	public void gonggaoDelete(Gonggao user)
	{
		gonggaoDAO.delete(user);
	}
	
	// �޸ļ�¼gonggao
	public void gonggaoModify(Gonggao user)
	{
		gonggaoDAO.merge(user);
	}
	
	
}
