package com.pojo;

import java.sql.Timestamp;

/**
 * Goodcomment entity. @author MyEclipse Persistence Tools
 */

public class Goodcomment implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer goodid;
	private Integer userid;
	private String username;
	private String content;
	private Timestamp addtime;

	// Constructors

	/** default constructor */
	public Goodcomment() {
	}

	/** full constructor */
	public Goodcomment(Integer goodid, Integer userid, String username,
			String content, Timestamp addtime) {
		this.goodid = goodid;
		this.userid = userid;
		this.username = username;
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

	public Integer getGoodid() {
		return this.goodid;
	}

	public void setGoodid(Integer goodid) {
		this.goodid = goodid;
	}

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

}