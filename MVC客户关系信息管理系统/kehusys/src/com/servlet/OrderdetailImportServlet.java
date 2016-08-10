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
		//��Ϣ��ʾ
				String userid="",ordernum="";
		        String message ="";
		        List<Orderdetail> orderlist=new ArrayList<Orderdetail>();
		        try{
		            //ʹ��Apache�ļ��ϴ���������ļ��ϴ����裺
		            //1������һ��DiskFileItemFactory����
		            DiskFileItemFactory factory = new DiskFileItemFactory();
		            //2������һ���ļ��ϴ�������
		            ServletFileUpload upload = new ServletFileUpload(factory);
		             //����ϴ��ļ�������������
		            upload.setHeaderEncoding("UTF-8"); 
		            //4��ʹ��ServletFileUpload�����������ϴ����ݣ�����������ص���һ��List<FileItem>���ϣ�ÿһ��FileItem��Ӧһ��Form����������
		            List<FileItem> list = upload.parseRequest(request);
		            for(FileItem item : list){
		                //���fileitem�з�װ������ͨ�����������
		                if(item.isFormField()){
		                    String name = item.getFieldName();
		                    //�����ͨ����������ݵ�������������
		                    String value = item.getString("UTF-8");
		                    if(name.equals("userid")) userid=value;
		                    if(name.equals("ordernum")) ordernum=value;
		                }else
		                {	//���fileitem�з�װ�����ϴ��ļ�
		                    String filename = item.getName();
		                    if(filename==null || filename.trim().equals("")){
		                    	message="�ļ�������";
		                        continue;
		                    }
		                    //System.out.println(filename);
		                    //�õ��ϴ��ļ�����չ��
		                    String fileExtName = filename.substring(filename.lastIndexOf(".")+1);
		                    if(!(fileExtName.equals("xls")||fileExtName.equals("xlsx"))) {
		                    	message="ֻ�ܵ���excel�ļ�";
		                    	continue;
		                    }  
		                    InputStream in=item.getInputStream();
		                    Workbook wb=null;
		                    if(fileExtName.equals("xls"))  // excel 2003
		                    	wb=new HSSFWorkbook(in);
		                    else       // excel 2007
		                    	wb=new XSSFWorkbook(in);
		                    Sheet xssfSheet = wb.getSheetAt(0);  //ֻҪ��һ��
		                	if(xssfSheet==null) {
		                		message="excel�ļ������ڹ�����";
		                		continue;
		                	}
		                	Row xssfRow=xssfSheet.getRow(0);
		                	if(xssfRow==null || !getValue(xssfRow.getCell(0)).equals("�굥��Ϣ")) {
		                		message="excel�ļ������ϸ���굥��Ϣ����������Ӹ�ʽ��";
		                		continue;
		                	}
		                	
		                	String name;
		                	for (int rowNum = 2; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
		                        xssfRow = xssfSheet.getRow(rowNum);
		                        if (xssfRow != null) {
		                        	name=getValue(xssfRow.getCell(0));
		                        	//System.out.println(id);
		                        	if(name.length()<1) continue; // ��Ʒ�������� �������һ������
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
		        
		        // �������ݿ�
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
            		message="������ɣ��������ݼ�¼"+String.valueOf(orderlist.size())+"��";
            	else
            		message="excel��û������";
		        
		        response.setContentType("text/html; charset=UTF-8"); //ת��
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
