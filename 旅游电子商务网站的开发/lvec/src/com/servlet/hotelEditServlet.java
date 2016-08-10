package com.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.Format;
import java.text.SimpleDateFormat;
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

import com.pojo.Hotel;
import com.service.HotelService;

public class hotelEditServlet extends HttpServlet {

	private HotelService hotelService;
	public hotelEditServlet() {
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
        try{
        	Hotel hotel=new Hotel();
        	hotel.setHotelimage("");
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
                    if(name.equals("hotelid"))
                    	hotel.setHotelid(new Integer(value));
                    if(name.equals("hotelname"))
                    	hotel.setHotelname(value);
                    if(name.equals("hotelcity"))
                    	hotel.setHotelcity(value);
                    if(name.equals("hoteladdr"))
                    	hotel.setHoteladdr(value);
                    if(name.equals("hoteldescr"))
                    	hotel.setHoteldescr(value);
                    if(name.equals("hotelremark"))
                    	hotel.setHotelremark(value);
                    if(name.equals("hotelprice"))
                    	hotel.setHotelprice(Double.valueOf(value));
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
                    hotel.setHotelimage(hotel.getHotelimage()+filename+"#");  // ͼƬ·��
                   //�ر�������
                   in.close();
                   //�ر������
                   out.close();
                }
            }
            if(hotel.getHotelid()!=null) hotel.setHotelimage(hotelService.hotelByID(hotel.getHotelid()).getHotelimage()+hotel.getHotelimage());
            hotelService.hotelModify(hotel);;  // ���浽�����ݿ���
        }catch (Exception e) {
            e.printStackTrace();
        }
	    request.getRequestDispatcher("../hotel.do?method=hotelFindExecute").forward(request, response);
	}
	public void init() throws ServletException {
		// Put your code here
		super.init();  
        ServletContext servletContext = this.getServletContext();    
        WebApplicationContext ctx =    WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);  
        hotelService = (HotelService)ctx.getBean("hotelService");
	}

}
