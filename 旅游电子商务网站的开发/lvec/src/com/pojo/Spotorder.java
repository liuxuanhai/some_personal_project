package com.pojo;

import java.sql.Timestamp;

/**
 * Spotorder entity. @author MyEclipse Persistence Tools
 */

public class Spotorder implements java.io.Serializable {

	// Fields

	private String orderid;
	private Integer spotid;
	private String spotname;
	private Double spotprice;
	private String username;
	private String name;
	private String phone;
	private Integer nums;
	private Double totalprice;
	private Timestamp ordertime;
	private Timestamp tratime;
	private String orderstatus;

	// Constructors

	/** default constructor */
	public Spotorder() {
	}

	/** minimal constructor */
	public Spotorder(String orderid) {
		this.orderid = orderid;
	}

	/** full constructor */
	public Spotorder(String orderid, Integer spotid, String spotname,
			Double spotprice, String username, String name, String phone,
			Integer nums, Double totalprice, Timestamp ordertime,
			Timestamp tratime, String orderstatus) {
		this.orderid = orderid;
		this.spotid = spotid;
		this.spotname = spotname;
		this.spotprice = spotprice;
		this.username = username;
		this.name = name;
		this.phone = phone;
		this.nums = nums;
		this.totalprice = totalprice;
		this.ordertime = ordertime;
		this.tratime = tratime;
		this.orderstatus = orderstatus;
	}

	// Property accessors

	public String getOrderid() {
		return this.orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

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

	public Double getSpotprice() {
		return this.spotprice;
	}

	public void setSpotprice(Double spotprice) {
		this.spotprice = spotprice;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
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

	public Timestamp getOrdertime() {
		return this.ordertime;
	}

	public void setOrdertime(Timestamp ordertime) {
		this.ordertime = ordertime;
	}

	public Timestamp getTratime() {
		return this.tratime;
	}

	public void setTratime(Timestamp tratime) {
		this.tratime = tratime;
	}

	public String getOrderstatus() {
		return this.orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

}