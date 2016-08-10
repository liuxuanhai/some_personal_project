package com.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBManager {
	private String driver="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://localhost:3306/kehusys?useUnicode=true&characterEncoding=UTF-8";
	private String username="root";
	private String password="55555";
	public  static Connection connection =null;
	private static DBManager dbManager=null;
	private DBManager()
	{
		try
		{
			Class.forName(driver);
			connection=DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			System.out.println("找不到驱动类");
		} catch (SQLException e) {
			System.out.println("数据库连接异常");
		}
		
	}
	public static DBManager getDBManager()
	{
		if (null==dbManager) {
			dbManager=new DBManager();
		}
		return dbManager;
	}
}
