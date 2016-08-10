package com.service;
import com.dao.HotelDAO;
import com.dao.SpotcommentDAO;
import com.dao.ViewspotDAO;
import com.pojo.Viewspot;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class ViewspotService {
	//����ע��
	private ViewspotDAO viewspotDAO;

	public ViewspotDAO getViewspotDAO() {
		return viewspotDAO;
	}

	public void setViewspotDAO(ViewspotDAO viewspotDAO) {
		this.viewspotDAO = viewspotDAO;
	}
	
	//����ע��
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	
	// ���ָ�����еľƵ�
	public List getHotleByCity(String city)
	{
		return hotelDAO.findByHotelcity(city);
	}
	//����ע��
	private SpotcommentDAO spotcommentDAO;

	public SpotcommentDAO getSpotcommentDAO() {
		return spotcommentDAO;
	}

	public void setSpotcommentDAO(SpotcommentDAO spotcommentDAO) {
		this.spotcommentDAO = spotcommentDAO;
	}
	public List getSpotcommentBySpotid(String id)
	{
		return spotcommentDAO.findBySpotid(new Integer(id));
	}
	
	// ���ָ������Ա
	public Viewspot viewspotByID(Integer id)
	{
		return viewspotDAO.findById(id);
	}
	
	
	
	//���ȫ������Ա 
	public List viewspotAll()
	{
		//System.out.println("55");
		return viewspotDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List viewspotLikeNameOrId(String value)
	{
		return viewspotDAO.findByLikeNameOrId(value);
	}
	//��id�����ֽ���ģ����ѯ 
	public List viewspotLikeNameOrId(String value,String city)
	{
		return viewspotDAO.findByLikeNameOrId(value,city);
	}	
	
	public List findAllCity()
	{
		return viewspotDAO.findAllCity();
	}
	
	// ��ӹ���Ա
	public void viewspotAdd(Viewspot user)
	{
		viewspotDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void viewspotDelete(Viewspot user)
	{
		viewspotDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void viewspotModify(Viewspot user)
	{
		viewspotDAO.merge(user);
	}
	
	
}
