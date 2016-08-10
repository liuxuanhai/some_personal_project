package com.service;
import com.dao.GoodcommentDAO;
import com.dao.GoodinfoDAO;
import com.dao.GoodorderDAO;
import com.dao.GoodorderinfoDAO;
import com.dao.GoodtypeDAO;
import com.pojo.Goodinfo;
import com.pojo.Goodinfo1;
import com.pojo.Goodorder;
import com.pojo.Goodorderinfo;
import com.pojo.Goodtype;

import java.util.ArrayList;
import java.util.List;
//����Ա�� �߼��ӿڷ�װ
public class GoodinfoService {
	//����ע��
	private GoodinfoDAO goodinfoDAO;
	private GoodtypeDAO goodtypeDAO;
	
	public GoodinfoDAO getGoodinfoDAO() {
		return goodinfoDAO;
	}

	public void setGoodinfoDAO(GoodinfoDAO goodinfoDAO) {
		this.goodinfoDAO = goodinfoDAO;
	}
	
	
	// ���ָ������Ա
	public Goodinfo goodinfoByID(Integer id)
	{
		return goodinfoDAO.findById(id);
	}
	
	//���ȫ������Ա 
	public List goodinfoAll()
	{
		//System.out.println("55");
		return goodinfoDAO.findAll();
	}
	
	//��id�����ֽ���ģ����ѯ 
	public List goodinfoLikeNameOrId(String value)
	{
		List<Goodinfo> list=goodinfoDAO.findByLikeNameOrId("");
		List<Goodinfo1> list1=new ArrayList<Goodinfo1>();
		List<Goodtype> ltype=goodtypeDAO.findByLikeNameOrId("");
		Goodinfo1 info;
		for(int i=0;i<list.size();++i)
		{
			info=new Goodinfo1(list.get(i));
			info.setTypename("");
			for(int j=0;j<ltype.size();++j)
			{
				//System.out.println(info.getTypeid().toString()+":"+ltype.get(j).getTypeid().toString());
				if(ltype.get(j).getTypeid().toString().equals(info.getTypeid().toString()))
				{
					info.setTypename(ltype.get(j).getTypename()); 
					list1.add(info);
					break;
				}
			}
		}
		for(int i=list1.size()-1;i>=0;--i)
			if(!(list1.get(i).getGoodname().indexOf(value)>=0||list1.get(i).getTypename().indexOf(value)>=0))
				list1.remove(i);
		return list1;
	}
	
	
	//��id�����ֽ���ģ����ѯ 
		public List goodinfoLikeNameOrId(String value,String typeid)
		{
			List<Goodinfo> list=goodinfoDAO.findByLikeNameOrId("");
			List<Goodinfo1> list1=new ArrayList<Goodinfo1>();
			List<Goodtype> ltype=goodtypeDAO.findByLikeNameOrId("");
			Goodinfo1 info;
			for(int i=0;i<list.size();++i)
			{
				if(!(list.get(i).getTypeid().toString().indexOf(typeid)>=0))
					continue;
				info=new Goodinfo1(list.get(i));
				info.setTypename("");
				for(int j=0;j<ltype.size();++j)
				{
					if(ltype.get(j).getTypeid().toString().equals(info.getTypeid().toString()))
					{
						info.setTypename(ltype.get(j).getTypename()); 
						list1.add(info);
						break;
					}
				}
			}
			return list1;
		}
	
	// ��ӹ���Ա
	public void goodinfoAdd(Goodinfo user)
	{
		goodinfoDAO.save(user);
		//System.out.println(user.getUsername());
	}
	
	// ɾ������Ա
	public void goodinfoDelete(Goodinfo user)
	{
		goodinfoDAO.delete(user);
	}
	
	// �޸Ĺ���Ա ����
	public void goodinfoModify(Goodinfo user)
	{
		goodinfoDAO.merge(user);
	}

	public GoodtypeDAO getGoodtypeDAO() {
		return goodtypeDAO;
	}

	public void setGoodtypeDAO(GoodtypeDAO goodtypeDAO) {
		this.goodtypeDAO = goodtypeDAO;
	}
	
	// ������з���
	public List findAllGoodType()
	{
		return goodtypeDAO.findAll();
	}
	//����ע��
	private GoodcommentDAO goodcommentDAO;

	public GoodcommentDAO getGoodcommentDAO() {
		return goodcommentDAO;
	}

	public void setGoodcommentDAO(GoodcommentDAO goodcommentDAO) {
		this.goodcommentDAO = goodcommentDAO;
	}
	
	// �������
	public List getGoodcommentByGoodid(String id)
	{
		return goodcommentDAO.findByGoodid(new Integer(id));
	}
	//����ע��
	private GoodorderDAO goodorderDAO;
	
	public GoodorderDAO getGoodorderDAO() {
		return goodorderDAO;
	}

	public void setGoodorderDAO(GoodorderDAO goodorderDAO) {
		this.goodorderDAO = goodorderDAO;
	}
	//����ע��
	private GoodorderinfoDAO goodorderinfoDAO;
	
	public GoodorderinfoDAO getGoodorderinfoDAO() {
		return goodorderinfoDAO;
	}

	public void setGoodorderinfoDAO(GoodorderinfoDAO goodorderinfoDAO) {
		this.goodorderinfoDAO = goodorderinfoDAO;
	}
	public void goodorderinfoAdd(Goodorderinfo item)
	{
		goodorderinfoDAO.save(item);
	}
	public void goodorderAdd(Goodorder item)
	{
		goodorderDAO.save(item);
	}
}
