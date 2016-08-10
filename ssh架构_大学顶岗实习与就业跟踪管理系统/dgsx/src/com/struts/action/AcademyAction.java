/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.struts.action;

import java.net.URLDecoder;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.pojo.Academy;
import com.pojo.Classroom;
import com.pojo.Student;
import com.pojo.Teacher;
import com.struts.form.AcademyForm;
import com.struts.form.AcademyForm;
import com.service.AcademyService;
import com.util.Md5reg;
/** 
 * MyEclipse Struts
 * Creation date: 04-27-2016
 * 
 * XDoclet definition:
 * @struts.action path="/academy" name="academyForm" input="/form/academy.jsp" scope="request" validate="true"
 */
public class AcademyAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	private AcademyService academyService;
	public AcademyService getAcademyService() {
		return academyService;
	}
	public void setAcademyService(AcademyService academyService) {
		this.academyService = academyService;
	}
	
	// 查找院系名称是否存在
	public boolean findAcademyName(String name)
	{
		if(academyService.academyByName(name.trim()).size()>0)
			return true;
		else 
			return false;
	}
	
	// 通过action  method方式添加academy
	public ActionForward academyAddExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		AcademyForm academyForm = (AcademyForm) form;// TODO Auto-generated method stub
		Academy user=new Academy();
		user.setAcademyname(academyForm.getAcademyname().trim());
		user.setAcademydescr(academyForm.getAcademydescr().trim());
		academyService.academyAdd(user);
		request.getSession().setAttribute("academylist",academyService.academyLikeNameOrId(""));  //设置session
		return mapping.findForward("academyMana");  //成功
	}
	
	// 通过action  method方式删除academy
	public ActionForward academyDeleteExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String academyid=request.getParameter("academyid");
		Academy user=academyService.academyByID(new Integer(academyid));
		academyService.academyDelete(user);
		
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		request.getSession().setAttribute("academylist",academyService.academyLikeNameOrId(findinfo));  //设置session
		return mapping.findForward("academyMana");  //成功
	}
	
	// 通过action  method方式修改academy之前
	public ActionForward academyBeforeModifyExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String academyid=request.getParameter("academyid");
		Academy item=academyService.academyByID(Integer.parseInt(academyid));
		request.getSession().setAttribute("academymodifyinfo",item);  //设置session
		return mapping.findForward("academyBeforeModify");  //成功
	}
	
	// 通过action  method方式修改academy
	public ActionForward academyModifyExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		AcademyForm academyForm = (AcademyForm) form;// TODO Auto-generated method stub
		String academyid=request.getParameter("academyid");
		Academy item=academyService.academyByID(new Integer(academyid));
		item.setAcademyname(academyForm.getAcademyname().trim());
		item.setAcademydescr(academyForm.getAcademydescr().trim());
		academyService.academyModify(item);
		request.getSession().setAttribute("academylist",academyService.academyLikeNameOrId(""));  //设置session
		return mapping.findForward("academyMana");  //成功
	}
	
	
	// 通过action  method方式  获取所有academy
	public ActionForward academyFindExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		AcademyForm academyForm = (AcademyForm) form;// TODO Auto-generated method stub
		//decode一次
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		request.getSession().setAttribute("academylist",academyService.academyLikeNameOrId(findinfo));  //设置session
		return mapping.findForward("academyMana");  //成功
	}
	
	// 通过action  method方式  获取指定academy
	public ActionForward academyFindOneExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String academyid=request.getParameter("academyid");
		String classid=request.getParameter("classid");
		Academy item=academyService.academyByID(Integer.parseInt(academyid));
		Classroom cls = null;
		for(Object obj:item.getClassrooms())
		{
			cls=(Classroom)obj;
			if(cls.getClassid().toString().equals(classid.trim()))
				break;
		}
		request.getSession().setAttribute("classroom",cls);  //设置session
		request.getSession().setAttribute("oneacademyinfo",item);  //设置session
		return mapping.findForward("academyTeacherMana");  //成功
	}
	
	// 通过action  method方式  获取指定academy
	public ActionForward getAcademyByIDExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String academyid=request.getParameter("academyid");
		Academy item=academyService.academyByID(Integer.parseInt(academyid));
		request.getSession().setAttribute("oneacademyinfo",item);  //设置session
		return mapping.findForward("academyJobStatMana");  //成功
	}
}