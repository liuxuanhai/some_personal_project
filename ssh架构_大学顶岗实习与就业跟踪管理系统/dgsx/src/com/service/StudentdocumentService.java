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
//管理员表 逻辑接口封装
public class StudentdocumentService {
	//studentdocument依赖注入
	private StudentdocumentDAO studentdocumentDAO;

	public StudentdocumentDAO getStudentdocumentDAO() {
		return studentdocumentDAO;
	}

	public void setStudentdocumentDAO(StudentdocumentDAO studentdocumentDAO) {
		this.studentdocumentDAO = studentdocumentDAO;
	}
	
	//teacher依赖注入
	private TeacherDAO teacherDAO;

	public TeacherDAO getTeacherDAO() {
		return teacherDAO;
	}

	public void setTeacherDAO(TeacherDAO teacherDAO) {
		this.teacherDAO = teacherDAO;
	}
	// 获得指定记录teacher
	public Teacher teacherByID(String id)
	{
		return teacherDAO.findById(id);
	}
	//academy依赖注入
	private StudentDAO studentDAO;
	public StudentDAO getStudentDAO() {
		return studentDAO;
	}

	public void setStudentDAO(StudentDAO studentDAO) {
		this.studentDAO = studentDAO;
	}
	
	// 获得学生
	public Student getStudentByStuid(String stuid)
	{
		return studentDAO.findById(stuid);
	}
	
	//classroom依赖注入
	private ClassroomDAO classroomDAO;

