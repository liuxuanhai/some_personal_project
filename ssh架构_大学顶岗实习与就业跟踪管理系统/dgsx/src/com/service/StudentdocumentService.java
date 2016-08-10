package com.service;
import com.dao.ClassroomDAO;
import com.dao.StudentDAO;
import com.dao.StudentdocumentDAO;
import com.dao.TeacherDAO;
import com.pojo.Academy;
import com.pojo.Classroom;
import com.pojo.Student;
import com.pojo.Studentdocument;
import com.pojo.Teacher;
import com.util.Page;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
//����Ա�� �߼��ӿڷ�װ
public class StudentdocumentService {
	//studentdocument����ע��
	private StudentdocumentDAO studentdocumentDAO;

	public StudentdocumentDAO getStudentdocumentDAO() {
		return studentdocumentDAO;
	}

	public void setStudentdocumentDAO(StudentdocumentDAO studentdocumentDAO) {
		this.studentdocumentDAO = studentdocumentDAO;
	}
	
	//teacher����ע��
	private TeacherDAO teacherDAO;

	public TeacherDAO getTeacherDAO() {
		return teacherDAO;
	}

	public void setTeacherDAO(TeacherDAO teacherDAO) {
		this.teacherDAO = teacherDAO;
	}
	// ���ָ����¼teacher
	public Teacher teacherByID(String id)
	{
		return teacherDAO.findById(id);
	}
	//academy����ע��
	private StudentDAO studentDAO;
	public StudentDAO getStudentDAO() {
		return studentDAO;
	}

	public void setStudentDAO(StudentDAO studentDAO) {
		this.studentDAO = studentDAO;
	}
	
	// ���ѧ��
	public Student getStudentByStuid(String stuid)
	{
		return studentDAO.findById(stuid);
	}
	
	//classroom����ע��
	private ClassroomDAO classroomDAO;

