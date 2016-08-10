package com.pojo;

import java.sql.Timestamp;

/**
 * Hotelcomment entity. @author MyEclipse Persistence Tools
 */

public class Hotelcomment implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer hotelid;
	private Integer userid;
	private String username;
	private String content;
	private Timestamp addtime;

	// Constructors

	/** default constructor */
	public Hotelcomment() {
	}

	/** full constructor */
	public Hotelcomment(Integer hotelid, Integer userid, String username,
			String content, Timestamp addtime) {
		this.hotelid = hotelid;
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

	public Integer getHotelid() {
		return this.hotelid;
	}

	public void setHotelid(Integer hotelid) {
		this.hotelid = hotelid;
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