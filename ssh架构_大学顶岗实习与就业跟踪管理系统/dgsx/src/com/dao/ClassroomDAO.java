package com.dao;

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

import com.pojo.Classroom;
import com.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Classroom entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Classroom
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class ClassroomDAO {
	private static final Logger log = LoggerFactory
			.getLogger(ClassroomDAO.class);
	// property constants
	public static final String CLASSNAME = "classname";
	public static final String CLASSDESCR = "classdescr";

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

	public int findNumsByLikeNameAndAcademyid(Object value,Object academyid)
	{
		try {
			String queryString = "select count(*) from Classroom as model where (model.classname like ?) and academyid=?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1,academyid);
			return ((Long)queryObject.uniqueResult()).intValue();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByLikeNameAndAcademyid(Object value,Object academyid,Page p)
	{
		try {
			String queryString = "from Classroom as model where (model.classname like ?) and academyid=?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1,academyid);
			queryObject.setMaxResults(p.getEveryPage());
			queryObject.setFirstResult(p.getBeginIndex());
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	public void save(Classroom transientInstance) {
		log.debug("saving Classroom instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Classroom persistentInstance) {
		log.debug("deleting Classroom instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Classroom findById(java.lang.Integer id) {
		log.debug("getting Classroom instance with id: " + id);
		try {
			Classroom instance = (Classroom) getCurrentSession().get(
					"com.pojo.Classroom", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Classroom instance) {
		log.debug("finding Classroom instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Classroom")
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
		log.debug("finding Classroom instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Classroom as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByClassname(Object classname) {
		return findByProperty(CLASSNAME, classname);
	}

	public List findByClassdescr(Object classdescr) {
		return findByProperty(CLASSDESCR, classdescr);
	}

	public List findAll() {
		log.debug("finding all Classroom instances");
		try {
			String queryString = "from Classroom";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Classroom merge(Classroom detachedInstance) {
		log.debug("merging Classroom instance");
		try {
			Classroom result = (Classroom) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Classroom instance) {
		log.debug("attaching dirty Classroom instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Classroom instance) {
		log.debug("attaching clean Classroom instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ClassroomDAO getFromApplicationContext(ApplicationContext ctx) {
		return (ClassroomDAO) ctx.getBean("ClassroomDAO");
	}
}