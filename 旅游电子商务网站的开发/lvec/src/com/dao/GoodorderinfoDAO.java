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

import com.pojo.Goodorderinfo;

/**
 * A data access object (DAO) providing persistence and search support for
 * Goodorderinfo entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.pojo.Goodorderinfo
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class GoodorderinfoDAO {
	private static final Logger log = LoggerFactory
			.getLogger(GoodorderinfoDAO.class);
	// property constants
	public static final String ORDERID = "orderid";
	public static final String GOODID = "goodid";
	public static final String GOODNAME = "goodname";
	public static final String GOODPRICE = "goodprice";
	public static final String NUMS = "nums";
	public static final String TOTALPRICE = "totalprice";

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

	public void save(Goodorderinfo transientInstance) {
		log.debug("saving Goodorderinfo instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Goodorderinfo persistentInstance) {
		log.debug("deleting Goodorderinfo instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Goodorderinfo findById(java.lang.Integer id) {
		log.debug("getting Goodorderinfo instance with id: " + id);
		try {
			Goodorderinfo instance = (Goodorderinfo) getCurrentSession().get(
					"com.pojo.Goodorderinfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Goodorderinfo instance) {
		log.debug("finding Goodorderinfo instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Goodorderinfo")
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
		log.debug("finding Goodorderinfo instance with property: "
				+ propertyName + ", value: " + value);
		try {
			String queryString = "from Goodorderinfo as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByOrderid(Object orderid) {
		return findByProperty(ORDERID, orderid);
	}

	public List findByGoodid(Object goodid) {
		return findByProperty(GOODID, goodid);
	}

	public List findByGoodname(Object goodname) {
		return findByProperty(GOODNAME, goodname);
	}

	public List findByGoodprice(Object goodprice) {
		return findByProperty(GOODPRICE, goodprice);
	}

	public List findByNums(Object nums) {
		return findByProperty(NUMS, nums);
	}

	public List findByTotalprice(Object totalprice) {
		return findByProperty(TOTALPRICE, totalprice);
	}

	public List findAll() {
		log.debug("finding all Goodorderinfo instances");
		try {
			String queryString = "from Goodorderinfo";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Goodorderinfo merge(Goodorderinfo detachedInstance) {
		log.debug("merging Goodorderinfo instance");
		try {
			Goodorderinfo result = (Goodorderinfo) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Goodorderinfo instance) {
		log.debug("attaching dirty Goodorderinfo instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Goodorderinfo instance) {
		log.debug("attaching clean Goodorderinfo instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GoodorderinfoDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (GoodorderinfoDAO) ctx.getBean("GoodorderinfoDAO");
	}
}