package com.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.bean.Orderdetail;
import com.dao.OrderdetailDao;
import com.util.StringUtil;

public class OrderdetailImportServlet extends HttpServlet {
	OrderdetailDao orderDao=new OrderdetailDao();
	/**
	 * Constructor of the object.
	 */
	public OrderdetailImportServlet() {
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
		//消息提示
				String userid="",ordernum="";
		        String message ="";
		        List<Orderdetail> orderlist=new ArrayList<Orderdetail>();
		        try{
		            //使用Apache文件上传组件处理文件上传步骤：
		            //1、创建一个DiskFileItemFactory工厂
		            DiskFileItemFactory factory = new DiskFileItemFactory();
		            //2、创建一个文件上传解析器
		            ServletFileUpload upload = new ServletFileUpload(factory);
		             //解决上传文件名的中文乱码
		            upload.setHeaderEncoding("UTF-8"); 
		            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
		            List<FileItem> list = upload.parseRequest(request);
		            for(FileItem item : list){
		                //如果fileitem中封装的是普通输入项的数据
		                if(item.isFormField()){
		                    String name = item.getFieldName();
		                    //解决普通输入项的数据的中文乱码问题
		                    String value = item.getString("UTF-8");
		                    if(name.equals("userid")) userid=value;
		                    if(name.equals("ordernum")) ordernum=value;
		                }else
		                {	//如果fileitem中封装的是上传文件
		                    String filename = item.getName();
		                    if(filename==null || filename.trim().equals("")){
		                    	message="文件不存在";
		                        continue;
		                    }
		                    //System.out.println(filename);
		                    //得到上传文件的扩展名
		                    String fileExtName = filename.substring(filename.lastIndexOf(".")+1);
		                    if(!(fileExtName.equals("xls")||fileExtName.equals("xlsx"))) {
		                    	message="只能导入excel文件";
		                    	continue;
		                    }  
		                    InputStream in=item.getInputStream();
		                    Workbook wb=null;
		                    if(fileExtName.equals("xls"))  // excel 2003
		                    	wb=new HSSFWorkbook(in);
		                    else       // excel 2007
		                    	wb=new XSSFWorkbook(in);
		                    Sheet xssfSheet = wb.getSheetAt(0);  //只要第一个
		                	if(xssfSheet==null) {
		                		message="excel文件不存在工作表";
		                		continue;
		                	}
		                	Row xssfRow=xssfSheet.getRow(0);
		                	if(xssfRow==null || !getValue(xssfRow.getCell(0)).equals("详单信息")) {
		                		message="excel文件不是严格的详单信息表，请参照例子格式！";
		                		continue;
		                	}
		                	
		                	String name;
		                	for (int rowNum = 2; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
		                        xssfRow = xssfSheet.getRow(rowNum);
		                        if (xssfRow != null) {
		                        	name=getValue(xssfRow.getCell(0));
		                        	//System.out.println(id);
		                        	if(name.length()<1) continue; // 产品名不存在 则继续下一个数据
		                        	Orderdetail order=new Orderdetail();
		                        	order.setName(name);
		                        	order.setPrice(0);order.setNums(0);
		                        	try{
		                        		order.setPrice(Double.valueOf(getValue(xssfRow.getCell(1))));
		                        		order.setNums(new Integer(getValue(xssfRow.getCell(2))));
		                        	} catch (Exception e) {
		                        	    e.printStackTrace();
		                        	}
		                        	order.setRemark(getValue(xssfRow.getCell(3)));
		                        	orderlist.add(order);
		                        }
		                    }
		                	in.close();
		                	wb.close();    
		                }
		                
		            }
		        }catch (Exception e) {
		            e.printStackTrace();
		        }
		        
		        // 更新数据库
		        Orderdetail order,temp;
		        for(int i=0;i<orderlist.size();++i)
		        {
		        	order=orderlist.get(i);
		        	temp=orderDao.getOneByName(order.getName(),ordernum);  
		        	if(temp==null)
		        	{
		        		order.setAddtime(StringUtil.getTimestampFromDate(new Date()));
		        		order.setOrdernum(ordernum);
		        		order.setTotalprice(order.getNums()*order.getPrice());
		        		orderDao.insert(order);
		        	}else
		        	{
		        		temp.setNums(temp.getNums()+order.getNums());
		        		temp.setPrice(order.getPrice());
		        		temp.setTotalprice(temp.getNums()*temp.getPrice());
		        		orderDao.update(temp);
		        	}
		        }
		        orderDao.updateOedermanaTotalPrice(ordernum);
		        if(orderlist.size()>0)
            		message="导入完成，导入数据记录"+String.valueOf(orderlist.size())+"条";
            	else
            		message="excel表没有数据";
		        
		        response.setContentType("text/html; charset=UTF-8"); //转码
			    PrintWriter out = response.getWriter();
			    out.flush();
			    out.println("<script>");
			    out.println("alert('"+message+"');");
			    out.println("window.location='OrderdetailServlet?method=getOrderdetail&userid="+userid+"&ordernum="+ordernum+"';");
			    out.println("</script>");
	}
	@SuppressWarnings("static-access")
    private String getValue(Cell xssfRow) {
		if(xssfRow==null) return "";
        if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
            return String.valueOf(xssfRow.getBooleanCellValue()).trim();
        } else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
            int id=(int) xssfRow.getNumericCellValue();
        	return String.valueOf(id).trim();
        } else {
            return String.valueOf(xssfRow.getStringCellValue()).trim();
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
