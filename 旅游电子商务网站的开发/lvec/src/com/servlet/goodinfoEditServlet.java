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

import com.pojo.Goodinfo;
import com.service.GoodinfoService;


public class goodinfoEditServlet extends HttpServlet {

	private GoodinfoService goodinfoService;
	public goodinfoEditServlet() {
		super();
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
        try{
        	Goodinfo good=new Goodinfo();
        	good.setGoodimage("");
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
                    if(name.equals("goodname"))
                    	good.setGoodname(value);
                    if(name.equals("typeid"))
                    	good.setTypeid(new Integer(value));
                    if(name.equals("gooddescr"))
                    	good.setGooddescr(value);
                    if(name.equals("goodnum"))
                    	good.setGoodnum(new Integer(value));
                    if(name.equals("goodprice"))
                    	good.setGoodprice(Double.valueOf(value));
                    if(name.equals("goodid"))
                    	good.setGoodid(new Integer(value));
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
                    good.setGoodimage(good.getGoodimage()+filename+"#");  // ͼƬ·��
                   //�ر�������
                   in.close();
                   //�ر������
                   out.close();
                }
            }
            if(good.getGoodid()!=null) 
            	good.setGoodimage(goodinfoService.goodinfoByID(good.getGoodid()).getGoodimage()+good.getGoodimage());
            goodinfoService.goodinfoModify(good);  // ���浽�����ݿ���
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        request.getRequestDispatcher("../goodinfo.do?method=goodinfoFindExecute").forward(request, response);
	}
	
    // ��дinit  ʵ��ȡ��spring�йܵ�bean ����ʹ�ò���teacherdao ��ʵ��������ע��  ��ķ���Ҳ������spring�й�serlet
	public void init() throws ServletException {
		// Put your code here
		super.init();  
        ServletContext servletContext = this.getServletContext();    
        WebApplicationContext ctx =    WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);  
        goodinfoService = (GoodinfoService)ctx.getBean("goodinfoService");
	}
}
