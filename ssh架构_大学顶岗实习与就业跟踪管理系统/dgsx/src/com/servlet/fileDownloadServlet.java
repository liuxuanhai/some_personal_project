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
		//�õ�Ҫ���ص��ļ���
		String filepath=request.getParameter("filepath");  //ѧ��;
        String filename = request.getParameter("filename");  //�ļ���
        System.out.println(filepath);
        String tempPath = this.getServletContext().getRealPath("/upload");
        //�õ�Ҫ���ص��ļ�
        File file = new File(tempPath+ "\\" +filepath);
        if(file.exists()) // ����ļ�����
        {
        	System.out.println(filename);
            //������Ӧͷ��������������ظ��ļ�
            response.setHeader("content-disposition", "attachment;filename=" +filename);// URLEncoder.encode(filename, "UTF-8"));
            //��ȡҪ���ص��ļ������浽�ļ�������
            FileInputStream in = new FileInputStream(tempPath+ "\\" +filepath);
            //���������
            OutputStream out = response.getOutputStream();
            //����������
            byte buffer[] = new byte[1024];
            int len = 0;
            //ѭ�����������е����ݶ�ȡ������������
            while((len=in.read(buffer))>0){
                //��������������ݵ��������ʵ���ļ�����
                out.write(buffer, 0, len);
            }
            //�ر��ļ�������
            in.close();
            //�ر������
            out.close();
        }else
        {
        	response.setContentType("text/html");
    		PrintWriter out = response.getWriter();
    		out.println("  <script type='text/javascript'> alert('�ĵ�������');window.history.go(-1);</script>");
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
