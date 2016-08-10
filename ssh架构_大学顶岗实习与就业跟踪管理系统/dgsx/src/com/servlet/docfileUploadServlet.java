package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.dao.StudentdocumentDAO;
import com.pojo.Studentdocument;
import com.service.StudentdocumentService;

public class docfileUploadServlet extends HttpServlet {

	private StudentdocumentDAO studentdocumentDAO;
	public docfileUploadServlet() {
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
		String tempPath = this.getServletContext().getRealPath("/upload");
		File tmpFile = new File(tempPath);
		if (!tmpFile.exists()) {
			//������ʱĿ¼
			tmpFile.mkdir();
		}
		String studentid="",doctype="",docid="",name="",descr="",paperurl="";
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
                    if(item.getFieldName().equals("studentid"))
                    	studentid= item.getString("UTF-8");
                    if(item.getFieldName().equals("doctype"))
                    	doctype= item.getString("UTF-8");
                    if(item.getFieldName().equals("docid"))
                    	docid= item.getString("UTF-8");
                    if(item.getFieldName().equals("name"))
                    	name= item.getString("UTF-8");
                    if(item.getFieldName().equals("descr"))
                    	descr= item.getString("UTF-8");
                }else
                {	//���fileitem�з�װ�����ϴ��ļ�
                    String filename = item.getName();
                    if(filename==null || filename.trim().equals("")){
                        continue;
                    }
                    //��ȡ������
                    InputStream in=item.getInputStream();
                    //�õ��ϴ��ļ�����չ��
                    String fileExtName = filename.substring(filename.lastIndexOf("."));
                    filename=UUID.randomUUID().toString()+fileExtName;
                    //System.out.println(filename);
                    // ������
                    FileOutputStream out = new FileOutputStream(tempPath + "\\" +filename);
                    
                    //����һ��������
                    byte buffer[] = new byte[1024];
                    //�ж��������е������Ƿ��Ѿ�����ı�ʶ
                    int len = 0;
                    //ѭ�������������뵽���������У�(len=in.read(buffer))>0�ͱ�ʾin���滹������
                    while((len=in.read(buffer))>0){
                        //ʹ��FileOutputStream�������������������д�뵽ָ����Ŀ¼(savePath + "\\" + filename)����
                       out.write(buffer, 0, len);
                   }
                   paperurl=filename;
                   //�ر�������
                   in.close();
                   //�ر������
                   out.close();
                }
            }
            //(Integer courseid, String studentdocumentname, String studentdocumentdescr,
			//String studentdocumentimageurl) {
            if(docid.length()<1)  // ���
            {
            	Studentdocument t=new Studentdocument();
            	t.setPapername(name);
            	t.setPaperstatus("0");
            	t.setPapertype(doctype);
            	t.setPaperurl(paperurl);
            	t.setStuid(studentid);
            	t.setRemark(descr);
	            studentdocumentDAO.save(t);
            }else {
            	//�޸���ҵ
            	Studentdocument t=studentdocumentDAO.findById(new Integer(docid));
            	t.setRemark(descr);
            	t.setPapername(name);
            	if(paperurl.length()>0)
            	{
            		t.setPaperurl(paperurl);
            		t.setPaperstatus("0");
            	}
            	t.setPapertype(doctype);
            	studentdocumentDAO.merge(t);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("../studentdocument.do?method=studentdocumentFindExecute&studentid="+studentid+"&doctype="+doctype).forward(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
		super.init();  
        ServletContext servletContext = this.getServletContext();    
        WebApplicationContext ctx =    WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);  
        studentdocumentDAO = (StudentdocumentDAO)ctx.getBean("StudentdocumentDAO");
	}

}
