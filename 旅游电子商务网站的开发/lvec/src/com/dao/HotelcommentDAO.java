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

import com.pojo.Hotelcomment;

/**
 * A data access object (DAO) providing persistence and search support for
 * Hotelcomment entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Hotelcomment
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class HotelcommentDAO {
	private static final Logger log = LoggerFactory
			.getLogger(HotelcommentDAO.class);
	// property constants
	public static final String HOTELID = "hotelid";
	public static final String USERID = "userid";
	public static final String USERNAME = "username";
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

	public void save(Hotelcomment transientInstance) {
		log.debug("saving Hotelcomment instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Hotelcomment persistentInstance) {
		log.debug("deleting Hotelcomment instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Hotelcomment findById(java.lang.Integer id) {
		log.debug("getting Hotelcomment instance with id: " + id);
		try {
			Hotelcomment instance = (Hotelcomment) getCurrentSession().get(
					"com.pojo.Hotelcomment", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Hotelcomment instance) {
		log.debug("finding Hotelcomment instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Hotelcomment")
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
		log.debug("finding Hotelcomment instance with property: "
				+ propertyName + ", value: " + value);
		try {
			String queryString = "from Hotelcomment as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByHotelid(Object hotelid) {
		return findByProperty(HOTELID, hotelid);
	}

	public List findByUserid(Object userid) {
		return findByProperty(USERID, userid);
	}

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}

	public List findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List findAll() {
		log.debug("finding all Hotelcomment instances");
		try {
			String queryString = "from Hotelcomment";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Hotelcomment merge(Hotelcomment detachedInstance) {
		log.debug("merging Hotelcomment instance");
		try {
			Hotelcomment result = (Hotelcomment) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Hotelcomment instance) {
		log.debug("attaching dirty Hotelcomment instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Hotelcomment instance) {
		log.debug("attaching clean Hotelcomment instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static HotelcommentDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (HotelcommentDAO) ctx.getBean("HotelcommentDAO");
	}
}