	public ClassroomDAO getClassroomDAO() {
		return classroomDAO;
	}

	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}
	
	//获得文档
	public List<Object[]> getStudentDocByStuidAndType(String stuid,String type)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Student stu=getStudentByStuid(stuid);
		for(Object doc:stu.getStudentdocuments())
		{
			Studentdocument studoc=(Studentdocument)doc;
			if(studoc.getPapertype().equals(type.trim())) // 对应文档就返回
			{
				Object []obj=new Object[7];
				obj[0]=studoc.getPapertype();
				obj[1]=studoc.getPapername();
				obj[2]=studoc.getRemark();
				obj[3]=stu.getClassroom().getTeacher();  // 指导老师
				obj[4]=studoc.getPaperstatus();  // 审核状态
				obj[5]=studoc.getPaperurl();  //文档路径
				obj[6]=studoc.getId();   // 文档id
				list.add(obj);
			}
		}
		return list;  // 返回文档
	}
	//获得班级文档
	public List<Object[]> getStudentDocByTypeAndClassid(String classid,String papertype, String paperstuatus,String findinfo)
	{
		if(classid==null||classid=="") return null;
		List<Object[]> list=new ArrayList<Object[]>();
		Classroom cls=classroomDAO.findById(new Integer(classid)); // 获得班级
		for(Object stu:cls.getStudents())
		{
			Student student=(Student)stu;
			Object[] obj=new Object[7];
			obj[0]=student.getStuid();  // 学号
			obj[1]=student.getName();  //姓名
			Set tempset=student.getStudentdocuments();
			Studentdocument studoc=null;
			for(Object doc:tempset)   // 查看此学生的此类型文档是否已经提交
			{
				studoc=(Studentdocument)doc;
				if(studoc.getPapertype().equals(papertype))
					break;
				else
					studoc=null;
			}
			if(studoc==null)  // 未提交
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
		return list;  // 返回文档
	}
	
	
	//获得班级文档
	public List<Object[]> getStudentDocByTypeAndClassid(String classid,String papertype, String findinfo)
	{
		if(classid==null||classid=="") return null;
		List<Object[]> list=new ArrayList<Object[]>();
		Classroom cls=classroomDAO.findById(new Integer(classid)); // 获得班级
		for(Object stu:cls.getStudents())
		{
			Student student=(Student)stu;
			Object[] obj=new Object[4];
			obj[0]=student.getStuid();  // 学号
			obj[1]=student.getName();  //姓名
			Set tempset=student.getStudentdocuments();
			Studentdocument studoc=null;
			int nums=0,nums1=0;  //文档数目 待审核数目
			for(Object doc:tempset)   // 查看此学生的此类型文档是否已经提交
			{
				studoc=(Studentdocument)doc;
				if(studoc.getPapertype().equals(papertype))
				{
					nums++;
					if(studoc.getPaperstatus().equals("0"))
						nums1++;  //统计待审核的数目
				}
			}
			obj[2]=nums;
			obj[3]=nums1;
			if(obj[0].toString().indexOf(findinfo)>=0||obj[1].toString().indexOf(findinfo)>=0)
				list.add(obj);
		}
		return list;  // 返回文档
	}
	
	//获得待审核的材料
	public List getStudentDocByReviewByTeaid(String teaid)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Teacher tea=teacherDAO.findById(teaid);
		List<Studentdocument> studoclist=studentdocumentDAO.findByPaperstatus("0"); // 查询所有待审核的材料
		Student stu;
		for(int i=0;i<studoclist.size();++i)
		{
			stu=studentIsShuyuTea(tea,studoclist.get(i).getStuid());
			if(stu!=null)
			{
				// 负责此学生 则加入list
				Object[] obj=new Object[7];
				obj[0]=stu.getStuid();  // 学号
				obj[1]=stu.getName();  //姓名
				
				obj[2]=studoclist.get(i).getPapername();  //材料名称
				obj[3]=studoclist.get(i).getRemark();  //材料说明
				obj[4]=studoclist.get(i).getPapertype();  //材料类型
				obj[5]=studoclist.get(i).getPaperurl();  //材料路径
				obj[6]=studoclist.get(i).getId();  // 材料id
				list.add(obj);
			}
		}
		return list;
	}
	public Student studentIsShuyuTea(Teacher tea,String stuid)
	{
		// 查询次学号的学生是否归教师所负责
		for(Object obj1:tea.getClassrooms())  // 获得教师负责的班级
		{
			Classroom cls=(Classroom)obj1;
			for(Object obj2:cls.getStudents())  // 获得班级学生
			{
				Student stu=(Student)obj2; 
				if(stu.getStuid().equals(stuid))  // 找到学生
					return stu;
			}
		}
		return null;
	}
	// 获得指定学生的实习周记
	public List<Object[]> getStudentDocByStuid(String stuid)
	{
		List<Object[]> list=new ArrayList<Object[]>();
		Student student=studentDAO.findById(stuid);
		Set tempset=student.getStudentdocuments();
		Studentdocument studoc=null;
		for(Object doc:tempset)   // 查看此学生的此类型文档是否已经提交
		{
			studoc=(Studentdocument)doc;
			if(studoc.getPapertype().equals("0"))  //0是实习周记
			{
				Object[] obj=new Object[7];
				obj[0]=student.getStuid();
				obj[1]=student.getName();  //姓名
				obj[2]=studoc.getPapername();
				obj[3]=studoc.getRemark();
				obj[4]=studoc.getPaperstatus();
				obj[5]=studoc.getPaperurl();
				obj[6]=studoc.getId();
				list.add(obj);
			}
		}
		return list;  // 返回文档
	}
	
	// 获得指定记录studentdocument
	public Studentdocument studentdocumentByID(String id)
	{
		return studentdocumentDAO.findById(new Integer(id));
	}
	
	//获得全部记录studentdocument
	public List studentdocumentAll()
	{
		return studentdocumentDAO.findAll();
	}
	
	// 添加记录studentdocument
	public void studentdocumentAdd(Studentdocument user)
	{
		studentdocumentDAO.save(user);
	}
	
	// 删除记录studentdocument
	public void studentdocumentDelete(Studentdocument user)
	{
		studentdocumentDAO.delete(user);
	}
	
	// 修改记录studentdocument
	public void studentdocumentModify(Studentdocument user)
	{
		studentdocumentDAO.merge(user);
	}
}
