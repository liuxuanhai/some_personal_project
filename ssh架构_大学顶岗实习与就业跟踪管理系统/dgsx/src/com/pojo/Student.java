package com.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Student entity. @author MyEclipse Persistence Tools
 */

public class Student implements java.io.Serializable {

	// Fields

	private String stuid;
	private Classroom classroom;
	private String name;
	private String sex;
	private String phone;
	private String idcard;
	private Timestamp schooltime;
	private String qqid;
	private String dirtype;
	private String pwd;
	private String reserved1;
	private String reserved2;
	private String dirdetail;
	
	private Set studentdocuments = new HashSet(0);
	// Constructors

	/** default constructor */
	public Student() {
	}

	/** minimal constructor */
	public Student(String stuid) {
		this.stuid = stuid;
	}

	/** full constructor */
	public Student(String stuid, Classroom classroom, String name, String sex,
			String phone, String idcard, Timestamp schooltime, String qqid,
			String dirtype, String pwd, String reserved1, String reserved2) {
		this.stuid = stuid;
		this.classroom = classroom;
		this.name = name;
		this.sex = sex;
		this.phone = phone;
		this.idcard = idcard;
		this.schooltime = schooltime;
		this.qqid = qqid;
		this.dirtype = dirtype;
		this.pwd = pwd;
		this.reserved1 = reserved1;
		this.reserved2 = reserved2;
	}

	// Property accessors

	public String getStuid() {
		return this.stuid;
	}

	public void setStuid(String stuid) {
		this.stuid = stuid;
	}

	public Classroom getClassroom() {
		return this.classroom;
	}

	public void setClassroom(Classroom classroom) {
		this.classroom = classroom;
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

	public String getDirtype() {
		return this.dirtype;
	}

	public void setDirtype(String dirtype) {
		this.dirtype = dirtype;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
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

	public String getDirdetail() {
		return dirdetail;
	}

	public void setDirdetail(String dirdetail) {
		this.dirdetail = dirdetail;
	}

	public Set getStudentdocuments() {
		return studentdocuments;
	}

	public void setStudentdocuments(Set studentdocuments) {
		this.studentdocuments = studentdocuments;
	}

}