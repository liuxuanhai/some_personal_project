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
//管理员表 逻辑接口封装
public class GoodorderinfoService {
	//依赖注入
	private GoodorderinfoDAO goodorderinfoDAO;
	
	public GoodorderinfoDAO getGoodorderinfoDAO() {
		return goodorderinfoDAO;
	}

	public void setGoodorderinfoDAO(GoodorderinfoDAO goodorderinfoDAO) {
		this.goodorderinfoDAO = goodorderinfoDAO;
	}
	
	
	//获得指定订单的详单
	public List goodorderinfoAll(String orderid)
	{
		//System.out.println("55");
		return goodorderinfoDAO.findByOrderid(orderid);
	}
	
		
	// 添加管理员
	public void goodorderinfoAdd(Goodorderinfo user)
	{
		goodorderinfoDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void goodorderinfoDelete(Goodorderinfo user)
	{
		goodorderinfoDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void goodorderinfoModify(Goodorderinfo user)
	{
		goodorderinfoDAO.merge(user);
	}	
}
