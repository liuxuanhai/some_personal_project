package com.service;
import com.dao.GoodtypeDAO;
import com.pojo.Goodtype;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GoodtypeService {
	//����ע��
	private GoodtypeDAO goodtypeDAO;

	public GoodtypeDAO getGoodtypeDAO() {
		return goodtypeDAO;
	}

	public void setGoodtypeDAO(GoodtypeDAO goodtypeDAO) {
		this.goodtypeDAO = goodtypeDAO;
	}
	
	// ���ָ������Ա
	public Goodtype goodtypeByID(Integer id)
	{
		return goodtypeDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List goodtypeAll()
	{
		//System.out.println("55");
		return goodtypeDAO.findAll();
	}
		
	
	// ��ӹ���Ա
	public void goodtypeAdd(Goodtype user)
	{
		goodtypeDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void goodtypeDelete(Goodtype user)
	{
		goodtypeDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void goodtypeModify(Goodtype user)
	{
		goodtypeDAO.merge(user);
	}
	
	
}
