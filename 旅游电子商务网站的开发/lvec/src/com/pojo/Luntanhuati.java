package com.pojo;

import java.sql.Timestamp;

/**
 * Luntanhuati entity. @author MyEclipse Persistence Tools
 */

public class Luntanhuati implements java.io.Serializable {

	// Fields

	private Integer id;
	private String title;
	private String content;
	private Timestamp addtime;
	private Integer looknum;
	private String filepath;
	private String username;

	// Constructors

	/** default constructor */
	public Luntanhuati() {
	}

	/** full constructor */
	public Luntanhuati(String title, String content, Timestamp addtime,
			Integer looknum, String filepath, String username) {
		this.title = title;
		this.content = content;
		this.addtime = addtime;
		this.looknum = looknum;
		this.filepath = filepath;
		this.username = username;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public Integer getLooknum() {
		return this.looknum;
	}

	public void setLooknum(Integer looknum) {
		this.looknum = looknum;
	}

	public String getFilepath() {
		return this.filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}