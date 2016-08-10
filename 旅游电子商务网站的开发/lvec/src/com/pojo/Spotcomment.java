package com.pojo;

import java.sql.Timestamp;

/**
 * Spotcomment entity. @author MyEclipse Persistence Tools
 */

public class Spotcomment implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer spotid;
	private Integer userid;
	private String content;
	private String username;
	private Timestamp addtime;

	// Constructors

	/** default constructor */
	public Spotcomment() {
	}

	/** full constructor */
	public Spotcomment(Integer spotid, Integer userid,String username, String content,
			Timestamp addtime) {
		this.spotid = spotid;
		this.userid = userid;
		this.username=username;
		this.content = content;
		this.addtime = addtime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSpotid() {
		return this.spotid;
	}

	public void setSpotid(Integer spotid) {
		this.spotid = spotid;
	}

	public Integer getUserid() {
		return this.userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getAddtime() {
		return this.addtime;
	}

	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}