package com.pojo;

import java.sql.Timestamp;

/**
 * Gonggao entity. @author MyEclipse Persistence Tools
 */

public class Gonggao implements java.io.Serializable {

	// Fields

	private Integer id;
	private String title;
	private String content;
	private Timestamp addtime;
	private Integer looknum;
	private String filename;
	private String filepath;

	// Constructors

	/** default constructor */
	public Gonggao() {
	}

	/** full constructor */
	public Gonggao(String title, String content, Timestamp addtime,
			Integer looknum, String filename, String filepath) {
		this.title = title;
		this.content = content;
		this.addtime = addtime;
		this.looknum = looknum;
		this.filename = filename;
		this.filepath = filepath;
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

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return this.filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

}