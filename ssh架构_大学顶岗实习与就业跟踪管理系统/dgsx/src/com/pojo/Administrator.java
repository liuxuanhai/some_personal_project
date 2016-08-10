package com.pojo;

/**
 * Administrator entity. @author MyEclipse Persistence Tools
 */

public class Administrator implements java.io.Serializable {

	// Fields

	private Integer adminid;
	private String username;
	private String passwd;

	// Constructors

	/** default constructor */
	public Administrator() {
	}

	/** full constructor */
	public Administrator(String username, String passwd) {
		this.username = username;
		this.passwd = passwd;
	}

	// Property accessors

	public Integer getAdminid() {
		return this.adminid;
	}

	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPasswd() {
		return this.passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

}