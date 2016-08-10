package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Yuangong;
import com.dao.YuangongDao;

public class YuangongServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public YuangongServlet() {
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
		YuangongDao yuangongDao=new YuangongDao();
		if ("addYuangong".equals(method)) {
			Yuangong yuangong=new Yuangong();
			yuangong.setAddr(request.getParameter("addr"));
			yuangong.setIdcard(request.getParameter("idcard"));
			yuangong.setName(request.getParameter("name"));
			yuangong.setUsername(request.getParameter("username"));
			yuangong.setPhone(request.getParameter("phone"));
			yuangong.setPwd(request.getParameter("pwd"));
			yuangong.setType(request.getParameter("type"));
			request.setAttribute("userid", request.getParameter("userid"));
			yuangongDao.insert(yuangong);
			request.getRequestDispatcher("YuangongServlet?method=getYuangong").forward(request, response);
		}
		if ("getYuangong".equals(method)) {
			String findinfo=request.getParameter("findinfo");
			if(findinfo==null) findinfo="";
			List<Yuangong> list=yuangongDao.getAll(findinfo);
			request.setAttribute("yuangonglist", list);
			request.setAttribute("findinfo", findinfo);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../yuangongmana.jsp").forward(request, response);
		}
		if ("editYuangong".equals(method)) {
			String id=request.getParameter("yuangongid");
			Yuangong yuangong=yuangongDao.getOneById(Integer.parseInt(id));
			yuangong.setAddr(request.getParameter("addr"));
			yuangong.setIdcard(request.getParameter("idcard"));
			yuangong.setName(request.getParameter("name"));
			yuangong.setUsername(request.getParameter("username"));
			yuangong.setPhone(request.getParameter("phone"));
			yuangong.setType(request.getParameter("type"));
			request.setAttribute("userid", request.getParameter("userid"));
			yuangongDao.update(yuangong);
			request.getRequestDispatcher("YuangongServlet?method=getYuangong").forward(request, response);
		}
		if ("delYuangong".equals(method)) {
			String id=request.getParameter("yuangongid");
			yuangongDao.delete(Integer.parseInt(id));
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("YuangongServlet?method=getYuangong").forward(request, response);
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
