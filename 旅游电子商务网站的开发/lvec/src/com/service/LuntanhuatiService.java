package com.service;
import com.dao.LuntanhuatiDAO;
import com.pojo.Luntanhuati;

import java.util.List;
//管理员表 逻辑接口封装
public class LuntanhuatiService {
	//Luntanhuati依赖注入
	private LuntanhuatiDAO LuntanhuatiDAO;

	public LuntanhuatiDAO getLuntanhuatiDAO() {
		return LuntanhuatiDAO;
	}

	public void setLuntanhuatiDAO(LuntanhuatiDAO LuntanhuatiDAO) {
		this.LuntanhuatiDAO = LuntanhuatiDAO;
	}
	
	
	//获得全部记录Luntanhuati
	public List LuntanhuatiAll()
	{
		return LuntanhuatiDAO.findAll();
	}	
	//获得全部记录Luntanhuati
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
