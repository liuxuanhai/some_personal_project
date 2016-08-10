package com.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtil {
		// 字符串转日期
		static public Date getDateFromString(String in) throws ParseException
		{
			if(in==null|in=="")return null;
			SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
			return sdf.parse(in);
		}
		static public Date getDateTimeFromString(String in) throws ParseException
		{
			if(in==null|in=="")return null;
			SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd hh:mm");
			return sdf.parse(in);
		}
		//日期转Timestamp
		static public Timestamp getTimestampFromDate(Date in)
		{
			if(in==null) return null;
			return (new Timestamp(in.getTime()));
		}
}
