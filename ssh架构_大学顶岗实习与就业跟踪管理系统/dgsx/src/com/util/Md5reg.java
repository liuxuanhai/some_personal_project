package com.util;
import java.security.*;
public class Md5reg {
	byte[] digest;
	String tmp="",has="";   
	public  String hasString(String password)   //���������޸� 
	{
		tmp="";has=""; 
		try 
		{   
		     MessageDigest md5 = MessageDigest.getInstance("MD5"); //SHA-1��MD5д���ϲ�ࡣ
		     md5.update(password.getBytes());     // ���Ҫ�����ժҪ��Ϣ   
		     digest = md5.digest();
		}
		catch(NoSuchAlgorithmException e) 
	    {   
			System.out.println("�Ƿ�ժҪ�㷨��"+e.getMessage());   
	    } 
		for(int i=0;i<digest.length;i++) 
		 {   
		   tmp=(Integer.toHexString(digest[i] & 0XFF));   
		   if(tmp.length()==1)    
		       has=has+i+tmp;    //����Ҳ�����޸�
		   else   
		       has=has+tmp;   
		   if(i<digest.length-1)  
		       has=has+i;        //�����������޸�
		  } 
		return has.toUpperCase(); 
	}
}
