package com.pojo;

/**
 * Viewspot entity. @author MyEclipse Persistence Tools
 */

public class Viewspot implements java.io.Serializable {

	// Fields

	private Integer spotid;
	private String spotname;
	private String spotcity;
	private String spotaddr;
	private String spotdescr;
	private Double spotprice;
	private String spotremark;
	private String sportimage;

	// Constructors

	/** default constructor */
	public Viewspot() {
	}

	/** full constructor */
	public Viewspot(String spotname, String spotcity, String spotaddr,
			String spotdescr, Double spotprice, String spotremark,
			String sportimage) {
		this.spotname = spotname;
		this.spotcity = spotcity;
		this.spotaddr = spotaddr;
		this.spotdescr = spotdescr;
		this.spotprice = spotprice;
		this.spotremark = spotremark;
		this.sportimage = sportimage;
	}

	// Property accessors

	public Integer getSpotid() {
		return this.spotid;
	}

	public void setSpotid(Integer spotid) {
		this.spotid = spotid;
	}

	public String getSpotname() {
		return this.spotname;
	}

	public void setSpotname(String spotname) {
		this.spotname = spotname;
	}

	public String getSpotcity() {
		return this.spotcity;
	}

	public void setSpotcity(String spotcity) {
		this.spotcity = spotcity;
	}

	public String getSpotaddr() {
		return this.spotaddr;
	}

	public void setSpotaddr(String spotaddr) {
		this.spotaddr = spotaddr;
	}

	public String getSpotdescr() {
		return this.spotdescr;
	}

	public void setSpotdescr(String spotdescr) {
		this.spotdescr = spotdescr;
	}

	public Double getSpotprice() {
		return this.spotprice;
	}

	public void setSpotprice(Double spotprice) {
		this.spotprice = spotprice;
	}

	public String getSpotremark() {
		return this.spotremark;
	}

	public void setSpotremark(String spotremark) {
		this.spotremark = spotremark;
	}

	public String getSportimage() {
		return this.sportimage;
	}

	public void setSportimage(String sportimage) {
		this.sportimage = sportimage;
	}

}