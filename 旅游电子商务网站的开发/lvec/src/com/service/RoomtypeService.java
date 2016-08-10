package com.service;
import com.dao.HotelDAO;
import com.dao.RoomtypeDAO;
import com.pojo.Hotel;
import com.pojo.Roomtype;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class RoomtypeService {
	//����ע��
	private RoomtypeDAO roomtypeDAO;

	public RoomtypeDAO getRoomtypeDAO() {
		return roomtypeDAO;
	}

	public void setRoomtypeDAO(RoomtypeDAO roomtypeDAO) {
		this.roomtypeDAO = roomtypeDAO;
	}
	private HotelDAO hotelDAO;

	public HotelDAO getHotelDAO() {
		return hotelDAO;
	}

	public void setHotelDAO(HotelDAO hotelDAO) {
		this.hotelDAO = hotelDAO;
	}
	// ��þƵ�����
	public String getHotelNameByHotelid(Integer id)
	{
		Hotel item=hotelDAO.findById(id);
		return item.getHotelname();
	}
	// ���ָ������Ա
	public Roomtype roomtypeByID(Integer id)
	{
		return roomtypeDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List roomtypeAll()
	{
		//System.out.println("55");
		return roomtypeDAO.findAll();
	}
	
	
	//���ָ���Ƶ�ķ���
	public List roomtypeAll(Integer hotelid)
	{
		//System.out.println("55");
		return roomtypeDAO.findByHotelid(hotelid);
	}
	
	// ��ӹ���Ա
	public void roomtypeAdd(Roomtype user)
	{
		roomtypeDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void roomtypeDelete(Roomtype user)
	{
		roomtypeDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void roomtypeModify(Roomtype user)
	{
		roomtypeDAO.merge(user);
	}
	
	
}
