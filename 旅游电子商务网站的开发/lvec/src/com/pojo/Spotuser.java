package com.pojo;

/**
 * Spotuser entity. @author MyEclipse Persistence Tools
 */

public class Spotuser implements java.io.Serializable {

	// Fields

	private Integer userid;
	private String username;
	private String userpwd;
	private String phone;
	private String addr;
	private String name;
	// Constructors

	/** default constructor */
	public Spotuser() {
	}

	/** full constructor */
	public Spotuser(String username, String userpwd, String phone, String addr,String name) {
		this.username = username;
		this.userpwd = userpwd;
		this.phone = phone;
		this.addr = addr;
		this.name=name;
	}

	// Property accessors

	public Integer getUserid() {
		return this.userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpwd() {
		return this.userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return this.addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}