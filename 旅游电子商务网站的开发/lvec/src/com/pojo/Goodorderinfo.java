package com.pojo;

/**
 * Goodorderinfo entity. @author MyEclipse Persistence Tools
 */

public class Goodorderinfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private String orderid;
	private Integer goodid;
	private String goodname;
	private Double goodprice;
	private Integer nums;
	private Double totalprice;

	// Constructors

	/** default constructor */
	public Goodorderinfo() {
	}

	/** full constructor */
	public Goodorderinfo(String orderid, Integer goodid, String goodname,
			Double goodprice, Integer nums, Double totalprice) {
		this.orderid = orderid;
		this.goodid = goodid;
		this.goodname = goodname;
		this.goodprice = goodprice;
		this.nums = nums;
		this.totalprice = totalprice;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getOrderid() {
		return this.orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

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

	public Double getGoodprice() {
		return this.goodprice;
	}

	public void setGoodprice(Double goodprice) {
		this.goodprice = goodprice;
	}

	public Integer getNums() {
		return this.nums;
	}

	public void setNums(Integer nums) {
		this.nums = nums;
	}

	public Double getTotalprice() {
		return this.totalprice;
	}

	public void setTotalprice(Double totalprice) {
		this.totalprice = totalprice;
	}

}