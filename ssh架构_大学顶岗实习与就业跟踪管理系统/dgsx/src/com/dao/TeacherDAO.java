package com.dao;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import com.pojo.Teacher;
import com.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Teacher entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Teacher
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class TeacherDAO {
	private static final Logger log = LoggerFactory.getLogger(TeacherDAO.class);
	// property constants
	public static final String NAME = "name";
	public static final String SEX = "sex";
	public static final String LEVEL = "level";
	public static final String PHONE = "phone";
	public static final String IDCARD = "idcard";
	public static final String QQID = "qqid";
	public static final String DIRECTION = "direction";
	public static final String PWD = "pwd";
	public static final String ROLETYPE = "roletype";
	public static final String RESERVED1 = "reserved1";
	public static final String RESERVED2 = "reserved2";

	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

	protected void initDao() {
		// do nothing
	}
	
	public List findByLikeNameOrId(Object value,Page p)
	{
		try {
			String queryString = "from Teacher as model where model.teaid like ? or name like ? or level like ? or level like ? or phone like ? or idcard like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3, "%"+value+"%");
			queryObject.setParameter(4, "%"+value+"%");
			queryObject.setParameter(5, "%"+value+"%");
			queryObject.setMaxResults(p.getEveryPage());
			queryObject.setFirstResult(p.getBeginIndex());
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	// 获得教师数目
	public int findNumsByLikeNameOrId(Object value)
	{
		try {
			String queryString = "select count(*) from Teacher as model where model.teaid like ? or name like ? or level like ? or level like ? or phone like ? or idcard like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3, "%"+value+"%");
			queryObject.setParameter(4, "%"+value+"%");
			queryObject.setParameter(5, "%"+value+"%");
			return ((Long)queryObject.uniqueResult()).intValue();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	
	
	public List findByLikeNameAndAcademyid(Object value,Object academyid,Page p)
	{
		try {
			String queryString = "from Teacher as model where (model.teaid like ? or name like ? or level like ? or level like ? or phone like ? or idcard like ?) and academyid=?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3, "%"+value+"%");
			queryObject.setParameter(4, "%"+value+"%");
			queryObject.setParameter(5, "%"+value+"%");
			queryObject.setParameter(6, academyid);
			queryObject.setMaxResults(p.getEveryPage());
			queryObject.setFirstResult(p.getBeginIndex());
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	// 获得教师数目
	public int findNumsByLikeNameAndAcademyid(Object value,Object academyid)
	{
		try {
			String queryString = "select count(*) from Teacher as model where (model.teaid like ? or name like ? or level like ? or level like ? or phone like ? or idcard like ?) and academyid=?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3, "%"+value+"%");
			queryObject.setParameter(4, "%"+value+"%");
			queryObject.setParameter(5, "%"+value+"%");
			queryObject.setParameter(6, academyid);
			return ((Long)queryObject.uniqueResult()).intValue();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public void save(Teacher transientInstance) {
		log.debug("saving Teacher instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Teacher persistentInstance) {
		log.debug("deleting Teacher instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Teacher findById(java.lang.String id) {
		log.debug("getting Teacher instance with id: " + id);
		try {
			Teacher instance = (Teacher) getCurrentSession().get(
					"com.pojo.Teacher", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Teacher instance) {
		log.debug("finding Teacher instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Teacher")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Teacher instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Teacher as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findBySex(Object sex) {
		return findByProperty(SEX, sex);
	}

	public List findByLevel(Object level) {
		return findByProperty(LEVEL, level);
	}

	public List findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	public List findByIdcard(Object idcard) {
		return findByProperty(IDCARD, idcard);
	}

	public List findByQqid(Object qqid) {
		return findByProperty(QQID, qqid);
	}

	public List findByDirection(Object direction) {
		return findByProperty(DIRECTION, direction);
	}

	public List findByPwd(Object pwd) {
		return findByProperty(PWD, pwd);
	}

	public List findByRoletype(Object roletype) {
		return findByProperty(ROLETYPE, roletype);
	}

	public List findByReserved1(Object reserved1) {
		return findByProperty(RESERVED1, reserved1);
	}

	public List findByReserved2(Object reserved2) {
		return findByProperty(RESERVED2, reserved2);
	}

	public List findAll() {
		log.debug("finding all Teacher instances");
		try {
			String queryString = "from Teacher";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Teacher merge(Teacher detachedInstance) {
		log.debug("merging Teacher instance");
		try {
			Teacher result = (Teacher) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Teacher instance) {
		log.debug("attaching dirty Teacher instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Teacher instance) {
		log.debug("attaching clean Teacher instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static TeacherDAO getFromApplicationContext(ApplicationContext ctx) {
		return (TeacherDAO) ctx.getBean("TeacherDAO");
	}
}