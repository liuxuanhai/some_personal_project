package com.service;
import com.dao.GoodcommentDAO;
import com.dao.GoodorderDAO;
import com.dao.GoodorderinfoDAO;
import com.dao.HotelcommentDAO;
import com.dao.HotelorderDAO;
import com.dao.SpotcommentDAO;
import com.dao.SpotorderDAO;
import com.dao.SpotuserDAO;
import com.pojo.Goodcomment;
import com.pojo.Goodorder;
import com.pojo.Hotelcomment;
import com.pojo.Hotelorder;
import com.pojo.Spotcomment;
import com.pojo.Spotorder;
import com.pojo.Spotuser;
import com.util.StringUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
//管理员表 逻辑接口封装
public class SpotuserService {
	//依赖注入
	private SpotuserDAO spotuserDAO;

	public SpotuserDAO getSpotuserDAO() {
		return spotuserDAO;
	}

	public void setSpotuserDAO(SpotuserDAO spotuserDAO) {
		this.spotuserDAO = spotuserDAO;
	}
	
	// 验证登录
	public boolean spotuserLogin(String name,String pwd)
	{
		return spotuserDAO.userLogin(name,pwd);
	}
	
	public boolean spotuserIsExist(String username)
	{
		if(spotuserDAO.findByUsername(username).size()>0)
			return true;
		else
			return false;
	}
	
	public void saveSpotOrder(Spotorder order)
	{
		spotorderDAO.save(order);
	}
	//依赖注入
	private SpotorderDAO spotorderDAO;
	
	public SpotorderDAO getSpotorderDAO() {
		return spotorderDAO;
	}

	public void setSpotorderDAO(SpotorderDAO spotorderDAO) {
		this.spotorderDAO = spotorderDAO;
	}
	
	//依赖注入
	private HotelorderDAO hotelorderDAO;
	public HotelorderDAO getHotelorderDAO() {
		return hotelorderDAO;
	}

	public void setHotelorderDAO(HotelorderDAO hotelorderDAO) {
		this.hotelorderDAO = hotelorderDAO;
	}
	public void saveHotelOrder(Hotelorder order)
	{
		hotelorderDAO.save(order);
	}
	
	// 获得指定管理员
	public Spotuser spotuserByID(Integer id)
	{
		return spotuserDAO.findById(id);
	}
	// 获得指定管理员
	public Spotuser spotuserByUsername(String username)
	{
		List<Spotuser> list=spotuserDAO.findByUsername(username);
		if(list.size()>0) 
			return list.get(0);
		else
			return null;
	}
	
	//获得全部管理员 
	public List spotuserAll()
	{
		//System.out.println("55");
		return spotuserDAO.findAll();
	}
	
	//对id或名字进行模糊查询 
	public List spotuserLikeNameOrId(String value)
	{
		return spotuserDAO.findByLikeNameOrId(value);
	}
		
	
	// 添加管理员
	public void spotuserAdd(Spotuser user)
	{
		spotuserDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// 删除管理员
	public void spotuserDelete(Spotuser user)
	{
		spotuserDAO.delete(user);
	}
	
	// 修改管理员 对吗？
	public void spotuserModify(Spotuser user)
	{
		spotuserDAO.merge(user);
	}
	//依赖注入
	private GoodorderDAO goodorderDAO;
	
	public GoodorderDAO getGoodorderDAO() {
		return goodorderDAO;
	}

	public void setGoodorderDAO(GoodorderDAO goodorderDAO) {
		this.goodorderDAO = goodorderDAO;
	}
	//依赖注入
	private GoodorderinfoDAO goodorderinfoDAO;
	
	public GoodorderinfoDAO getGoodorderinfoDAO() {
		return goodorderinfoDAO;
	}

	public void setGoodorderinfoDAO(GoodorderinfoDAO goodorderinfoDAO) {
		this.goodorderinfoDAO = goodorderinfoDAO;
	}
	public List getOrderListByUserAndType(String username,String type)
	{
		if(type.equals("0"))
			return spotorderDAO.findByUsername(username);
		else if(type.equals("1"))
			return hotelorderDAO.findByUsername(username);
		else
		{
			List<Object[]> list=new ArrayList<Object[]>();
			List<Goodorder> ll=goodorderDAO.findByUsername(username);
			for(int i=0;i<ll.size();++i)
			{
				Object[] obj=new Object[2];
				obj[0]=ll.get(i);  //订单
				obj[1]=goodorderinfoDAO.findByOrderid(ll.get(i).getOrderid());
				list.add(obj);
			}
			return list;
		}
	}
	//依赖注入
		private GoodcommentDAO goodcommentDAO;

		public GoodcommentDAO getGoodcommentDAO() {
			return goodcommentDAO;
		}

		public void setGoodcommentDAO(GoodcommentDAO goodcommentDAO) {
			this.goodcommentDAO = goodcommentDAO;
		}
		//依赖注入
		private HotelcommentDAO hotelcommentDAO;

		public HotelcommentDAO getHotelcommentDAO() {
			return hotelcommentDAO;
		}

		public void setHotelcommentDAO(HotelcommentDAO hotelcommentDAO) {
			this.hotelcommentDAO = hotelcommentDAO;
		}
		//依赖注入
		private SpotcommentDAO spotcommentDAO;

		public SpotcommentDAO getSpotcommentDAO() {
			return spotcommentDAO;
		}

		public void setSpotcommentDAO(SpotcommentDAO spotcommentDAO) {
			this.spotcommentDAO = spotcommentDAO;
		}
	
	//添加评论
	public void addcomment(String type,String id,String username,String content,String userid)throws Exception
	{
		if(type.equals("0"))
		{
			Spotcomment item=new Spotcomment();
			item.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			item.setContent(content);
			item.setUsername(username);
			item.setUserid(new Integer(userid));
			item.setSpotid(new Integer(id));
			spotcommentDAO.save(item);
		}
		else if(type.equals("1"))
		{
			Hotelcomment item=new Hotelcomment();
			item.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			item.setContent(content);
			item.setUsername(username);
			item.setUserid(new Integer(userid));
			item.setHotelid(new Integer(id));
			hotelcommentDAO.save(item);
		}
		else
		{
			Goodcomment item=new Goodcomment();
			item.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			item.setContent(content);
			item.setUsername(username);
			item.setUserid(new Integer(userid));
			item.setGoodid(new Integer(id));
			goodcommentDAO.save(item);
		}
	}
}
