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

import com.pojo.Gonggao;
import com.service.GonggaoService;
import com.util.StringUtil;

public class gonggaoAddServlet extends HttpServlet {

	private GonggaoService gonggaoService;
	public gonggaoAddServlet() {
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
		//�ϴ�ʱ���ɵ���ʱ�ļ�����Ŀ¼
				String tempPath = this.getServletContext().getRealPath("/upload");
				//System.out.println(tempPath);
				File tmpFile = new File(tempPath);
				if (!tmpFile.exists()) {
					//������ʱĿ¼
					tmpFile.mkdir();
				}
		        try{
		        	//Hotel hotel=new Hotel();
		        	Gonggao gonggao=new Gonggao();
		        	String id="",fujian="";
		        	gonggao.setFilename("");
		        	gonggao.setFilepath("");
		        	gonggao.setAddtime(StringUtil.getTimestampFromDate(new Date()));
		        	gonggao.setLooknum(0);
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
		                    	gonggao.setTitle(value);
		                    if(name.equals("content"))
		                    	gonggao.setContent(value);
		                    if(name.equals("gonggaoid"))
		                    	id=value;
		                    if(name.equals("fujian"))
		                    	fujian=value;
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
		                   gonggao.setFilename(gonggao.getFilename()+filename+"#");
		                   gonggao.setFilepath(gonggao.getFilepath()+newfilename+"#");
		                   //�ر�������
		                   in.close();
		                   //�ر������
		                   out.close();
		                }
		            }
		            if(id=="")
		            	gonggaoService.gonggaoAdd(gonggao);  // ���浽�����ݿ���
	            	else  // �޸�
	            	{
	            		Gonggao t=gonggaoService.gonggaoByID(new Integer(id));
	            		gonggao.setLooknum(t.getLooknum());
	            		gonggao.setId(new Integer(id));
	            		if(fujian.equals("��"))  // ������ԭ����
	            			gonggaoService.gonggaoModify(gonggao);
	            		else{  //����ԭ����
	            			gonggao.setFilename(t.getFilename()+gonggao.getFilename());
	            			gonggao.setFilepath(t.getFilepath()+gonggao.getFilepath());
	            			gonggaoService.gonggaoModify(gonggao);
	            		}
	            			
	            	}
		        }catch (Exception e) {
		            e.printStackTrace();
		        }
		        
		        request.getRequestDispatcher("../gonggao.do?method=gonggaoFindExecute").forward(request, response);
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
        gonggaoService = (GonggaoService)ctx.getBean("gonggaoService");
	}

}
