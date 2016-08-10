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
			//创建临时目录
			tmpFile.mkdir();
		}
		String studentid="",doctype="",docid="",name="",descr="",paperurl="";
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
                {	//如果fileitem中封装的是上传文件
                    String filename = item.getName();
                    if(filename==null || filename.trim().equals("")){
                        continue;
                    }
                    //读取输入流
                    InputStream in=item.getInputStream();
                    //得到上传文件的扩展名
                    String fileExtName = filename.substring(filename.lastIndexOf("."));
                    filename=UUID.randomUUID().toString()+fileExtName;
                    //System.out.println(filename);
                    // 生成流
                    FileOutputStream out = new FileOutputStream(tempPath + "\\" +filename);
                    
                    //创建一个缓冲区
                    byte buffer[] = new byte[1024];
                    //判断输入流中的数据是否已经读完的标识
                    int len = 0;
                    //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                    while((len=in.read(buffer))>0){
                        //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                       out.write(buffer, 0, len);
                   }
                   paperurl=filename;
                   //关闭输入流
                   in.close();
                   //关闭输出流
                   out.close();
                }
            }
            //(Integer courseid, String studentdocumentname, String studentdocumentdescr,
			//String studentdocumentimageurl) {
            if(docid.length()<1)  // 添加
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
            	//修改作业
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
