package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
public class taskDownloadServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public taskDownloadServlet() {
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
        //得到要下载的文件名
        String stuid = request.getParameter("stuid");  //学号
        String filename=request.getParameter("taskpath");  //学号;
        String fileSaveRootPath=this.getServletContext().getRealPath("/upload");
        //得到要下载的文件
        File file = new File(fileSaveRootPath+ "\\" +filename);
        if(file.exists()) // 如果文件存在
        {
        	//处理文件名
            String realname = stuid+"_"+filename;
            //设置响应头，控制浏览器下载该文件
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realname, "UTF-8"));
            //读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(fileSaveRootPath+ "\\" +filename);
            //创建输出流
            OutputStream out = response.getOutputStream();
            //创建缓冲区
            byte buffer[] = new byte[1024];
            int len = 0;
            //循环将输入流中的内容读取到缓冲区当中
            while((len=in.read(buffer))>0){
                //输出缓冲区的内容到浏览器，实现文件下载
                out.write(buffer, 0, len);
            }
            //关闭文件输入流
            in.close();
            //关闭输出流
            out.close();
        }
    }
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
	public void init() throws ServletException {
		// Put your code here
	}

}
