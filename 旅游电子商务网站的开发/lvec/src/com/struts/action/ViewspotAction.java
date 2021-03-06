/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.struts.action;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.pojo.Viewspot;
import com.service.ViewspotService;
import com.struts.form.ViewspotForm;

/** 
 * MyEclipse Struts
 * Creation date: 04-16-2016
 * 
 * XDoclet definition:
 * @struts.action path="/viewspot" name="viewspotForm" input="/form/viewspot.jsp" scope="request" validate="true"
 */
public class ViewspotAction extends DispatchAction {
	// 依赖注入 ViewspotService
	private ViewspotService viewspotService;

	public ViewspotService getViewspotService() {
		return viewspotService;
	}

	public void setViewspotService(ViewspotService viewspotService) {
		this.viewspotService = viewspotService;
	}
	
	
	// 通过action  method方式删除用户
	public ActionForward viewspotDeleteExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewspotid=request.getParameter("viewspotid");
		Viewspot user=new Viewspot();
		user.setSpotid(Integer.parseInt(viewspotid));
		viewspotService.viewspotDelete(user);
		request.getSession().setAttribute("viewspotlist",viewspotService.viewspotLikeNameOrId(""));  //设置session
		return mapping.findForward("viewspotMana");  //成功
	}
	
	// 通过action  method方式修改用户之前
	public ActionForward viewspotBeforeModifyExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		String viewspotid=request.getParameter("viewspotid");
		Viewspot user=viewspotService.viewspotByID(Integer.parseInt(viewspotid));
		request.getSession().setAttribute("viewspotmodifyinfo",user);  //设置session
		return mapping.findForward("viewspotBeforeModify");  //成功
	}
	
	// 通过action  method方式  获取所有用户
	public ActionForward viewspotFindExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ViewspotForm viewspotForm = (ViewspotForm) form;// TODO Auto-generated method stub
		//decode一次
		String nameorid=request.getParameter("viewspotfindnfo");
		if(nameorid!=null)
			nameorid=URLDecoder.decode(nameorid,"UTF-8");
		else
			nameorid="";
		request.getSession().setAttribute("viewspotlist",viewspotService.viewspotLikeNameOrId(nameorid));  //设置session
		return mapping.findForward("viewspotMana");  //成功
	}
	
	// 通过action  method方式  获取所有用户
	public ActionForward viewspotListExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ViewspotForm viewspotForm = (ViewspotForm) form;// TODO Auto-generated method stub
		//decode一次
		String findinfo=request.getParameter("findinfo");
		if(findinfo!=null)
			findinfo=URLDecoder.decode(findinfo,"UTF-8");
		else
			findinfo="";
		String city=request.getParameter("city");
		if(city!=null)
			city=URLDecoder.decode(city,"UTF-8");
		else
			city="";
		request.getSession().setAttribute("findinfo",findinfo);
		request.getSession().setAttribute("city",city);
		request.getSession().setAttribute("viewspotlist",viewspotService.viewspotLikeNameOrId(findinfo,city));  //设置session
		request.getSession().setAttribute("citylist",viewspotService.findAllCity());
		return mapping.findForward("viewspotListMana");  //成功
	}
	
	//查看单个景点信息
	public ActionForward spotviewLookExecute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		ViewspotForm viewspotForm = (ViewspotForm) form;// TODO Auto-generated method stub
		//decode一次
		String spotid=request.getParameter("spotid");
		//System.out.println(spotid);
		Viewspot viewspotinfo=viewspotService.viewspotByID(new Integer(spotid));
		//viewspotinfo.setSpotdescr(viewspotinfo.getSpotdescr().replaceAll("\n", "<br/>"));
		//viewspotinfo.setSpotremark(viewspotinfo.getSpotremark().replaceAll("\n",  "<br/>"));
		request.getSession().setAttribute("viewspotinfo",viewspotinfo);  //设置session 
		request.getSession().setAttribute("viewspotcity",viewspotService.getHotleByCity(viewspotinfo.getSpotcity()));  //设置session
		request.getSession().setAttribute("viewspotcomment",viewspotService.getSpotcommentBySpotid(viewspotinfo.getSpotid().toString()));  //设置session
		return mapping.findForward("viewspotInfoMana");  //成功
	}
}