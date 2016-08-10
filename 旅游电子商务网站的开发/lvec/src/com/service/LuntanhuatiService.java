package com.service;
import com.dao.LuntanhuatiDAO;
import com.pojo.Luntanhuati;

import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class LuntanhuatiService {
	//Luntanhuati����ע��
	private LuntanhuatiDAO LuntanhuatiDAO;

	public LuntanhuatiDAO getLuntanhuatiDAO() {
		return LuntanhuatiDAO;
	}

	public void setLuntanhuatiDAO(LuntanhuatiDAO LuntanhuatiDAO) {
		this.LuntanhuatiDAO = LuntanhuatiDAO;
	}
	
	
	//���ȫ����¼Luntanhuati
	public List LuntanhuatiAll()
	{
		return LuntanhuatiDAO.findAll();
	}	
	//���ȫ����¼Luntanhuati
	public List LuntanhuatiAll(String findinfo)
	{
		return LuntanhuatiDAO.findAll(findinfo);
	}	
	public Luntanhuati getLuntanhuati(String id)
	{
		return LuntanhuatiDAO.findById(new Integer(id));
	}
	
	public void modifyLuntanhuati(Luntanhuati item)
	{
		LuntanhuatiDAO.merge(item);
	}
	public void addLuntanhuati(Luntanhuati item)
	{
		LuntanhuatiDAO.save(item);
	}
}
