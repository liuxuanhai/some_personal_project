package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Classroom entity. @author MyEclipse Persistence Tools
 */

public class Classroom implements java.io.Serializable {

	// Fields

	private Integer classid;
	private Teacher teacher;
	private Academy academy;
	private String classname;
	private String classdescr;
	private Set students = new HashSet(0);

	// Constructors

	/** default constructor */
	public Classroom() {
	}

	/** full constructor */
	public Classroom(Teacher teacher, Academy academy, String classname,
			String classdescr, Set students) {
		this.teacher = teacher;
		this.academy = academy;
		this.classname = classname;
		this.classdescr = classdescr;
		this.students = students;
	}

	// Property accessors

	public Integer getClassid() {
		return this.classid;
	}

	public void setClassid(Integer classid) {
		this.classid = classid;
	}

	public Teacher getTeacher() {
		return this.teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public Academy getAcademy() {
		return this.academy;
	}

	public void setAcademy(Academy academy) {
		this.academy = academy;
	}

	public String getClassname() {
		return this.classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getClassdescr() {
		return this.classdescr;
	}

	public void setClassdescr(String classdescr) {
		this.classdescr = classdescr;
	}

	public Set getStudents() {
		return this.students;
	}

	public void setStudents(Set students) {
		this.students = students;
	}

}