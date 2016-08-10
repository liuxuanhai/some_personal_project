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
		//��Ϣ��ʾ
        String message ="";
        try{
        	int nums=0;
        	String academyid="";
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
                    if(name.equals("importacademy"))
                    	academyid=value;
                }else
                {	//���fileitem�з�װ�����ϴ��ļ�
                    String filename = item.getName();
                    if(filename==null || filename.trim().equals("")){
                    	message="�ļ�������";
                        continue;
                    }
                    if(academyid.length()<=0) {
                    	message="Ժϵ����������";
                    	continue;
                    }
                    Academy academy=new Academy();
                    academy.setAcademyid(new Integer(academyid));
                    
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
                	if(xssfRow==null || !getValue(xssfRow.getCell(0)).equals("��ʦ��Ϣ")) {
                		message="excel�ļ������ϸ�Ľ�ʦ��Ϣ����������Ӹ�ʽ��";
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
                        	if(id.length()<1) continue; // ѧ�Ų����� �������һ������
                        	teacher=teacherdao.findById(id);
                        	if(teacher!=null)  continue;  // ѧ�����������
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
                        	teacher.setRoletype("0");  //Ĭ������ͨ
                        	teacherdao.save(teacher);  //�����ʦ
                        	nums++;
                        }
                    }
                	
                	in.close();
                	wb.close();    
                }
                if(nums>0)
            		message="������ɣ��������ݼ�¼"+String.valueOf(nums)+"��";
            	else
            		message="excel��û������";
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        response.setContentType("text/html; charset=UTF-8"); //ת��
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
