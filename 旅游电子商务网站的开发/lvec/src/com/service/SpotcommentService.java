package com.service;
import com.dao.SpotcommentDAO;
import com.pojo.Spotcomment;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class SpotcommentService {
	//����ע��
	private SpotcommentDAO spotcommentDAO;

	public SpotcommentDAO getSpotcommentDAO() {
		return spotcommentDAO;
	}

	public void setSpotcommentDAO(SpotcommentDAO spotcommentDAO) {
		this.spotcommentDAO = spotcommentDAO;
	}

	
	// ���ָ������Ա
	public Spotcomment spotcommentByID(Integer id)
	{
		return spotcommentDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List spotcommentAll()
	{
		//System.out.println("55");
		return spotcommentDAO.findAll();
	}
		
	
	// ��ӹ���Ա
	public void spotcommentAdd(Spotcomment user)
	{
		spotcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void spotcommentDelete(Spotcomment user)
	{
		spotcommentDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void spotcommentModify(Spotcomment user)
	{
		spotcommentDAO.merge(user);
	}
	
	
}
