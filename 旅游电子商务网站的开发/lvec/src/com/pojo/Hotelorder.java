package com.pojo;

import java.sql.Timestamp;

/**
 * Hotelorder entity. @author MyEclipse Persistence Tools
 */

public class Hotelorder implements java.io.Serializable {

	// Fields

	private String orderid;
	private Integer hotelid;
	private String hotelname;
	private Integer roomid;
	private String roomname;
	private Double roomprice;
	private String username;
	private String name;
	private String phone;
	private Integer nums;
	private Double totalprice;
	private Timestamp ordertime;
	private Timestamp checkintime;
	private String orderstatus;

	// Constructors

	/** default constructor */
	public Hotelorder() {
	}

	/** minimal constructor */
	public Hotelorder(String orderid) {
		this.orderid = orderid;
	}

	/** full constructor */
	public Hotelorder(String orderid, Integer hotelid, String hotelname,
			Integer roomid, String roomname, Double roomprice, String username,
			String name, String phone, Integer nums, Double totalprice,
			Timestamp ordertime, Timestamp checkintime, String orderstatus) {
		this.orderid = orderid;
		this.hotelid = hotelid;
		this.hotelname = hotelname;
		this.roomid = roomid;
		this.roomname = roomname;
		this.roomprice = roomprice;
		this.username = username;
		this.name = name;
		this.phone = phone;
		this.nums = nums;
		this.totalprice = totalprice;
		this.ordertime = ordertime;
		this.checkintime = checkintime;
		this.orderstatus = orderstatus;
	}

	// Property accessors

	public String getOrderid() {
		return this.orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public Integer getHotelid() {
		return this.hotelid;
	}

	public void setHotelid(Integer hotelid) {
		this.hotelid = hotelid;
	}

	public String getHotelname() {
		return this.hotelname;
	}

	public void setHotelname(String hotelname) {
		this.hotelname = hotelname;
	}

	public Integer getRoomid() {
		return this.roomid;
	}

	public void setRoomid(Integer roomid) {
		this.roomid = roomid;
	}

	public String getRoomname() {
		return this.roomname;
	}

	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}

	public Double getRoomprice() {
		return this.roomprice;
	}

	public void setRoomprice(Double roomprice) {
		this.roomprice = roomprice;
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

	public Timestamp getCheckintime() {
		return this.checkintime;
	}

	public void setCheckintime(Timestamp checkintime) {
		this.checkintime = checkintime;
	}

	public String getOrderstatus() {
		return this.orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

}