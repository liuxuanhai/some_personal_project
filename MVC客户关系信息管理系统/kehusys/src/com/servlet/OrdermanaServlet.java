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

import com.bean.Customer;
import com.bean.Ordermana;
import com.bean.Tousu;
import com.dao.CustomerDao;
import com.dao.OrdermanaDao;
import com.dao.YuangongDao;
import com.util.StringUtil;

public class OrdermanaServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public OrdermanaServlet() {
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
		OrdermanaDao orderDao=new OrdermanaDao();
		CustomerDao customerDao=new CustomerDao();
		YuangongDao yuangongDao=new YuangongDao();
		if ("addOrdermana".equals(method)) {
			Tousu tousu=new Tousu();
	
			Ordermana order=new Ordermana();
			order.setCustomerid(new Integer(request.getParameter("customerid")));
			order.setYuangongid(new Integer(request.getParameter("userid")));
			order.setTotalprice(0);
			//System.out.println("5");
			order.setRemark(request.getParameter("remark"));
			try {
				order.setOrdertime(StringUtil.getTimestampFromDate(StringUtil.getDateFromString(request.getParameter("ordertime"))));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("5");
			SimpleDateFormat dateFormater = new SimpleDateFormat("yyyyMMddhhmmss");
			Date date=new Date();
			order.setOrdernum(dateFormater.format(new Date()));
			orderDao.insert(order);
			request.setAttribute("userid", request.getParameter("userid"));
			
			///servlet/OrderdetailServlet?method=getOrderdetail&userid=${requestScope.userid}&ordernum=<c:out value="${order.ordernum}"/>
			request.getRequestDispatcher("OrderdetailServlet?method=getOrderdetail&userid="+request.getParameter("userid")+"&ordernum="+order.getOrdernum()).forward(request, response);
			//request.getRequestDispatcher("OrdermanaServlet?method=getOrdermana").forward(request, response);
		}
		if ("getOrdermana".equals(method)) {
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
			List<Ordermana> list=null;
			try {
				if(type.equals("0")) // 店长
				list = orderDao.getAll(StringUtil.getTimestampFromDate(StringUtil.getDateFromString(starttime)),StringUtil.getTimestampFromDate(StringUtil.getDateFromString(endtime)));
				else
					list = orderDao.getAll(StringUtil.getTimestampFromDate(StringUtil.getDateFromString(starttime)),StringUtil.getTimestampFromDate(StringUtil.getDateFromString(endtime)),request.getParameter("userid"));	
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			for(int i=0;i<list.size();++i)  // 获得负责员工的姓名
			{
				list.get(i).setYgname(yuangongDao.getName(String.valueOf(list.get(i).getYuangongid())));
				list.get(i).setKename(customerDao.getName(String.valueOf(list.get(i).getCustomerid())));
			}
			request.setAttribute("orderlist", list);
			request.setAttribute("customerlist",customerDao.getAll("",request.getParameter("userid")));
			request.setAttribute("starttime", starttime);
			request.setAttribute("endtime", endtime);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../ordermana.jsp").forward(request, response);
		}
		if ("editOrdermana".equals(method)) {
			String id=request.getParameter("ordernum");
			Ordermana order=orderDao.getOneById(id);
			try {
				order.setOrdertime(StringUtil.getTimestampFromDate(StringUtil.getDateFromString(request.getParameter("ordertime"))));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			order.setRemark(request.getParameter("remark"));
			orderDao.update(order);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("OrdermanaServlet?method=getOrdermana").forward(request, response);
		}
		if ("delOrdermana".equals(method)) {
			String id=request.getParameter("ordernum");
			orderDao.delete(id);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("OrdermanaServlet?method=getOrdermana").forward(request, response);
		}
		if("getCustomerStat".equals(method))
		{
			// 活跃度分析
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
			List<Customer> list;
			if(type.equals("0")) // 店长
				list=customerDao.getAll("");
			else  // 业务员  只查看自己的客户
				list=customerDao.getAll("",request.getParameter("userid"));
			List<Ordermana> orderlist=null;
			for(int i=0;i<list.size();++i)  // 获得负责员工的姓名
			{
				list.get(i).setYgname(yuangongDao.getName(String.valueOf(list.get(i).getYuangongid())));
				// 获得客户的消费金额
				try {
					orderlist = orderDao.getCustomerOrder(StringUtil.getTimestampFromDate(StringUtil.getDateFromString(starttime)),StringUtil.getTimestampFromDate(StringUtil.getDateFromString(endtime)),String.valueOf(list.get(i).getId()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
				//统计活跃度和消费金额
				list.get(i).setHuoyuedu(orderlist.size());
				list.get(i).setTotalmoney(0);
				for(int j=0;j<orderlist.size();++j)
					list.get(i).setTotalmoney(list.get(i).getTotalmoney()+orderlist.get(j).getTotalprice());
			}
			
			request.setAttribute("customerlist", list);
			request.setAttribute("starttime", starttime);
			request.setAttribute("endtime", endtime);
			request.setAttribute("userid", request.getParameter("userid"));
			request.getRequestDispatcher("../customerhuoyuedu.jsp").forward(request, response);
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
