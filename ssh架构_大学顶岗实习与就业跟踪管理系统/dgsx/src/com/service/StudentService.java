package com.service;
import com.dao.AcademyDAO;
import com.dao.ClassroomDAO;
import com.dao.StudentDAO;
import com.pojo.Academy;
import com.pojo.Classroom;
import com.pojo.Student;
import com.util.Page;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
//管理员表 逻辑接口封装
public class StudentService {
	//student依赖注入
	private StudentDAO studentDAO;

	public StudentDAO getStudentDAO() {
		return studentDAO;
	}

	public void setStudentDAO(StudentDAO studentDAO) {
		this.studentDAO = studentDAO;
	}
	
	//academy依赖注入
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	//classroom依赖注入
	private ClassroomDAO classroomDAO;

	public ClassroomDAO getClassroomDAO() {
		return classroomDAO;
	}

	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}
	
	public Classroom getClassroomByclassid(String id)
	{
		return classroomDAO.findById(new Integer(id));
	}
	
	//获得院系就业统计
	public List<Object[]> getAcademyClassroomJobsStat(String academyid)
	{//在校  顶岗实习 专升本 研究生 公务员  已就业 创业 入伍
		Object[][] obj=new Object[8][2];
		obj[0][0]="在校";obj[1][0]="顶岗实习";obj[2][0]="专升本";obj[3][0]="研究生";
		obj[4][0]="公务员";obj[5][0]="已就业";obj[6][0]="创业";obj[7][0]="入伍";
		for(int i=0;i<8;++i) obj[i][1]=0;
		Academy aca=academyDAO.findById(new Integer(academyid));
		List<Object[]> list=new ArrayList<Object[]>();
		Classroom cls;
		Student stu;
		for(Object o1:aca.getClassrooms())
		{
			int n=0;
			cls=(Classroom)o1;
			for(Object o2:cls.getStudents())
			{
				++n;
				stu=(Student)o2;
				for(int i=0;i<8;++i)
					if(stu.getDirtype().indexOf(obj[i][0].toString())>=0)
					{
						obj[i][1]=Integer.parseInt(String.valueOf(obj[i][1]))+1;
						break;
					}
			}
			Object[]  o3=new Object[11];
			o3[0]=cls.getClassid();
			o3[1]=cls.getClassname();
			o3[2]=n;
			for(int i=0;i<8;++i)
			{
				o3[3+i]=obj[i][1];
				obj[i][1]=0;
			}
			list.add(o3);
		}
		return list;
	}
	
	
	
	//获得院系就业统计
	public Object[][] getAcademyJobsStat(String academyid)
	{//在校  顶岗实习 专升本 研究生 公务员  已就业 创业 入伍
		Object[][] obj=new Object[8][2];
		obj[0][0]="在校";obj[1][0]="顶岗实习";obj[2][0]="专升本";obj[3][0]="研究生";
		obj[4][0]="公务员";obj[5][0]="已就业";obj[6][0]="创业";obj[7][0]="入伍";
		for(int i=0;i<8;++i) obj[i][1]=0;
		Academy aca=academyDAO.findById(new Integer(academyid));
		Classroom cls;
		Student stu;
		for(Object o1:aca.getClassrooms())
		{
			cls=(Classroom)o1;
			//System.out.println(cls.getClassname());
			for(Object o2:cls.getStudents())
			{
				stu=(Student)o2;
				for(int i=0;i<8;++i)
					if(stu.getDirtype().indexOf(obj[i][0].toString())>=0)
					{
						obj[i][1]=Integer.parseInt(String.valueOf(obj[i][1]))+1;
						break;
					}
			}
		}
		return obj;
	}
	//获得Class就业统计
	public Object[][] getClassJobsStat(String id)
	{//在校  顶岗实习 专升本 研究生 公务员  已就业 创业 入伍
		Object[][] obj=new Object[8][2];
		obj[0][0]="在校";obj[1][0]="顶岗实习";obj[2][0]="专升本";obj[3][0]="研究生";
		obj[4][0]="公务员";obj[5][0]="已就业";obj[6][0]="创业";obj[7][0]="入伍";
		for(int i=0;i<8;++i) obj[i][1]=0;
		Classroom cls=classroomDAO.findById(new Integer(id));
		Student stu;
		for(Object o2:cls.getStudents())
		{
			stu=(Student)o2;
			for(int i=0;i<8;++i)
				if(stu.getDirtype().indexOf(obj[i][0].toString())>=0)
				{
					obj[i][1]=Integer.parseInt(String.valueOf(obj[i][1]))+1;
					break;
				}
		}
		
		return obj;
	}
	
	
	//获得院系
	public List getAcademyName()
	{
		return academyDAO.findAll();
	}
	
	//获得院系名称
	public String getAcademyNameById(String id)
	{
		return academyDAO.findById(new Integer(id)).getAcademyname();
	}
	
	//获得院系班级
	public Object[][] getAcademyClassroom(String academyid)
	{
		Set<Classroom> classrooms=academyDAO.findById(new Integer(academyid.trim())).getClassrooms();
		Object[][] obj=new Object[classrooms.size()][2];
		int i=0;
		for (Classroom cls: classrooms)
		{
			obj[i][0]=cls.getClassid();
			obj[i][1]=cls.getClassname();
			++i;
		}
		return obj;
	}
	
	// student验证登录
	public boolean studentLogin(Student user)
	{
		if(studentDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// 获得指定记录student
	public Student studentByID(String id)
	{
		return studentDAO.findById(id);
	}
	
	//获得全部记录student
	public List studentAll()
	{
		return studentDAO.findAll();
	}
	
	//对student名字进行模糊查询 
	public List studentLikeNameOrId(String value,Page p)
	{
		return studentDAO.findByLikeNameOrId(value,p);
	}
	
	//获得教师数目
	public int findNumsByLikeNameOrId(String value)
	{
		return  studentDAO.findNumsByLikeNameOrId(value);
	}
	
	//对student名字进行模糊查询 
	public List studentLikeNameAndClassid(String value,String classid,Page p)
	{
		return studentDAO.findByLikeNameAndClassid(value,new Integer(classid.trim()),p);
	}
	
	//获得教师数目
	public int findNumsByLikeNameAndClassid(String value,String classid)
	{
		return  studentDAO.findNumsByLikeNameAndClassid(value,new Integer(classid.trim()));
	}

	// 添加记录student
	public void studentAdd(Student user)
	{
		studentDAO.save(user);
	}
	
	// 删除记录student
	public void studentDelete(Student user)
	{
		studentDAO.delete(user);
	}
	
	// 修改记录student
	public void studentModify(Student user)
	{
		studentDAO.merge(user);
	}
	
	
}