	public ClassroomDAO getClassroomDAO() {
		return classroomDAO;
	}

	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}
	
	//����ĵ�
	public List<Object[]> getStudentDocByStuidAndType(String stuid,String type)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Student stu=getStudentByStuid(stuid);
		for(Object doc:stu.getStudentdocuments())
		{
			Studentdocument studoc=(Studentdocument)doc;
			if(studoc.getPapertype().equals(type.trim())) // ��Ӧ�ĵ��ͷ���
			{
				Object []obj=new Object[7];
				obj[0]=studoc.getPapertype();
				obj[1]=studoc.getPapername();
				obj[2]=studoc.getRemark();
				obj[3]=stu.getClassroom().getTeacher();  // ָ����ʦ
				obj[4]=studoc.getPaperstatus();  // ���״̬
				obj[5]=studoc.getPaperurl();  //�ĵ�·��
				obj[6]=studoc.getId();   // �ĵ�id
				list.add(obj);
			}
		}
		return list;  // �����ĵ�
	}
	//��ð༶�ĵ�
	public List<Object[]> getStudentDocByTypeAndClassid(String classid,String papertype, String paperstuatus,String findinfo)
	{
		if(classid==null||classid=="") return null;
		List<Object[]> list=new ArrayList<Object[]>();
		Classroom cls=classroomDAO.findById(new Integer(classid)); // ��ð༶
		for(Object stu:cls.getStudents())
		{
			Student student=(Student)stu;
			Object[] obj=new Object[7];
			obj[0]=student.getStuid();  // ѧ��
			obj[1]=student.getName();  //����
			Set tempset=student.getStudentdocuments();
			Studentdocument studoc=null;
			for(Object doc:tempset)   // �鿴��ѧ���Ĵ������ĵ��Ƿ��Ѿ��ύ
			{
				studoc=(Studentdocument)doc;
				if(studoc.getPapertype().equals(papertype))
					break;
				else
					studoc=null;
			}
			if(studoc==null)  // δ�ύ
			  {
				obj[2]="";
				obj[3]="";
				obj[4]="";
				obj[5]="";
			  }
			else
			{
				obj[2]=studoc.getPapername();
				obj[3]=studoc.getRemark();
				obj[4]=studoc.getPaperstatus();
				obj[5]=studoc.getPaperurl();
				obj[6]=studoc.getId();
			}
			if(paperstuatus.equals(obj[4].toString())&&(obj[0].toString().indexOf(findinfo)>=0||obj[1].toString().indexOf(findinfo)>=0))
				list.add(obj);
		}
		return list;  // �����ĵ�
	}
	
	
	//��ð༶�ĵ�
	public List<Object[]> getStudentDocByTypeAndClassid(String classid,String papertype, String findinfo)
	{
		if(classid==null||classid=="") return null;
		List<Object[]> list=new ArrayList<Object[]>();
		Classroom cls=classroomDAO.findById(new Integer(classid)); // ��ð༶
		for(Object stu:cls.getStudents())
		{
			Student student=(Student)stu;
			Object[] obj=new Object[4];
			obj[0]=student.getStuid();  // ѧ��
			obj[1]=student.getName();  //����
			Set tempset=student.getStudentdocuments();
			Studentdocument studoc=null;
			int nums=0,nums1=0;  //�ĵ���Ŀ �������Ŀ
			for(Object doc:tempset)   // �鿴��ѧ���Ĵ������ĵ��Ƿ��Ѿ��ύ
			{
				studoc=(Studentdocument)doc;
				if(studoc.getPapertype().equals(papertype))
				{
					nums++;
					if(studoc.getPaperstatus().equals("0"))
						nums1++;  //ͳ�ƴ���˵���Ŀ
				}
			}
			obj[2]=nums;
			obj[3]=nums1;
			if(obj[0].toString().indexOf(findinfo)>=0||obj[1].toString().indexOf(findinfo)>=0)
				list.add(obj);
		}
		return list;  // �����ĵ�
	}
	
	//��ô���˵Ĳ���
	public List getStudentDocByReviewByTeaid(String teaid)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Teacher tea=teacherDAO.findById(teaid);
		List<Studentdocument> studoclist=studentdocumentDAO.findByPaperstatus("0"); // ��ѯ���д���˵Ĳ���
		Student stu;
		for(int i=0;i<studoclist.size();++i)
		{
			stu=studentIsShuyuTea(tea,studoclist.get(i).getStuid());
			if(stu!=null)
			{
				// �����ѧ�� �����list
				Object[] obj=new Object[7];
				obj[0]=stu.getStuid();  // ѧ��
				obj[1]=stu.getName();  //����
				
				obj[2]=studoclist.get(i).getPapername();  //��������
				obj[3]=studoclist.get(i).getRemark();  //����˵��
				obj[4]=studoclist.get(i).getPapertype();  //��������
				obj[5]=studoclist.get(i).getPaperurl();  //����·��
				obj[6]=studoclist.get(i).getId();  // ����id
				list.add(obj);
			}
		}
		return list;
	}
	public Student studentIsShuyuTea(Teacher tea,String stuid)
	{
		// ��ѯ��ѧ�ŵ�ѧ���Ƿ���ʦ������
		for(Object obj1:tea.getClassrooms())  // ��ý�ʦ����İ༶
		{
			Classroom cls=(Classroom)obj1;
			for(Object obj2:cls.getStudents())  // ��ð༶ѧ��
			{
				Student stu=(Student)obj2; 
				if(stu.getStuid().equals(stuid))  // �ҵ�ѧ��
					return stu;
			}
		}
		return null;
	}
	// ���ָ��ѧ����ʵϰ�ܼ�
	public List<Object[]> getStudentDocByStuid(String stuid)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Student student=studentDAO.findById(stuid);
		Set tempset=student.getStudentdocuments();
		Studentdocument studoc=null;
		for(Object doc:tempset)   // �鿴��ѧ���Ĵ������ĵ��Ƿ��Ѿ��ύ
		{
			studoc=(Studentdocument)doc;
			if(studoc.getPapertype().equals("0"))  //0��ʵϰ�ܼ�
			{
				Object[] obj=new Object[7];
				obj[0]=student.getStuid();
				obj[1]=student.getName();  //����
				obj[2]=studoc.getPapername();
				obj[3]=studoc.getRemark();
				obj[4]=studoc.getPaperstatus();
				obj[5]=studoc.getPaperurl();
				obj[6]=studoc.getId();
				list.add(obj);
			}
		}
		return list;  // �����ĵ�
	}
	
	// ���ָ����¼studentdocument
	public Studentdocument studentdocumentByID(String id)
	{
		return studentdocumentDAO.findById(new Integer(id));
	}
	
	//���ȫ����¼studentdocument
	public List studentdocumentAll()
	{
		return studentdocumentDAO.findAll();
	}
	
	// ��Ӽ�¼studentdocument
	public void studentdocumentAdd(Studentdocument user)
	{
		studentdocumentDAO.save(user);
	}
	
	// ɾ����¼studentdocument
	public void studentdocumentDelete(Studentdocument user)
	{
		studentdocumentDAO.delete(user);
	}
	
	// �޸ļ�¼studentdocument
	public void studentdocumentModify(Studentdocument user)
	{
		studentdocumentDAO.merge(user);
	}
}
