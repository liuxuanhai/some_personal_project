package com.util;
import java.security.*;
public class Md5reg {
	byte[] digest;
	String tmp="",has="";   
	public  String hasString(String password)   //这里作了修改 
	{
		tmp="";has=""; 
		try 
		{   
		     MessageDigest md5 = MessageDigest.getInstance("MD5"); //SHA-1跟MD5写法上差不多。
		     md5.update(password.getBytes());     // 添加要计算的摘要信息   
		     digest = md5.digest();
		}
		catch(NoSuchAlgorithmException e) 
	    {   
			System.out.println("非法摘要算法！"+e.getMessage());   
	    } 
		for(int i=0;i<digest.length;i++) 
		 {   
		   tmp=(Integer.toHexString(digest[i] & 0XFF));   
		   if(tmp.length()==1)    
		       has=has+i+tmp;    //这里也做了修改
		   else   
		       has=has+tmp;   
		   if(i<digest.length-1)  
		       has=has+i;        //这里又做了修改
		  } 
		return has.toUpperCase(); 
	}
}
