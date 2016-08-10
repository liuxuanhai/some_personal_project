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
        //�õ�Ҫ���ص��ļ���
        String stuid = request.getParameter("stuid");  //ѧ��
        String filename=request.getParameter("taskpath");  //ѧ��;
        String fileSaveRootPath=this.getServletContext().getRealPath("/upload");
        //�õ�Ҫ���ص��ļ�
        File file = new File(fileSaveRootPath+ "\\" +filename);
        if(file.exists()) // ����ļ�����
        {
        	//�����ļ���
            String realname = stuid+"_"+filename;
            //������Ӧͷ��������������ظ��ļ�
            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realname, "UTF-8"));
            //��ȡҪ���ص��ļ������浽�ļ�������
            FileInputStream in = new FileInputStream(fileSaveRootPath+ "\\" +filename);
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
