package com.dao;

import java.util.List;

import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.transaction.annotation.Transactional;

import com.pojo.Studentdocument;

/**
 * A data access object (DAO) providing persistence and search support for
 * Studentdocument entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Studentdocument
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class StudentdocumentDAO {
	private static final Logger log = LoggerFactory
			.getLogger(StudentdocumentDAO.class);
	// property constants
	public static final String STUID = "stuid";
	public static final String PAPERNAME = "papername";
	public static final String PAPERURL = "paperurl";
	public static final String PAPERSTATUS = "paperstatus";
	public static final String PAPERTYPE = "papertype";
	public static final String REMARK = "remark";

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

	public void save(Studentdocument transientInstance) {
		log.debug("saving Studentdocument instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Studentdocument persistentInstance) {
		log.debug("deleting Studentdocument instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Studentdocument findById(java.lang.Integer id) {
		log.debug("getting Studentdocument instance with id: " + id);
		try {
			Studentdocument instance = (Studentdocument) getCurrentSession()
					.get("com.pojo.Studentdocument", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Studentdocument instance) {
		log.debug("finding Studentdocument instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Studentdocument")
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
		log.debug("finding Studentdocument instance with property: "
				+ propertyName + ", value: " + value);
		try {
			String queryString = "from Studentdocument as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByStuid(Object stuid) {
		return findByProperty(STUID, stuid);
	}

	public List findByPapername(Object papername) {
		return findByProperty(PAPERNAME, papername);
	}

	public List findByPaperurl(Object paperurl) {
		return findByProperty(PAPERURL, paperurl);
	}

	public List findByPaperstatus(Object paperstatus) {
		return findByProperty(PAPERSTATUS, paperstatus);
	}

	public List findByPapertype(Object papertype) {
		return findByProperty(PAPERTYPE, papertype);
	}

	public List findByRemark(Object remark) {
		return findByProperty(REMARK, remark);
	}

	public List findAll() {
		log.debug("finding all Studentdocument instances");
		try {
			String queryString = "from Studentdocument";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Studentdocument merge(Studentdocument detachedInstance) {
		log.debug("merging Studentdocument instance");
		try {
			Studentdocument result = (Studentdocument) getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Studentdocument instance) {
		log.debug("attaching dirty Studentdocument instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Studentdocument instance) {
		log.debug("attaching clean Studentdocument instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static StudentdocumentDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (StudentdocumentDAO) ctx.getBean("StudentdocumentDAO");
	}
}