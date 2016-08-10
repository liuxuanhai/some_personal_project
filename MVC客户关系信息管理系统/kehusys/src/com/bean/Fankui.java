package com.bean;

import java.sql.Timestamp;

// ·´À¡
public class Fankui {
	private int id;
	private String name;
	private String personname;
	private String content;
	private String reamrk;
	private Timestamp addtime;
	private int yuangongid;
	private String ygname;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getPersonname() {
		return personname;
	}
	public void setPersonname(String personname) {
		this.personname = personname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReamrk() {
		return reamrk;
	}
	public void setReamrk(String reamrk) {
		this.reamrk = reamrk;
	}
	public Timestamp getAddtime() {
		return addtime;
	}
	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}
	public int getYuangongid() {
		return yuangongid;
	}
	public void setYuangongid(int yuangongid) {
		this.yuangongid = yuangongid;
	}
	public String getYgname() {
		return ygname;
	}
	public void setYgname(String ygname) {
		this.ygname = ygname;
	}
}
