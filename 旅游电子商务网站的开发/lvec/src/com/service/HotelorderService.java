package com.service;
import com.dao.HotelorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Hotelorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class HotelorderService {
	//����ע��
	private HotelorderDAO hotelorderDAO;
	public HotelorderDAO getHotelorderDAO() {
		return hotelorderDAO;
	}

	public void setHotelorderDAO(HotelorderDAO hotelorderDAO) {
		this.hotelorderDAO = hotelorderDAO;
	}
	
	// ���ָ������Ա
	public Hotelorder hotelorderByID(String id)
	{
		return hotelorderDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List hotelorderAll()
	{
		//System.out.println("55");
		return hotelorderDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List hotelorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return hotelorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// �ַ���ת����
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// ��ӹ���Ա
	public void hotelorderAdd(Hotelorder user)
	{
		hotelorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void hotelorderDelete(Hotelorder user)
	{
		hotelorderDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void hotelorderModify(Hotelorder user)
	{
		hotelorderDAO.merge(user);
	}
}
