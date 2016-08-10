package com.service;
import com.dao.GoodorderDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Goodorder;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GoodorderService {
	//����ע��
	private GoodorderDAO goodorderDAO;
	
	public GoodorderDAO getGoodorderDAO() {
		return goodorderDAO;
	}

	public void setGoodorderDAO(GoodorderDAO goodorderDAO) {
		this.goodorderDAO = goodorderDAO;
	}
	
	// ���ָ������Ա
	public Goodorder goodorderByID(String id)
	{
		return goodorderDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List goodorderAll()
	{
		//System.out.println("55");
		return goodorderDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List goodorderLikeNameOrId(String value,String starttime,String endtime) throws ParseException
	{
		
		return goodorderDAO.findByLikeNameOrId(value,getDateFromString(starttime),getDateFromString(endtime));
	}
		
	// �ַ���ת����
	public Date getDateFromString(String in) throws ParseException
	{
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
		return sdf.parse(in);
	}
	// ��ӹ���Ա
	public void goodorderAdd(Goodorder user)
	{
		goodorderDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void goodorderDelete(Goodorder user)
	{
		goodorderDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void goodorderModify(Goodorder user)
	{
		goodorderDAO.merge(user);
	}	
}
