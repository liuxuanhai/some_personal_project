package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
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

import com.pojo.Luntanhuati;
import com.service.LuntanhuatiService;
import com.util.StringUtil;

public class luntanhuatiAddServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	private LuntanhuatiService luntanhuatiService;
	public luntanhuatiAddServlet() {
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
		//System.out.println(tempPath);
		File tmpFile = new File(tempPath);
		if (!tmpFile.exists()) {
			//������ʱĿ¼
			tmpFile.mkdir();
		}
		String stuid="";
        try{
        	//Hotel hotel=new Hotel();
        	Luntanhuati news=new Luntanhuati();
        	news.setFilepath("");
        	news.setAddtime(StringUtil.getTimestampFromDate(new Date()));
        	news.setLooknum(0);
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
                    //System.out.println(name + "=" + value);
                    if(name.equals("title"))
                    	news.setTitle(value);
                    if(name.equals("content"))
                    	news.setContent(value);
                    if(name.equals("username"))
                    	news.setUsername(value);;
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
                    String newfilename=UUID.randomUUID().toString()+fileExtName;
                    //System.out.println(filename);
                    // ������
                    FileOutputStream out = new FileOutputStream(tempPath + "\\" +newfilename);
                    
                    //����һ��������
                    byte buffer[] = new byte[1024];
                    //�ж��������е������Ƿ��Ѿ�����ı�ʶ
                    int len = 0;
                    //ѭ�������������뵽���������У�(len=in.read(buffer))>0�ͱ�ʾin���滹������
                    while((len=in.read(buffer))>0){
                        //ʹ��FileOutputStream�������������������д�뵽ָ����Ŀ¼(savePath + "\\" + filename)����
                       out.write(buffer, 0, len);
                   }
                    news.setFilepath(news.getFilepath()+newfilename+"#");
                   //�ر�������
                   in.close();
                   //�ر������
                   out.close();
                }
            }
            System.out.println(stuid);
            luntanhuatiService.addLuntanhuati(news);
        	
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("../luntanhuati.do?method=luntanhuatiListExecute").forward(request, response);
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
        luntanhuatiService = (LuntanhuatiService)ctx.getBean("luntanhuatiService");
	}

}
