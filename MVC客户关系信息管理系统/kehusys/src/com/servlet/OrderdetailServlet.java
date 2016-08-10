package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Orderdetail;
import com.bean.Ordermana;
import com.bean.Tousu;
import com.dao.CustomerDao;
import com.dao.OrderdetailDao;
import com.dao.OrdermanaDao;
import com.dao.YuangongDao;
import com.util.StringUtil;

public class OrderdetailServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public OrderdetailServlet() {
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
		OrderdetailDao orderDao=new OrderdetailDao();
		OrdermanaDao ordermanaDao=new OrdermanaDao();
		CustomerDao customerDao=new CustomerDao();
		YuangongDao yuangongDao=new YuangongDao();
		if ("addOrderdetail".equals(method)) {
			Tousu tousu=new Tousu();
	
			Orderdetail order=new Orderdetail();
			order.setOrdernum(request.getParameter("ordernum"));
			order.setName(request.getParameter("name"));
			order.setPrice(Double.valueOf(request.getParameter("price")));
			order.setNums(new Integer(request.getParameter("nums")));
			order.setTotalprice(order.getNums()*order.getPrice());
			order.setRemark(request.getParameter("remark"));
			order.setAddtime(StringUtil.getTimestampFromDate(new Date()));

			orderDao.insert(order);
			request.setAttribute("userid", request.getParameter("userid"));
			request.setAttribute("ordernum", request.getParameter("ordernum"));
			orderDao.updateOedermanaTotalPrice(request.getParameter("ordernum"));
			request.getRequestDispatcher("OrderdetailServlet?method=getOrderdetail").forward(request, response);
		}
		if ("getOrderdetail".equals(method)) {
			String starttime=request.getParameter("starttime");
			String endtime=request.getParameter("endtime");
			if(starttime==null) 
			{
				Date d=new Date();
				java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
				starttime = format1.format(new Date(d.getTime() - 10*24 * 60 * 60 * 1000));
			}
			if(endtime==null)  {
				Date d=new Date();
				java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
				endtime = format1.format(new Date(d.getTime() + 24 * 60 * 60 * 1000));
			}
			String type=yuangongDao.getType(request.getParameter("userid"));
			List<Orderdetail> list=orderDao.getAll(request.getParameter("ordernum"));
			request.setAttribute("orderdetaillist", list);
			Ordermana ordermana=ordermanaDao.getOneById(request.getParameter("ordernum"));
			ordermana.setKename(customerDao.getName(String.valueOf(ordermana.getCustomerid())));
			ordermana.setYgname(yuangongDao.getName(String.valueOf(ordermana.getYuangongid())));
			request.setAttribute("ordermana", ordermana);
			request.setAttribute("userid", request.getParameter("userid"));
			request.setAttribute("ordernum", request.getParameter("ordernum"));
			request.getRequestDispatcher("../orderdetail.jsp").forward(request, response);
		}
		if ("editOrderdetail".equals(method)) {
			String id=request.getParameter("orderdetailid");
			Orderdetail order=orderDao.getOneById(id);
			order.setName(request.getParameter("name"));
			order.setPrice(Double.valueOf(request.getParameter("price")));
			order.setNums(new Integer(request.getParameter("nums")));
			order.setTotalprice(order.getNums()*order.getPrice());
			order.setRemark(request.getParameter("remark"));
			orderDao.update(order);
			request.setAttribute("userid", request.getParameter("userid"));
			request.setAttribute("ordernum", request.getParameter("ordernum"));
			orderDao.updateOedermanaTotalPrice(request.getParameter("ordernum"));
			request.getRequestDispatcher("OrderdetailServlet?method=getOrderdetail").forward(request, response);
		}
		if ("delOrderdetail".equals(method)) {
			String id=request.getParameter("orderdetailid");
			orderDao.delete(id);
			request.setAttribute("userid", request.getParameter("userid"));
			request.setAttribute("ordernum", request.getParameter("ordernum"));
			orderDao.updateOedermanaTotalPrice(request.getParameter("ordernum"));
			request.getRequestDispatcher("OrderdetailServlet?method=getOrderdetail").forward(request, response);
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
