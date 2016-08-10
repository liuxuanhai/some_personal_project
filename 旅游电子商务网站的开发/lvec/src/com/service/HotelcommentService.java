package com.service;
import com.dao.HotelcommentDAO;
import com.pojo.Hotelcomment;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class HotelcommentService {
	//����ע��
	private HotelcommentDAO hotelcommentDAO;

	public HotelcommentDAO getHotelcommentDAO() {
		return hotelcommentDAO;
	}

	public void setHotelcommentDAO(HotelcommentDAO hotelcommentDAO) {
		this.hotelcommentDAO = hotelcommentDAO;
	}

	
	// ���ָ������Ա
	public Hotelcomment hotelcommentByID(Integer id)
	{
		return hotelcommentDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List hotelcommentAll()
	{
		//System.out.println("55");
		return hotelcommentDAO.findAll();
	}
		
	
	// ��ӹ���Ա
	public void hotelcommentAdd(Hotelcomment user)
	{
		hotelcommentDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void hotelcommentDelete(Hotelcomment user)
	{
		hotelcommentDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void hotelcommentModify(Hotelcomment user)
	{
		hotelcommentDAO.merge(user);
	}
	
	
}
