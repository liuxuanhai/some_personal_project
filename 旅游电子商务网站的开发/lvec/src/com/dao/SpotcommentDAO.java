package com.dao;

import java.sql.Timestamp;
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

import com.pojo.Spotcomment;

/**
 * A data access object (DAO) providing persistence and search support for
 * Spotcomment entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Spotcomment
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class SpotcommentDAO {
	private static final Logger log = LoggerFactory
			.getLogger(SpotcommentDAO.class);
	// property constants
	public static final String SPOTID = "spotid";
	public static final String USERID = "userid";
	public static final String CONTENT = "content";

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

	public void save(Spotcomment transientInstance) {
		log.debug("saving Spotcomment instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Spotcomment persistentInstance) {
		log.debug("deleting Spotcomment instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Spotcomment findById(java.lang.Integer id) {
		log.debug("getting Spotcomment instance with id: " + id);
		try {
			Spotcomment instance = (Spotcomment) getCurrentSession().get(
					"com.pojo.Spotcomment", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Spotcomment instance) {
		log.debug("finding Spotcomment instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Spotcomment")
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
		log.debug("finding Spotcomment instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Spotcomment as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findBySpotid(Object spotid) {
		return findByProperty(SPOTID, spotid);
	}

	public List findByUserid(Object userid) {
		return findByProperty(USERID, userid);
	}

	public List findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List findAll() {
		log.debug("finding all Spotcomment instances");
		try {
			String queryString = "from Spotcomment";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Spotcomment merge(Spotcomment detachedInstance) {
		log.debug("merging Spotcomment instance");
		try {
			Spotcomment result = (Spotcomment) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Spotcomment instance) {
		log.debug("attaching dirty Spotcomment instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Spotcomment instance) {
		log.debug("attaching clean Spotcomment instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static SpotcommentDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (SpotcommentDAO) ctx.getBean("SpotcommentDAO");
	}
}