package com.pojo;

import java.sql.Timestamp;

/**
 * Goodorder entity. @author MyEclipse Persistence Tools
 */

public class Goodorder implements java.io.Serializable {

	// Fields

	private String orderid;
	private String username;
	private Double totalprice;
	private Timestamp ordertime;
	private String orderstatus;
	private String name;
	private String phone;
	private String addr;

	// Constructors

	/** default constructor */
	public Goodorder() {
	}

	/** minimal constructor */
	public Goodorder(String orderid) {
		this.orderid = orderid;
	}

	/** full constructor */
	public Goodorder(String orderid, String username, Double totalprice,
			Timestamp ordertime, String orderstatus, String name, String phone,
			String addr) {
		this.orderid = orderid;
		this.username = username;
		this.totalprice = totalprice;
		this.ordertime = ordertime;
		this.orderstatus = orderstatus;
		this.name = name;
		this.phone = phone;
		this.addr = addr;
	}

	// Property accessors

	public String getOrderid() {
		return this.orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
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

	public String getOrderstatus() {
		return this.orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
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

	public String getAddr() {
		return this.addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

}