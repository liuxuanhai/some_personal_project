package com.bean;

import java.sql.Timestamp;

// ¿Í»§
public class Ordermana {
	private String ordernum;
	private int yuangongid;
	private int customerid;
	private String kename;
	private String ygname;
	private double totalprice;
	private String remark;
	private Timestamp ordertime;
	public String getOrdernum() {
		return ordernum;
	}
	public void setOrdernum(String ordernum) {
		this.ordernum = ordernum;
	}
	public int getYuangongid() {
		return yuangongid;
	}
	public void setYuangongid(int yuangongid) {
		this.yuangongid = yuangongid;
	}
	public int getCustomerid() {
		return customerid;
	}
	public void setCustomerid(int customerid) {
		this.customerid = customerid;
	}
	public String getKename() {
		return kename;
	}
	public void setKename(String kename) {
		this.kename = kename;
	}
	public String getYgname() {
		return ygname;
	}
	public void setYgname(String ygname) {
		this.ygname = ygname;
	}
	public double getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(double totalprice) {
		this.totalprice = totalprice;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Timestamp getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(Timestamp ordertime) {
		this.ordertime = ordertime;
	}
	

}
