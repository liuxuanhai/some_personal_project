package com.pojo;

/**
 * Roomtype entity. @author MyEclipse Persistence Tools
 */

public class Roomtype implements java.io.Serializable {

	// Fields

	private Integer roomid;
	private Integer hotelid;
	private String roomname;
	private String roomdescr;
	private Double roomprice;

	// Constructors

	/** default constructor */
	public Roomtype() {
	}

	/** minimal constructor */
	public Roomtype(Double roomprice) {
		this.roomprice = roomprice;
	}

	/** full constructor */
	public Roomtype(Integer hotelid, String roomname, String roomdescr,
			Double roomprice) {
		this.hotelid = hotelid;
		this.roomname = roomname;
		this.roomdescr = roomdescr;
		this.roomprice = roomprice;
	}

	// Property accessors

	public Integer getRoomid() {
		return this.roomid;
	}

	public void setRoomid(Integer roomid) {
		this.roomid = roomid;
	}

	public Integer getHotelid() {
		return this.hotelid;
	}

	public void setHotelid(Integer hotelid) {
		this.hotelid = hotelid;
	}

	public String getRoomname() {
		return this.roomname;
	}

	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}

	public String getRoomdescr() {
		return this.roomdescr;
	}

	public void setRoomdescr(String roomdescr) {
		this.roomdescr = roomdescr;
	}

	public Double getRoomprice() {
		return this.roomprice;
	}

	public void setRoomprice(Double roomprice) {
		this.roomprice = roomprice;
	}

}