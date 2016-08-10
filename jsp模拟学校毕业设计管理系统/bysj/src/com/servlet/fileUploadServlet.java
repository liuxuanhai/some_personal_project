package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.dbconn.DBResult;

public class fileUploadServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public fileUploadServlet() {
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
		File tmpFile = new File(tempPath);
		if (!tmpFile.exists()) {
			//������ʱĿ¼
			tmpFile.mkdir();
		}
		String stuid="",pathtype="",path="";
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
                    //System.out.println(name + "=" + value);
                    if(name.equals("stuid"))
                    	stuid=value;
                    if(name.equals("pathtype"))
                    	pathtype=value;
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
                    path=filename;
                   //�ر�������
                   in.close();
                   //�ر������
                   out.close();
                }
            }
            DBResult dbr=new DBResult();
            dbr.doExecute("update keti set "+pathtype+"='"+path+"' where stuid='"+stuid+"'");
        }catch (Exception e) {
            e.printStackTrace();
        }
        if(pathtype.equals("ktpath"))
        request.getRequestDispatcher("../student/kaitipaper.jsp?stuid="+stuid).forward(request, response);
        else if(pathtype.equals("zqpath"))
            request.getRequestDispatcher("../student/zhongqipaper.jsp?stuid="+stuid).forward(request, response);
        else if(pathtype.equals("lwpath"))
            request.getRequestDispatcher("../student/lwcgpaper.jsp?stuid="+stuid).forward(request, response);
        else if(pathtype.equals("lastlwpath"))
            request.getRequestDispatcher("../student/lwpaper.jsp?stuid="+stuid).forward(request, response);
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
