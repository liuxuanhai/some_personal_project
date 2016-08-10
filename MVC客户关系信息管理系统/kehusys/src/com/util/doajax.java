package com.util;

import com.dao.YuangongDao;

public class doajax {
	public String adminLogin(String username,String pwd,String type)
	{
		YuangongDao item=new YuangongDao();
		return item.login(username, pwd,type);
	}
	public String getUserName(String id)
	{
		YuangongDao item=new YuangongDao();
		return item.getName(id);
	}
	public void modifypwd(String username,String pwd)
	{
		YuangongDao item=new YuangongDao();
		item.modifypwd(username,pwd);
	}
}
