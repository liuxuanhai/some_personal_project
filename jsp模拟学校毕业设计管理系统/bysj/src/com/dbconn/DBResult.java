package com.dbconn;

import java.sql.*;

import javax.naming.*;
import javax.sql.DataSource;

public class DBResult {
	public static Connection conn = null;
	private static String driverClass = "com.mysql.jdbc.Driver";
	private static String URL = "jdbc:mysql://localhost:3306/bysj?useUnicode=true&characterEncoding=UTF-8";
	private static String user="root";
	private static String pwd = "55555";
	static{
		try {
			Class.forName(driverClass);
			conn = DriverManager.getConnection(URL, user, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * ���ڻ��ִ��SQL����ResultSet����
	 */
	public ResultSet getResult(String sql) {
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			return rs;
		} catch (Exception e) {
		}
		return null;
	}

	/**
	 * ����ִ��SQL���û�з���ֵ
	 */
	public void doExecute(String sql) {
		try {
			Statement stmt = conn.createStatement();
			
			stmt.executeUpdate(sql);
		} catch (Exception e) {
		}
	}

	/**
	 * ���ڻ��ִ��SQL����PreparedStatement(Ԥ����)����
	 */
	public PreparedStatement getPreparedStatement(String sql) {
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			return pstmt;
		} catch (Exception e) {
		}
		return null;
	}

}
