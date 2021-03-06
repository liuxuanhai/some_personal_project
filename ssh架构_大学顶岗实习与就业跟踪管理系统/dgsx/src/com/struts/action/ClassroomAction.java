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
import com.service.ClassroomService;
import com.struts.form.ClassroomForm;
import com.struts.form.ClassroomForm;
import com.util.Page;
import com.util.PageUtil;

/** 
 * MyEclipse Struts
 * Creation date: 04-27-2016
 * 
 * XDoclet definition:
 * @struts.action path="/classroom" name="classroomForm" input="/form/classroom.jsp" scope="request" validate="true"
 */
public class ClassroomAction extends DispatchAction {
	/*
	 * Generated Methods
	 */
	private ClassroomService classroomService;
	public ClassroomService getClassroomService() {
		return classroomService;
	}
	public void setClassroomService(ClassroomService classroomService) {
		this.classroomService = classroomService;
	}
	
	//分配指导教师
	public void setTeacherToClassroom(String classid,String teaid)
	{
		Teacher tea=new Teacher();
		tea.setTeaid(teaid);
		Classroom cls=classroomService.classroomByID(new Integer(classid));
		cls.setTeacher(tea);
		classroomService.classroomModify(cls);
	}
	
	// 查找班级名称是否存在
	public boolean findClassroomName(String name)
	{
		if(classroomService.classroomByName(name.trim()).size()>0)
			return true;
		else 
			return false;
	}
	
	// 通过action  method方式添加classroom
	public ActionForward classroomAddExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		ClassroomForm classroomForm = (ClassroomForm) form;// TODO Auto-generated method stub
		Classroom user=new Classroom();
		user.setClassname(classroomForm.getClassname().trim());
		user.setClassdescr(classroomForm.getClassdescr().trim());
		Academy academy=classroomService.getAcademyByid(classroomForm.getAcademyid());
		user.setAcademy(academy);
		classroomService.classroomAdd(user);	
		String academyid=classroomForm.getAcademyid();
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		
		String pagenumber=request.getParameter("pagenumber");
		if(pagenumber==null) pagenumber="1";
		Page p=PageUtil.createPage(10,classroomService.findNumsByLikeNameAndAcademyid(findinfo,academyid),new Integer(pagenumber));
		request.getSession().setAttribute("classroomlist",classroomService.findByLikeNameAndAcademyid(findinfo,academyid,p));  //设置session
		request.getSession().setAttribute("classroomacademy",classroomService.getAcademyByid(academyid));
		request.getSession().setAttribute("pagenumber",p.getCurrentPage());
		request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
		return mapping.findForward("classroomMana");  //成功
	}
	
	// 通过action  method方式删除classroom
	public ActionForward classroomDeleteExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String classroomid=request.getParameter("classroomid");
		Classroom user=classroomService.classroomByID(new Integer(classroomid));
		classroomService.classroomDelete(user);
		String academyid=user.getAcademy().getAcademyid().toString();
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		
		String pagenumber=request.getParameter("pagenumber");
		if(pagenumber==null) pagenumber="1";
		Page p=PageUtil.createPage(10,classroomService.findNumsByLikeNameAndAcademyid(findinfo,academyid),new Integer(pagenumber));
		request.getSession().setAttribute("classroomlist",classroomService.findByLikeNameAndAcademyid(findinfo,academyid,p));  //设置session
		request.getSession().setAttribute("classroomacademy",classroomService.getAcademyByid(academyid));
		request.getSession().setAttribute("pagenumber",p.getCurrentPage());
		request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
		return mapping.findForward("classroomMana");  //成功
	}
	
	
	// 通过action  method方式修改classroom
	public ActionForward classroomModifyExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		ClassroomForm classroomForm = (ClassroomForm) form;// TODO Auto-generated method stub
		Classroom item=classroomService.classroomByID(new Integer(classroomForm.getClassid()));
		item.setClassname(classroomForm.getClassname().trim());
		item.setClassdescr(classroomForm.getClassdescr().trim());
		classroomService.classroomModify(item);
		String academyid=item.getAcademy().getAcademyid().toString();
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		
		String pagenumber=request.getParameter("pagenumber");
		if(pagenumber==null) pagenumber="1";
		Page p=PageUtil.createPage(10,classroomService.findNumsByLikeNameAndAcademyid(findinfo,academyid),new Integer(pagenumber));
		request.getSession().setAttribute("classroomlist",classroomService.findByLikeNameAndAcademyid(findinfo,academyid,p));  //设置session
		request.getSession().setAttribute("classroomacademy",classroomService.getAcademyByid(academyid));
		request.getSession().setAttribute("pagenumber",p.getCurrentPage());
		request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
		return mapping.findForward("classroomMana");  //成功
	}
	
	
	// 通过action  method方式  获取所有classroom
	public ActionForward classroomFindExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		ClassroomForm classroomForm = (ClassroomForm) form;// TODO Auto-generated method stub
		String academyid=request.getParameter("academyid");
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		
		String pagenumber=request.getParameter("pagenumber");
		if(pagenumber==null) pagenumber="1";
		Page p=PageUtil.createPage(10,classroomService.findNumsByLikeNameAndAcademyid(findinfo,academyid),new Integer(pagenumber));
		request.getSession().setAttribute("classroomlist",classroomService.findByLikeNameAndAcademyid(findinfo,academyid,p));  //设置session
		request.getSession().setAttribute("classroomacademy",classroomService.getAcademyByid(academyid));
		request.getSession().setAttribute("pagenumber",p.getCurrentPage());
		request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
		return mapping.findForward("classroomMana");  //成功
	}
	//院系查看班级
	public ActionForward academyClassroomFindExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		ClassroomForm classroomForm = (ClassroomForm) form;// TODO Auto-generated method stub
		String academyid=request.getParameter("academyid");
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		request.getSession().setAttribute("findinfo",findinfo);
		
		String pagenumber=request.getParameter("pagenumber");
		if(pagenumber==null) pagenumber="1";
		Page p=PageUtil.createPage(10,classroomService.findNumsByLikeNameAndAcademyid(findinfo,academyid),new Integer(pagenumber));
		request.getSession().setAttribute("classroomlist",classroomService.findByLikeNameAndAcademyid(findinfo,academyid,p));  //设置session
		request.getSession().setAttribute("classroomacademy",classroomService.getAcademyByid(academyid));
		request.getSession().setAttribute("pagenumber",p.getCurrentPage());
		request.getSession().setAttribute("maxpagenumber",p.getTotalPage());
		return mapping.findForward("academyClassroomMana");  //成功
	}
	
	//院系查看班级
	public ActionForward classroomByClassidExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String classid=request.getParameter("classid");
		request.getSession().setAttribute("classroom",classroomService.classroomByID(new Integer(classid)));
		return mapping.findForward("classroomJobStatMana");  //成功
		}
}