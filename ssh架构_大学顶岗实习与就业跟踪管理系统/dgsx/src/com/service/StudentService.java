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
//����Ա�� �߼��ӿڷ�װ
public class StudentService {
	//student����ע��
	private StudentDAO studentDAO;

	public StudentDAO getStudentDAO() {
		return studentDAO;
	}

	public void setStudentDAO(StudentDAO studentDAO) {
		this.studentDAO = studentDAO;
	}
	
	//academy����ע��
	private AcademyDAO academyDAO;

	public AcademyDAO getAcademyDAO() {
		return academyDAO;
	}

	public void setAcademyDAO(AcademyDAO academyDAO) {
		this.academyDAO = academyDAO;
	}
	
	//classroom����ע��
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
	
	//���Ժϵ��ҵͳ��
	public List<Object[]> getAcademyClassroomJobsStat(String academyid)
	{//��У  ����ʵϰ ר���� �о��� ����Ա  �Ѿ�ҵ ��ҵ ����
		Object[][] obj=new Object[8][2];
		obj[0][0]="��У";obj[1][0]="����ʵϰ";obj[2][0]="ר����";obj[3][0]="�о���";
		obj[4][0]="����Ա";obj[5][0]="�Ѿ�ҵ";obj[6][0]="��ҵ";obj[7][0]="����";
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
	
	
	
	//���Ժϵ��ҵͳ��
	public Object[][] getAcademyJobsStat(String academyid)
	{//��У  ����ʵϰ ר���� �о��� ����Ա  �Ѿ�ҵ ��ҵ ����
		Object[][] obj=new Object[8][2];
		obj[0][0]="��У";obj[1][0]="����ʵϰ";obj[2][0]="ר����";obj[3][0]="�о���";
		obj[4][0]="����Ա";obj[5][0]="�Ѿ�ҵ";obj[6][0]="��ҵ";obj[7][0]="����";
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
	//���Class��ҵͳ��
	public Object[][] getClassJobsStat(String id)
	{//��У  ����ʵϰ ר���� �о��� ����Ա  �Ѿ�ҵ ��ҵ ����
		Object[][] obj=new Object[8][2];
		obj[0][0]="��У";obj[1][0]="����ʵϰ";obj[2][0]="ר����";obj[3][0]="�о���";
		obj[4][0]="����Ա";obj[5][0]="�Ѿ�ҵ";obj[6][0]="��ҵ";obj[7][0]="����";
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
	
	
	//���Ժϵ
	public List getAcademyName()
	{
		return academyDAO.findAll();
	}
	
	//���Ժϵ����
	public String getAcademyNameById(String id)
	{
		return academyDAO.findById(new Integer(id)).getAcademyname();
	}
	
	//���Ժϵ�༶
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
	
	// student��֤��¼
	public boolean studentLogin(Student user)
	{
		if(studentDAO.findByExample(user).size()>0)
			return true;
    	return false;
	}
	
	// ���ָ����¼student
	public Student studentByID(String id)
	{
		return studentDAO.findById(id);
	}
	
	//���ȫ����¼student
	public List studentAll()
	{
		return studentDAO.findAll();
	}
	
	//��student���ֽ���ģ����ѯ 
	public List studentLikeNameOrId(String value,Page p)
	{
		return studentDAO.findByLikeNameOrId(value,p);
	}
	
	//��ý�ʦ��Ŀ
	public int findNumsByLikeNameOrId(String value)
	{
		return  studentDAO.findNumsByLikeNameOrId(value);
	}
	
	//��student���ֽ���ģ����ѯ 
	public List studentLikeNameAndClassid(String value,String classid,Page p)
	{
		return studentDAO.findByLikeNameAndClassid(value,new Integer(classid.trim()),p);
	}
	
	//��ý�ʦ��Ŀ
	public int findNumsByLikeNameAndClassid(String value,String classid)
	{
		return  studentDAO.findNumsByLikeNameAndClassid(value,new Integer(classid.trim()));
	}

	// ��Ӽ�¼student
	public void studentAdd(Student user)
	{
		studentDAO.save(user);
	}
	
	// ɾ����¼student
	public void studentDelete(Student user)
	{
		studentDAO.delete(user);
	}
	
	// �޸ļ�¼student
	public void studentModify(Student user)
	{
		studentDAO.merge(user);
	}
	
	
}
