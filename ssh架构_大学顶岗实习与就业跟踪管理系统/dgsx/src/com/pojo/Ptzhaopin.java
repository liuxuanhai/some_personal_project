package com.pojo;

import java.sql.Timestamp;

/**
 * Ptzhaopin entity. @author MyEclipse Persistence Tools
 */

public class Ptzhaopin implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String title;
	private String phone;
	private String email;
	private String chuanzhen;
	private String shenfe;
	private String hangye;
	private String address;
	private String homeurl;
	private String zpaddr;
	private Timestamp starttime;
	private Timestamp endtime;
	private String dwdescr;
	private String gangwei;
	private String xueli;
	private String zhuanye;
	private String nums;
	private String gangweidescr;
	private Timestamp addtime;
	private Integer looksnum;
	private String xingzhi;
	// Constructors

	/** default constructor */
	public Ptzhaopin() {
	}

	/** full constructor */
	public Ptzhaopin(String name, String phone, String email, String chuanzhen,
			String shenfe, String hangye, String address, String homeurl,
			String zpaddr, Timestamp starttime, Timestamp endtime,
			String dwdescr, String gangwei, String xueli, String zhuanye,
			String nums, String gangweidescr, Timestamp addtime) {
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.chuanzhen = chuanzhen;
		this.shenfe = shenfe;
		this.hangye = hangye;
		this.address = address;
		this.homeurl = homeurl;
		this.zpaddr = zpaddr;
		this.starttime = starttime;
		this.endtime = endtime;
		this.dwdescr = dwdescr;
		this.gangwei = gangwei;
		this.xueli = xueli;
		this.zhuanye = zhuanye;
		this.nums = nums;
		this.gangweidescr = gangweidescr;
		this.addtime = addtime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getChuanzhen() {
		return this.chuanzhen;
	}

	public void setChuanzhen(String chuanzhen) {
		this.chuanzhen = chuanzhen;
	}

	public String getShenfe() {
		return this.shenfe;
	}

	public void setShenfe(String shenfe) {
		this.shenfe = shenfe;
	}

	public String getHangye() {
		return this.hangye;
	}

	public void setHangye(String hangye) {
		this.hangye = hangye;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHomeurl() {
		return this.homeurl;
	}

	public void setHomeurl(String homeurl) {
		this.homeurl = homeurl;
	}

	public String getZpaddr() {
		return this.zpaddr;
	}

	public void setZpaddr(String zpaddr) {
		this.zpaddr = zpaddr;
	}

	public Timestamp getStarttime() {
		return this.starttime;
	}

	public void setStarttime(Timestamp starttime) {
		this.starttime = starttime;
	}

	public Timestamp getEndtime() {
		return this.endtime;
	}

	public void setEndtime(Timestamp endtime) {
		this.endtime = endtime;
	}

	public String getDwdescr() {
		return this.dwdescr;
	}

	public void setDwdescr(String dwdescr) {
		this.dwdescr = dwdescr;
	}

	public String getGangwei() {
		return this.gangwei;
	}

	public void setGangwei(String gangwei) {
		this.gangwei = gangwei;
	}

	public String getXueli() {
		return this.xueli;
	}

	public void setXueli(String xueli) {
		this.xueli = xueli;
	}

	public String getZhuanye() {
		return this.zhuanye;
	}

	public void setZhuanye(String zhuanye) {
		this.zhuanye = zhuanye;
	}

	public String getNums() {
		return this.nums;
	}

	public void setNums(String nums) {
		this.nums = nums;
	}

	public String getGangweidescr() {
		return this.gangweidescr;
	}

	public void setGangweidescr(String gangweidescr) {
		this.gangweidescr = gangweidescr;
	}

	public Timestamp getAddtime() {
		return this.addtime;
	}

	public void setAddtime(Timestamp addtime) {
		this.addtime = addtime;
	}

	public Integer getLooksnum() {
		return looksnum;
	}

	public void setLooksnum(Integer looksnum) {
		this.looksnum = looksnum;
	}

	public String getXingzhi() {
		return xingzhi;
	}

	public void setXingzhi(String xingzhi) {
		this.xingzhi = xingzhi;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}