package com.pojo;

/**
 * Goodinfo entity. @author MyEclipse Persistence Tools
 */

public class Goodinfo1 implements java.io.Serializable {

	// Fields

	private Integer goodid;
	private String goodname;
	private String gooddescr;
	private Double goodprice;
	private Integer goodnum;
	private Integer typeid;
	private String goodimage;
	private String typename;
	// Constructors

	/** default constructor */
	public Goodinfo1() {
	}

	/** full constructor */
	public Goodinfo1(String goodname, String gooddescr, Double goodprice,
			Integer goodnum, Integer typeid, String goodimage) {
		this.goodname = goodname;
		this.gooddescr = gooddescr;
		this.goodprice = goodprice;
		this.goodnum = goodnum;
		this.typeid = typeid;
		this.goodimage = goodimage;
	}
	
	/** full constructor */
	public Goodinfo1(Goodinfo info) {
		this.goodname = info.getGoodname();
		this.gooddescr = info.getGooddescr();
		this.goodprice = info.getGoodprice();
		this.goodnum =info.getGoodnum();
		this.typeid = info.getTypeid();
		this.goodimage = info.getGoodimage();
		this.goodid=info.getGoodid();
	}

	// Property accessors

	public Integer getGoodid() {
		return this.goodid;
	}

	public void setGoodid(Integer goodid) {
		this.goodid = goodid;
	}

	public String getGoodname() {
		return this.goodname;
	}

	public void setGoodname(String goodname) {
		this.goodname = goodname;
	}

	public String getGooddescr() {
		return this.gooddescr;
	}

	public void setGooddescr(String gooddescr) {
		this.gooddescr = gooddescr;
	}

	public Double getGoodprice() {
		return this.goodprice;
	}

	public void setGoodprice(Double goodprice) {
		this.goodprice = goodprice;
	}

	public Integer getGoodnum() {
		return this.goodnum;
	}

	public void setGoodnum(Integer goodnum) {
		this.goodnum = goodnum;
	}

	public Integer getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getGoodimage() {
		return this.goodimage;
	}

	public void setGoodimage(String goodimage) {
		this.goodimage = goodimage;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

}