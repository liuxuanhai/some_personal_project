package com.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
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
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.dao.TeacherDAO;
import com.pojo.Academy;
import com.pojo.Classroom;
import com.pojo.Teacher;
import com.util.Md5reg;

public class importTeacherServlet extends HttpServlet {

	private TeacherDAO teacherdao;
	public importTeacherServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//消息提示
        String message ="";
        try{
        	int nums=0;
        	String academyid="";
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
                    if(name.equals("importacademy"))
                    	academyid=value;
                }else
                {	//如果fileitem中封装的是上传文件
                    String filename = item.getName();
                    if(filename==null || filename.trim().equals("")){
                    	message="文件不存在";
                        continue;
                    }
                    if(academyid.length()<=0) {
                    	message="院系表单传输有误";
                    	continue;
                    }
                    Academy academy=new Academy();
                    academy.setAcademyid(new Integer(academyid));
                    
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
                	if(xssfRow==null || !getValue(xssfRow.getCell(0)).equals("教师信息")) {
                		message="excel文件不是严格的教师信息表，请参照例子格式！";
                		continue;
                	}
                	Md5reg md5=new Md5reg();
                	Teacher teacher;
                	String id;
                	for (int rowNum = 2; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
                        xssfRow = xssfSheet.getRow(rowNum);
                        if (xssfRow != null) {
                        	id=getValue(xssfRow.getCell(0));
                        	//System.out.println(id);
                        	if(id.length()<1) continue; // 学号不存在 则继续下一个数据
                        	teacher=teacherdao.findById(id);
                        	if(teacher!=null)  continue;  // 学生存在则继续
                        	teacher=new Teacher();
                        	teacher.setTeaid(id);
                        	teacher.setPwd(md5.hasString(id));
                        	teacher.setName(getValue(xssfRow.getCell(1)));
                        	teacher.setSex(getValue(xssfRow.getCell(2)));
                        	teacher.setPhone(getValue(xssfRow.getCell(3)));
                        	teacher.setIdcard(getValue(xssfRow.getCell(4)));
                        	teacher.setSchooltime(com.util.StringUtil.getTimestampFromDate(com.util.StringUtil.getDateFromString(getValue(xssfRow.getCell(5)))));
                        	teacher.setQqid(getValue(xssfRow.getCell(6)));
                        	teacher.setLevel(getValue(xssfRow.getCell(7)));
                        	teacher.setDirection(getValue(xssfRow.getCell(8)));
                        	teacher.setAcademy(academy);
                        	teacher.setRoletype("0");  //默认是普通
                        	teacherdao.save(teacher);  //保存教师
                        	nums++;
                        }
                    }
                	
                	in.close();
                	wb.close();    
                }
                if(nums>0)
            		message="导入完成，导入数据记录"+String.valueOf(nums)+"条";
            	else
            		message="excel表没有数据";
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/html; charset=UTF-8"); //转码
	    PrintWriter out = response.getWriter();
	    out.flush();
	    out.println("<script>");
	    out.println("alert('"+message+"');");
	    out.println("window.location='../teacher.do?method=teacherFindExecute';");
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
	public void init() throws ServletException {
		super.init();  
        ServletContext servletContext = this.getServletContext();    
        WebApplicationContext ctx =    WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);  
        teacherdao = (TeacherDAO)ctx.getBean("TeacherDAO");
	}

}
