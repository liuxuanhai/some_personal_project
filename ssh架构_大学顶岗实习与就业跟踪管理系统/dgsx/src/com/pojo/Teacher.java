package com.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Teacher entity. @author MyEclipse Persistence Tools
 */

public class Teacher implements java.io.Serializable {

	// Fields

	private String teaid;
	private Academy academy;
	private String name;
	private String sex;
	private String level;
	private String phone;
	private String idcard;
	private Timestamp schooltime;
	private String qqid;
	private String direction;
	private String pwd;
	private String roletype;
	private String reserved1;
	private String reserved2;
	private Set classrooms = new HashSet(0);

	// Constructors

	/** default constructor */
	public Teacher() {
	}

	/** minimal constructor */
	public Teacher(String teaid) {
		this.teaid = teaid;
	}

	/** full constructor */
	public Teacher(String teaid, Academy academy, String name, String sex,
			String level, String phone, String idcard, Timestamp schooltime,
			String qqid, String direction, String pwd, String roletype,
			String reserved1, String reserved2, Set classrooms) {
		this.teaid = teaid;
		this.academy = academy;
		this.name = name;
		this.sex = sex;
		this.level = level;
		this.phone = phone;
		this.idcard = idcard;
		this.schooltime = schooltime;
		this.qqid = qqid;
		this.direction = direction;
		this.pwd = pwd;
		this.roletype = roletype;
		this.reserved1 = reserved1;
		this.reserved2 = reserved2;
		this.classrooms = classrooms;
	}

	// Property accessors

	public String getTeaid() {
		return this.teaid;
	}

	public void setTeaid(String teaid) {
		this.teaid = teaid;
	}

	public Academy getAcademy() {
		return this.academy;
	}

	public void setAcademy(Academy academy) {
		this.academy = academy;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getLevel() {
		return this.level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIdcard() {
		return this.idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public Timestamp getSchooltime() {
		return this.schooltime;
	}

	public void setSchooltime(Timestamp schooltime) {
		this.schooltime = schooltime;
	}

	public String getQqid() {
		return this.qqid;
	}

	public void setQqid(String qqid) {
		this.qqid = qqid;
	}

	public String getDirection() {
		return this.direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getRoletype() {
		return this.roletype;
	}

	public void setRoletype(String roletype) {
		this.roletype = roletype;
	}

	public String getReserved1() {
		return this.reserved1;
	}

	public void setReserved1(String reserved1) {
		this.reserved1 = reserved1;
	}

	public String getReserved2() {
		return this.reserved2;
	}

	public void setReserved2(String reserved2) {
		this.reserved2 = reserved2;
	}

	public Set getClassrooms() {
		return this.classrooms;
	}

	public void setClassrooms(Set classrooms) {
		this.classrooms = classrooms;
	}

}