package com.service;
import com.dao.GoodorderinfoDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Goodorderinfo;
import com.pojo.Goodtype;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GoodorderinfoService {
	//����ע��
	private GoodorderinfoDAO goodorderinfoDAO;
	
	public GoodorderinfoDAO getGoodorderinfoDAO() {
		return goodorderinfoDAO;
	}

	public void setGoodorderinfoDAO(GoodorderinfoDAO goodorderinfoDAO) {
		this.goodorderinfoDAO = goodorderinfoDAO;
	}
	
	
	//���ָ���������굥
	public List goodorderinfoAll(String orderid)
	{
		//System.out.println("55");
		return goodorderinfoDAO.findByOrderid(orderid);
	}
	
		
	// ��ӹ���Ա
	public void goodorderinfoAdd(Goodorderinfo user)
	{
		goodorderinfoDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void goodorderinfoDelete(Goodorderinfo user)
	{
		goodorderinfoDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void goodorderinfoModify(Goodorderinfo user)
	{
		goodorderinfoDAO.merge(user);
	}	
}
