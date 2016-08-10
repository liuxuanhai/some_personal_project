package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Academy entity. @author MyEclipse Persistence Tools
 */

public class Academy implements java.io.Serializable {

	// Fields

	private Integer academyid;
	private String academyname;
	private String academydescr;
	private Set classrooms = new HashSet(0);
	private Set teachers = new HashSet(0);

	// Constructors

	/** default constructor */
	public Academy() {
	}

	/** full constructor */
	public Academy(String academyname, String academydescr, Set classrooms,
			Set teachers) {
		this.academyname = academyname;
		this.academydescr = academydescr;
		this.classrooms = classrooms;
		this.teachers = teachers;
	}

	// Property accessors

	public Integer getAcademyid() {
		return this.academyid;
	}

	public void setAcademyid(Integer academyid) {
		this.academyid = academyid;
	}

	public String getAcademyname() {
		return this.academyname;
	}

	public void setAcademyname(String academyname) {
		this.academyname = academyname;
	}

	public String getAcademydescr() {
		return this.academydescr;
	}

	public void setAcademydescr(String academydescr) {
		this.academydescr = academydescr;
	}

	public Set getClassrooms() {
		return this.classrooms;
	}

	public void setClassrooms(Set classrooms) {
		this.classrooms = classrooms;
	}

	public Set getTeachers() {
		return this.teachers;
	}

	public void setTeachers(Set teachers) {
		this.teachers = teachers;
	}

}