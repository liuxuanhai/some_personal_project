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

import com.pojo.Goodorder;

/**
 * A data access object (DAO) providing persistence and search support for
 * Goodorder entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Goodorder
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class GoodorderDAO {
	private static final Logger log = LoggerFactory
			.getLogger(GoodorderDAO.class);
	// property constants
	public static final String USERNAME = "username";
	public static final String TOTALPRICE = "totalprice";
	public static final String ORDERSTATUS = "orderstatus";
	public static final String NAME = "name";
	public static final String PHONE = "phone";
	public static final String ADDR = "addr";

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

	public void save(Goodorder transientInstance) {
		log.debug("saving Goodorder instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Goodorder persistentInstance) {
		log.debug("deleting Goodorder instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Goodorder findById(java.lang.String id) {
		log.debug("getting Goodorder instance with id: " + id);
		try {
			Goodorder instance = (Goodorder) getCurrentSession().get(
					"com.pojo.Goodorder", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Goodorder instance) {
		log.debug("finding Goodorder instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Goodorder")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByLikeNameOrId(Object value,Object s1,Object s2)
	{
		try {
			String queryString = "from Goodorder as model where (username like ? or name like ? or phone like ?) and (ordertime Between ? and ?)";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3,s1);
			queryObject.setParameter(4,s2);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Goodorder instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Goodorder as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}

	public List findByTotalprice(Object totalprice) {
		return findByProperty(TOTALPRICE, totalprice);
	}

	public List findByOrderstatus(Object orderstatus) {
		return findByProperty(ORDERSTATUS, orderstatus);
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	public List findByAddr(Object addr) {
		return findByProperty(ADDR, addr);
	}

	public List findAll() {
		log.debug("finding all Goodorder instances");
		try {
			String queryString = "from Goodorder";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Goodorder merge(Goodorder detachedInstance) {
		log.debug("merging Goodorder instance");
		try {
			Goodorder result = (Goodorder) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Goodorder instance) {
		log.debug("attaching dirty Goodorder instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Goodorder instance) {
		log.debug("attaching clean Goodorder instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GoodorderDAO getFromApplicationContext(ApplicationContext ctx) {
		return (GoodorderDAO) ctx.getBean("GoodorderDAO");
	}
}