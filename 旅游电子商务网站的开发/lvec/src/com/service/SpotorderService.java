package com.service;
import com.dao.SpotorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Spotorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class SpotorderService {
	//����ע��
	private SpotorderDAO spotorderDAO;
	
	public SpotorderDAO getSpotorderDAO() {
		return spotorderDAO;
	}

	public void setSpotorderDAO(SpotorderDAO spotorderDAO) {
		this.spotorderDAO = spotorderDAO;
	}
	
	// ���ָ������Ա
	public Spotorder spotorderByID(String id)
	{
		return spotorderDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List spotorderAll()
	{
		//System.out.println("55");
		return spotorderDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List spotorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return spotorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// �ַ���ת����
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// ��ӹ���Ա
	public void spotorderAdd(Spotorder user)
	{
		spotorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void spotorderDelete(Spotorder user)
	{
		spotorderDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void spotorderModify(Spotorder user)
	{
		spotorderDAO.merge(user);
	}	
}
