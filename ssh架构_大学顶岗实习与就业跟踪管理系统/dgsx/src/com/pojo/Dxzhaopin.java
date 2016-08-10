package com.pojo;

import java.sql.Timestamp;

/**
 * Dxzhaopin entity. @author MyEclipse Persistence Tools
 */

public class Dxzhaopin implements java.io.Serializable {

	// Fields

	private Integer id;
	private String title;
	private String content;
	private String cydw;
	private Timestamp addtime;
	private Integer looknum;

	// Constructors

	/** default constructor */
	public Dxzhaopin() {
	}

	/** full constructor */
	public Dxzhaopin(String title, String content, String cydw,
			Timestamp addtime, Integer looknum) {
		this.title = title;
		this.content = content;
		this.cydw = cydw;
		this.addtime = addtime;
		this.looknum = looknum;
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

	public String getCydw() {
		return this.cydw;
	}

	public void setCydw(String cydw) {
		this.cydw = cydw;
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

}