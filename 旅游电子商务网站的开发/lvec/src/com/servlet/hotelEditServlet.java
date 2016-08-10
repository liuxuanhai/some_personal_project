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

		//上传时生成的临时文件保存目录
		String tempPath = this.getServletContext().getRealPath("/upload");
		
		File tmpFile = new File(tempPath);
		if (!tmpFile.exists()) {
			//创建临时目录
			tmpFile.mkdir();
		}
        try{
        	Hotel hotel=new Hotel();
        	hotel.setHotelimage("");
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
                    hotel.setHotelimage(hotel.getHotelimage()+filename+"#");  // 图片路径
                   //关闭输入流
                   in.close();
                   //关闭输出流
                   out.close();
                }
            }
            if(hotel.getHotelid()!=null) hotel.setHotelimage(hotelService.hotelByID(hotel.getHotelid()).getHotelimage()+hotel.getHotelimage());
            hotelService.hotelModify(hotel);;  // 保存到奥数据库中
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
