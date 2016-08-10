package com.ajax;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.pojo.Administrator;
import com.pojo.Student;
import com.service.AdministratorService;
import com.service.StudentService;

public class doajax {
	private AdministratorService administratorService;  //π‹¿Ì‘±

	public AdministratorService getAdministratorService() {
		return administratorService;
	}

	public void setAdministratorService(AdministratorService administratorService) {
		this.administratorService = administratorService;
	}

	private StudentService studentService;

	public StudentService getStudentService() {
		return studentService;
	}
	
	
	// administratorµ«¬º
	public String administratorLogin(String username,String password)
	{
		System.out.println(username);
		Administrator user=new Administrator(username,password);
		System.out.println(username);
		if(administratorService.administratorLogin(user))
			return "success";
    	return "fail";
	}
}
