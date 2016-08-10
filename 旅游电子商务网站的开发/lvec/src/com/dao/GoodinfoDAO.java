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

import com.pojo.Goodinfo;

/**
 * A data access object (DAO) providing persistence and search support for
 * Goodinfo entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Goodinfo
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class GoodinfoDAO {
	private static final Logger log = LoggerFactory
			.getLogger(GoodinfoDAO.class);
	// property constants
	public static final String GOODNAME = "goodname";
	public static final String GOODDESCR = "gooddescr";
	public static final String GOODPRICE = "goodprice";
	public static final String GOODNUM = "goodnum";
	public static final String TYPEID = "typeid";
	public static final String GOODIMAGE = "goodimage";

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

	public void save(Goodinfo transientInstance) {
		log.debug("saving Goodinfo instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Goodinfo persistentInstance) {
		log.debug("deleting Goodinfo instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	
	
	public Goodinfo findById(java.lang.Integer id) {
		log.debug("getting Goodinfo instance with id: " + id);
		try {
			Goodinfo instance = (Goodinfo) getCurrentSession().get(
					"com.pojo.Goodinfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByLikeNameOrId(Object value)
	{
		try {
			String queryString = "from Goodinfo as model where model.goodname like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByExample(Goodinfo instance) {
		log.debug("finding Goodinfo instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Goodinfo")
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
		log.debug("finding Goodinfo instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Goodinfo as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByGoodname(Object goodname) {
		return findByProperty(GOODNAME, goodname);
	}

	public List findByGooddescr(Object gooddescr) {
		return findByProperty(GOODDESCR, gooddescr);
	}

	public List findByGoodprice(Object goodprice) {
		return findByProperty(GOODPRICE, goodprice);
	}

	public List findByGoodnum(Object goodnum) {
		return findByProperty(GOODNUM, goodnum);
	}

	public List findByTypeid(Object typeid) {
		return findByProperty(TYPEID, typeid);
	}

	public List findByGoodimage(Object goodimage) {
		return findByProperty(GOODIMAGE, goodimage);
	}

	public List findAll() {
		log.debug("finding all Goodinfo instances");
		try {
			String queryString = "from Goodinfo";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Goodinfo merge(Goodinfo detachedInstance) {
		log.debug("merging Goodinfo instance");
		try {
			Goodinfo result = (Goodinfo) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Goodinfo instance) {
		log.debug("attaching dirty Goodinfo instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Goodinfo instance) {
		log.debug("attaching clean Goodinfo instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GoodinfoDAO getFromApplicationContext(ApplicationContext ctx) {
		return (GoodinfoDAO) ctx.getBean("GoodinfoDAO");
	}
}