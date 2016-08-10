package com.pojo;

/**
 * Studentdocument entity. @author MyEclipse Persistence Tools
 */

public class Studentdocument implements java.io.Serializable {

	// Fields

	private Integer id;
	private String stuid;
	private String papername;
	private String paperurl;
	private String paperstatus;
	private String papertype;
	private String remark;

	// Constructors

	/** default constructor */
	public Studentdocument() {
	}

	/** full constructor */
	public Studentdocument(String stuid, String papername, String paperurl,
			String paperstatus, String papertype, String remark) {
		this.stuid = stuid;
		this.papername = papername;
		this.paperurl = paperurl;
		this.paperstatus = paperstatus;
		this.papertype = papertype;
		this.remark = remark;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStuid() {
		return this.stuid;
	}

	public void setStuid(String stuid) {
		this.stuid = stuid;
	}

	public String getPapername() {
		return this.papername;
	}

	public void setPapername(String papername) {
		this.papername = papername;
	}

	public String getPaperurl() {
		return this.paperurl;
	}

	public void setPaperurl(String paperurl) {
		this.paperurl = paperurl;
	}

	public String getPaperstatus() {
		return this.paperstatus;
	}

	public void setPaperstatus(String paperstatus) {
		this.paperstatus = paperstatus;
	}

	public String getPapertype() {
		return this.papertype;
	}

	public void setPapertype(String papertype) {
		this.papertype = papertype;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}