package com.pojo;

/**
 * Hotel entity. @author MyEclipse Persistence Tools
 */

public class Hotel implements java.io.Serializable {

	// Fields

	private Integer hotelid;
	private String hotelname;
	private String hotelcity;
	private String hoteladdr;
	private String hoteldescr;
	private String hotelremark;
	private Double hotelprice;
	private String hotelimage;

	// Constructors

	/** default constructor */
	public Hotel() {
	}

	/** full constructor */
	public Hotel(String hotelname, String hotelcity, String hoteladdr,
			String hoteldescr, String hotelremark, Double hotelprice,
			String hotelimage) {
		this.hotelname = hotelname;
		this.hotelcity = hotelcity;
		this.hoteladdr = hoteladdr;
		this.hoteldescr = hoteldescr;
		this.hotelremark = hotelremark;
		this.hotelprice = hotelprice;
		this.hotelimage = hotelimage;
	}

	// Property accessors

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

	public String getHotelcity() {
		return this.hotelcity;
	}

	public void setHotelcity(String hotelcity) {
		this.hotelcity = hotelcity;
	}

	public String getHoteladdr() {
		return this.hoteladdr;
	}

	public void setHoteladdr(String hoteladdr) {
		this.hoteladdr = hoteladdr;
	}

	public String getHoteldescr() {
		return this.hoteldescr;
	}

	public void setHoteldescr(String hoteldescr) {
		this.hoteldescr = hoteldescr;
	}

	public String getHotelremark() {
		return this.hotelremark;
	}

	public void setHotelremark(String hotelremark) {
		this.hotelremark = hotelremark;
	}

	public Double getHotelprice() {
		return this.hotelprice;
	}

	public void setHotelprice(Double hotelprice) {
		this.hotelprice = hotelprice;
	}

	public String getHotelimage() {
		return this.hotelimage;
	}

	public void setHotelimage(String hotelimage) {
		this.hotelimage = hotelimage;
	}

}