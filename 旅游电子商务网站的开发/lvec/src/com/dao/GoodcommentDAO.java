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

import com.pojo.Goodcomment;

/**
 * A data access object (DAO) providing persistence and search support for
 * Goodcomment entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Goodcomment
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class GoodcommentDAO {
	private static final Logger log = LoggerFactory
			.getLogger(GoodcommentDAO.class);
	// property constants
	public static final String GOODID = "goodid";
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

	public void save(Goodcomment transientInstance) {
		log.debug("saving Goodcomment instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Goodcomment persistentInstance) {
		log.debug("deleting Goodcomment instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Goodcomment findById(java.lang.Integer id) {
		log.debug("getting Goodcomment instance with id: " + id);
		try {
			Goodcomment instance = (Goodcomment) getCurrentSession().get(
					"com.pojo.Goodcomment", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Goodcomment instance) {
		log.debug("finding Goodcomment instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Goodcomment")
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
		log.debug("finding Goodcomment instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Goodcomment as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByGoodid(Object goodid) {
		return findByProperty(GOODID, goodid);
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
		log.debug("finding all Goodcomment instances");
		try {
			String queryString = "from Goodcomment";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Goodcomment merge(Goodcomment detachedInstance) {
		log.debug("merging Goodcomment instance");
		try {
			Goodcomment result = (Goodcomment) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Goodcomment instance) {
		log.debug("attaching dirty Goodcomment instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Goodcomment instance) {
		log.debug("attaching clean Goodcomment instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GoodcommentDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (GoodcommentDAO) ctx.getBean("GoodcommentDAO");
	}
}