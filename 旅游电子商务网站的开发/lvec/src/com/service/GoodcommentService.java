package com.service;
import com.dao.GoodcommentDAO;
import com.pojo.Goodcomment;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GoodcommentService {
	//����ע��
	private GoodcommentDAO goodcommentDAO;

	public GoodcommentDAO getGoodcommentDAO() {
		return goodcommentDAO;
	}

	public void setGoodcommentDAO(GoodcommentDAO goodcommentDAO) {
		this.goodcommentDAO = goodcommentDAO;
	}

	
	// ���ָ������Ա
	public Goodcomment goodcommentByID(Integer id)
	{
		return goodcommentDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List goodcommentAll()
	{
		//System.out.println("55");
		return goodcommentDAO.findAll();
	}
		
	
	// ��ӹ���Ա
	public void goodcommentAdd(Goodcomment user)
	{
		goodcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void goodcommentDelete(Goodcomment user)
	{
		goodcommentDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void goodcommentModify(Goodcomment user)
	{
		goodcommentDAO.merge(user);
	}
	
	
}
