package com.service;
import com.dao.HotelDAO;
import com.dao.HotelcommentDAO;
import com.dao.RoomtypeDAO;
import com.dao.ViewspotDAO;
import com.pojo.Hotel;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class HotelService {
	//����ע��
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	
	//����ע��
	private RoomtypeDAO roomtypeDAO;

	public RoomtypeDAO getRoomtypeDAO() {
		return roomtypeDAO;
	}

	public void setRoomtypeDAO(RoomtypeDAO roomtypeDAO) {
		this.roomtypeDAO = roomtypeDAO;
	}
	// ��þƵ귿��
	public List getRoomtypeByHotelid(String id)
	{
		return roomtypeDAO.findByHotelid(new Integer(id));
	}
	//����ע��
	private ViewspotDAO viewspotDAO;

	public ViewspotDAO getViewspotDAO() {
		return viewspotDAO;
	}

	// ���ָ�����еľ���
	public List getViewspotByCity(String city)
	{
		return viewspotDAO.findBySpotcity(city);
	}
	
	public void setViewspotDAO(ViewspotDAO viewspotDAO) {
		this.viewspotDAO = viewspotDAO;
	}
	//����ע��
	private HotelcommentDAO hotelcommentDAO;

	public HotelcommentDAO getHotelcommentDAO() {
		return hotelcommentDAO;
	}

	public void setHotelcommentDAO(HotelcommentDAO hotelcommentDAO) {
		this.hotelcommentDAO = hotelcommentDAO;
	}
	//��þ�������
	public List getHotelcommentByHotelid(String id)
	{
		return hotelcommentDAO.findByHotelid(new Integer(id));
	}
	// ���ָ������Ա
	public Hotel hotelByID(Integer id)
	{
		return hotelDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List hotelAll()
	{
		//System.out.println("55");
		return hotelDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List hotelLikeNameOrId(String value)
	{
		return hotelDAO.findByLikeNameOrId(value);
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List hotelLikeNameAndCity(String value,String city)
	{
		return hotelDAO.findByLikeNameOrId(value,city);
	}
	
	public List findAllCity()
	{
		return hotelDAO.findAllCity();
	}	
	
	// ��ӹ���Ա
	public void hotelAdd(Hotel user)
	{
		hotelDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void hotelDelete(Hotel user)
	{
		hotelDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void hotelModify(Hotel user)
	{
		hotelDAO.merge(user);
	}
	
	
}
