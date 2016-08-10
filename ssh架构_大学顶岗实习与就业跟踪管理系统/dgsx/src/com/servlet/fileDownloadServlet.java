package com.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class fileDownloadServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public fileDownloadServlet() {
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
		String filepath=request.getParameter("filepath");  //学号;
        String filename = request.getParameter("filename");  //文件名
        System.out.println(filepath);
        String tempPath = this.getServletContext().getRealPath("/upload");
        //得到要下载的文件
        File file = new File(tempPath+ "\\" +filepath);
        if(file.exists()) // 如果文件存在
        {
        	System.out.println(filename);
            //设置响应头，控制浏览器下载该文件
            response.setHeader("content-disposition", "attachment;filename=" +filename);// URLEncoder.encode(filename, "UTF-8"));
            //读取要下载的文件，保存到文件输入流
            FileInputStream in = new FileInputStream(tempPath+ "\\" +filepath);
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
        }else
        {
        	response.setContentType("text/html");
    		PrintWriter out = response.getWriter();
    		out.println("  <script type='text/javascript'> alert('文档不存在');window.history.go(-1);</script>");
    		out.println("</HTML>");
    		out.flush();
    		out.close();
        }
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
