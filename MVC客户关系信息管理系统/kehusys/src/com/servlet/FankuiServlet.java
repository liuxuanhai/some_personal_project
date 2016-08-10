package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Customer;
import com.bean.Fankui;
import com.dao.FankuiDao;
import com.dao.YuangongDao;
import com.util.StringUtil;

public class FankuiServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public FankuiServlet() {
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
		FankuiDao fankuiDao=new FankuiDao();
		YuangongDao yuangongDao=new YuangongDao();
		if ("addFankui".equals(method)) {
			Fankui fankui=new Fankui();
			fankui.setContent(request.getParameter("content"));
			fankui.setName(request.getParameter("name"));
			fankui.setPersonname(request.getParameter("personname"));
			fankui.setReamrk(request.getParameter("reamrk"));
			fankui.setAddtime(StringUtil.getTimestampFromDate(new Date()));
			fankui.setYuangongid(new Integer(request.getParameter("userid")));
			fankuiDao.insert(fankui);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("FankuiServlet?method=getFankui").forward(request, response);
		}
		if ("getFankui".equals(method)) {
			String findinfo=request.getParameter("findinfo");
			if(findinfo==null) findinfo="";
			String type=yuangongDao.getType(request.getParameter("userid"));
			List<Fankui> list;
			if(type.equals("0")) // 店长
				list=fankuiDao.getAll(findinfo);
			else  // 业务员  只查看自己的客户
				list=fankuiDao.getAll(findinfo,request.getParameter("userid"));
			for(int i=0;i<list.size();++i)  // 获得负责员工的姓名
				list.get(i).setYgname(yuangongDao.getName(String.valueOf(list.get(i).getYuangongid())));
			
			request.setAttribute("fankuilist", list);
			request.setAttribute("findinfo", findinfo);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../fankuimana.jsp").forward(request, response);
		}
		if ("editFankui".equals(method)) {
			String id=request.getParameter("fankuiid");
			Fankui fankui=fankuiDao.getOneById(Integer.parseInt(id));
			fankui.setContent(request.getParameter("content"));
			fankui.setReamrk(request.getParameter("reamrk"));
			fankui.setName(request.getParameter("name"));
			fankui.setPersonname(request.getParameter("personname"));
			fankui.setYuangongid(new Integer(request.getParameter("userid")));
			fankuiDao.update(fankui);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("FankuiServlet?method=getFankui").forward(request, response);
		}
		if ("delFankui".equals(method)) {
			String id=request.getParameter("fankuiid");
			fankuiDao.delete(Integer.parseInt(id));
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("FankuiServlet?method=getFankui").forward(request, response);
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
