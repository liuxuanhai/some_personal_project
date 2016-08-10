package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Customer;
import com.dao.CustomerDao;
import com.dao.YuangongDao;

public class CustomerServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public CustomerServlet() {
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
		CustomerDao customerDao=new CustomerDao();
		YuangongDao yuangongDao=new YuangongDao();
		if ("addCustomer".equals(method)) {
			Customer customer=new Customer();
			customer.setAddr(request.getParameter("addr"));
			customer.setRemark(request.getParameter("remark"));
			customer.setName(request.getParameter("name"));
			customer.setPhone(request.getParameter("phone"));
			customer.setYuangongid(new Integer(request.getParameter("userid")));
			customerDao.insert(customer);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("CustomerServlet?method=getCustomer").forward(request, response);
		}
		if ("getCustomer".equals(method)) {
			String findinfo=request.getParameter("findinfo");
			if(findinfo==null) findinfo="";
			
			String type=yuangongDao.getType(request.getParameter("userid"));
			List<Customer> list;
			if(type.equals("0")) // 店长
				list=customerDao.getAll(findinfo);
			else  // 业务员  只查看自己的客户
				list=customerDao.getAll(findinfo,request.getParameter("userid"));
			for(int i=0;i<list.size();++i)  // 获得负责员工的姓名
				list.get(i).setYgname(yuangongDao.getName(String.valueOf(list.get(i).getYuangongid())));
			request.setAttribute("customerlist", list);
			request.setAttribute("findinfo", findinfo);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../customermana.jsp").forward(request, response);
		}
		if ("editCustomer".equals(method)) {
			String id=request.getParameter("customerid");
			Customer customer=customerDao.getOneById(Integer.parseInt(id));
			customer.setAddr(request.getParameter("addr"));
			customer.setRemark(request.getParameter("remark"));
			customer.setName(request.getParameter("name"));
			customer.setPhone(request.getParameter("phone"));
			customer.setYuangongid(new Integer(request.getParameter("userid")));
			customerDao.update(customer);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("CustomerServlet?method=getCustomer").forward(request, response);
		}
		if ("delCustomer".equals(method)) {
			String id=request.getParameter("customerid");
			customerDao.delete(Integer.parseInt(id));
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("CustomerServlet?method=getCustomer").forward(request, response);
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
