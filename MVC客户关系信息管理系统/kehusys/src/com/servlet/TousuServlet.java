package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Tousu;
import com.dao.TousuDao;
import com.dao.YuangongDao;
import com.util.StringUtil;

public class TousuServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public TousuServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String method=request.getParameter("method");
		TousuDao tousuDao=new TousuDao();
		YuangongDao yuangongDao=new YuangongDao();
		if ("addTousu".equals(method)) {
			Tousu tousu=new Tousu();
			tousu.setContent(request.getParameter("content"));
			tousu.setName(request.getParameter("name"));
			tousu.setPersonname(request.getParameter("personname"));
			tousu.setReamrk(request.getParameter("reamrk"));
			tousu.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			tousu.setYuangongid(new Integer(request.getParameter("userid")));
			tousuDao.insert(tousu);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("TousuServlet?method=getTousu").forward(request, response);
		}
		if ("getTousu".equals(method)) {
			String findinfo=request.getParameter("findinfo");
			if(findinfo==null) findinfo="";
			List<Tousu> list;
			String type=yuangongDao.getType(request.getParameter("userid"));
			if(type.equals("0")) // 店长
				list=tousuDao.getAll(findinfo);
			else  // 业务员  只查看自己的客户
				list=tousuDao.getAll(findinfo,request.getParameter("userid"));
			for(int i=0;i<list.size();++i)  // 获得负责员工的姓名
				list.get(i).setYgname(yuangongDao.getName(String.valueOf(list.get(i).getYuangongid())));
			
			request.setAttribute("tousulist", list);
			request.setAttribute("findinfo", findinfo);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../tousumana.jsp").forward(request, response);
		}
		if ("editTousu".equals(method)) {
			String id=request.getParameter("tousuid");
			Tousu tousu=tousuDao.getOneById(Integer.parseInt(id));
			tousu.setContent(request.getParameter("content"));
			tousu.setName(request.getParameter("name"));
			tousu.setReamrk(request.getParameter("reamrk"));
			tousu.setPersonname(request.getParameter("personname"));
			tousu.setYuangongid(new Integer(request.getParameter("userid")));
			tousuDao.update(tousu);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("TousuServlet?method=getTousu").forward(request, response);
		}
		if ("delTousu".equals(method)) {
			String id=request.getParameter("tousuid");
			tousuDao.delete(Integer.parseInt(id));
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("TousuServlet?method=getTousu").forward(request, response);
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
