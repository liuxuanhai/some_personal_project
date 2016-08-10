package com.pojo;

/**
 * Goodtype entity. @author MyEclipse Persistence Tools
 */

public class Goodtype implements java.io.Serializable {

	// Fields

	private Integer typeid;
	private String typename;
	private String typedescr;

	// Constructors

	/** default constructor */
	public Goodtype() {
	}

	/** full constructor */
	public Goodtype(String typename, String typedescr) {
		this.typename = typename;
		this.typedescr = typedescr;
	}

	// Property accessors

	public Integer getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Integer typeid) {
		this.typeid = typeid;
	}

	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public String getTypedescr() {
		return this.typedescr;
	}

	public void setTypedescr(String typedescr) {
		this.typedescr = typedescr;
	}

}