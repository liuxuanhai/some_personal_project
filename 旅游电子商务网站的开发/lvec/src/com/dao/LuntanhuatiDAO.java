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

import com.pojo.Luntanhuati;

/**
 * A data access object (DAO) providing persistence and search support for
 * Luntanhuati entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Luntanhuati
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class LuntanhuatiDAO {
	private static final Logger log = LoggerFactory
			.getLogger(LuntanhuatiDAO.class);
	// property constants
	public static final String TITLE = "title";
	public static final String CONTENT = "content";
	public static final String LOOKNUM = "looknum";
	public static final String FILEPATH = "filepath";
	public static final String USERNAME = "username";

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

	public void save(Luntanhuati transientInstance) {
		log.debug("saving Luntanhuati instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Luntanhuati persistentInstance) {
		log.debug("deleting Luntanhuati instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Luntanhuati findById(java.lang.Integer id) {
		log.debug("getting Luntanhuati instance with id: " + id);
		try {
			Luntanhuati instance = (Luntanhuati) getCurrentSession().get(
					"com.pojo.Luntanhuati", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Luntanhuati instance) {
		log.debug("finding Luntanhuati instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Luntanhuati")
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
		log.debug("finding Luntanhuati instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Luntanhuati as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByTitle(Object title) {
		return findByProperty(TITLE, title);
	}

	public List findByContent(Object content) {
		return findByProperty(CONTENT, content);
	}

	public List findByLooknum(Object looknum) {
		return findByProperty(LOOKNUM, looknum);
	}

	public List findByFilepath(Object filepath) {
		return findByProperty(FILEPATH, filepath);
	}

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}

	public List findAll() {
		log.debug("finding all Luntanhuati instances");
		try {
			String queryString = "from Luntanhuati";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	public List findAll(Object findinfo) {
		log.debug("finding all Luntanhuati instances");
		try {
			String queryString = "from Luntanhuati where title like ? order by addtime desc";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setString(0, "%"+findinfo+"%");
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Luntanhuati merge(Luntanhuati detachedInstance) {
		log.debug("merging Luntanhuati instance");
		try {
			Luntanhuati result = (Luntanhuati) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Luntanhuati instance) {
		log.debug("attaching dirty Luntanhuati instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Luntanhuati instance) {
		log.debug("attaching clean Luntanhuati instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static LuntanhuatiDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (LuntanhuatiDAO) ctx.getBean("LuntanhuatiDAO");
	}
}