/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.struts.action;

import java.net.URLDecoder;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.pojo.Gonggao;
import com.service.GonggaoService;
import com.struts.form.GonggaoForm;
import com.util.Page;
import com.util.PageUtil;
import com.util.StringUtil;

/** 
 * MyEclipse Struts
 * Creation date: 04-29-2016
 * 
 * XDoclet definition:
 * @struts.action path="/gonggao" name="gonggaoForm" input="/form/gonggao.jsp" scope="request" validate="true"
 */
public class GonggaoAction extends DispatchAction {
	private GonggaoService gonggaoService;
	public GonggaoService getGonggaoService() {
		return gonggaoService;
	}
	public void setGonggaoService(GonggaoService gonggaoService) {
		this.gonggaoService = gonggaoService;
	}
	
	
	// 通过action  method方式添加gonggao
		public ActionForward gonggaoAddExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			GonggaoForm gonggaoForm = (GonggaoForm) form;// TODO Auto-generated method stub
			Gonggao user=new Gonggao();
			user.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			user.setLooknum(0);  //浏览量
			gonggaoService.gonggaoAdd(user);
			return mapping.findForward("gonggaoFind");  //成功
		}
		
		// 通过action  method方式删除gonggao
		public ActionForward gonggaoDeleteExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			String gonggaoid=request.getParameter("gonggaoid");
			Gonggao user=gonggaoService.gonggaoByID(new Integer(gonggaoid));
			gonggaoService.gonggaoDelete(user);
			
			String findinfo=request.getParameter("findinfo");
			if(findinfo!=null)
				findinfo=URLDecoder.decode(findinfo,"UTF-8");
			else
				findinfo="";
			
			String pagenumber=request.getParameter("pagenumber");
			if(pagenumber==null) pagenumber="1";
			Page p=PageUtil.createPage(10,gonggaoService.findNumsByLikeNameOrId(findinfo),new Integer(pagenumber));
			request.getSession().setAttribute("pagenumber",p.getCurrentPage());
			request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
			request.getSession().setAttribute("gonggaolist",gonggaoService.gonggaoLikeNameOrId(findinfo,p));  //设置session
			return mapping.findForward("gonggaoMana");  //成功
		}
		
		// 通过action  method方式修改gonggao之前
		public ActionForward gonggaoBeforeModifyExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			String gonggaoid=request.getParameter("gonggaoid");
			Gonggao item=gonggaoService.gonggaoByID(Integer.parseInt(gonggaoid));
			request.getSession().setAttribute("gonggaomodifyinfo",item);  //设置session
			return mapping.findForward("gonggaoBeforeModify");  //成功
		}
		
		// 通过action  method方式修改gonggao
		public ActionForward gonggaoModifyExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			GonggaoForm gonggaoForm = (GonggaoForm) form;// TODO Auto-generated method stub
			String gonggaoid=request.getParameter("gonggaoid");
			Gonggao user=gonggaoService.gonggaoByID(new Integer(gonggaoid));
			gonggaoService.gonggaoModify(user);
			return mapping.findForward("gonggaoFind");  //成功
		}
		
		
		// 通过action  method方式  获取所有gonggao
		public ActionForward gonggaoFindExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			
			GonggaoForm gonggaoForm = (GonggaoForm) form;// TODO Auto-generated method stub
			//decode一次
			String findinfo=request.getParameter("findinfo");
			if(findinfo!=null)
				findinfo=URLDecoder.decode(findinfo,"UTF-8");
			else
				findinfo="";
			request.getSession().setAttribute("findinfo",findinfo);
			
			String pagenumber=request.getParameter("pagenumber");
			if(pagenumber==null) pagenumber="1";
			Page p=PageUtil.createPage(10,gonggaoService.findNumsByLikeNameOrId(findinfo),new Integer(pagenumber));
			
			request.getSession().setAttribute("pagenumber",p.getCurrentPage());
			request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
			request.getSession().setAttribute("gonggaolist",gonggaoService.gonggaoLikeNameOrId(findinfo,p));  //设置session
			return mapping.findForward("gonggaoMana");  //成功
		}
		
		//招聘信息查看
		public ActionForward gonggaoInfoLookExecute(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) throws Exception{
			String gonggaoid=request.getParameter("gonggaoid");
			Gonggao item=gonggaoService.gonggaoByID(Integer.parseInt(gonggaoid));
			item.setLooknum(item.getLooknum()+1);
			gonggaoService.gonggaoModify(item);
			request.getSession().setAttribute("gonggaoinfolook",item);  //设置session
			return mapping.findForward("gonggaoInfoLook");  //成功
		}
}