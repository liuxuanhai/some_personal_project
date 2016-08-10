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

import com.pojo.Spotorder;

/**
 * A data access object (DAO) providing persistence and search support for
 * Spotorder entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Spotorder
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class SpotorderDAO {
	private static final Logger log = LoggerFactory
			.getLogger(SpotorderDAO.class);
	// property constants
	public static final String SPOTID = "spotid";
	public static final String SPOTNAME = "spotname";
	public static final String SPOTPRICE = "spotprice";
	public static final String USERNAME = "username";
	public static final String NAME = "name";
	public static final String PHONE = "phone";
	public static final String NUMS = "nums";
	public static final String TOTALPRICE = "totalprice";
	public static final String ORDERSTATUS = "orderstatus";

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

	public void save(Spotorder transientInstance) {
		log.debug("saving Spotorder instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Spotorder persistentInstance) {
		log.debug("deleting Spotorder instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Spotorder findById(java.lang.String id) {
		log.debug("getting Spotorder instance with id: " + id);
		try {
			Spotorder instance = (Spotorder) getCurrentSession().get(
					"com.pojo.Spotorder", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Spotorder instance) {
		log.debug("finding Spotorder instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Spotorder")
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
			String queryString = "from Spotorder as model where (model.spotname like ? or username like ? or name like ? or phone like ?) and (ordertime Between ? and ?)";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			queryObject.setParameter(2, "%"+value+"%");
			queryObject.setParameter(3, "%"+value+"%");
			queryObject.setParameter(4,s1);
			queryObject.setParameter(5,s2);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Spotorder instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Spotorder as model where model."
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

	public List findBySpotname(Object spotname) {
		return findByProperty(SPOTNAME, spotname);
	}

	public List findBySpotprice(Object spotprice) {
		return findByProperty(SPOTPRICE, spotprice);
	}

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	public List findByNums(Object nums) {
		return findByProperty(NUMS, nums);
	}

	public List findByTotalprice(Object totalprice) {
		return findByProperty(TOTALPRICE, totalprice);
	}

	public List findByOrderstatus(Object orderstatus) {
		return findByProperty(ORDERSTATUS, orderstatus);
	}

	public List findAll() {
		log.debug("finding all Spotorder instances");
		try {
			String queryString = "from Spotorder";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Spotorder merge(Spotorder detachedInstance) {
		log.debug("merging Spotorder instance");
		try {
			Spotorder result = (Spotorder) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Spotorder instance) {
		log.debug("attaching dirty Spotorder instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Spotorder instance) {
		log.debug("attaching clean Spotorder instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static SpotorderDAO getFromApplicationContext(ApplicationContext ctx) {
		return (SpotorderDAO) ctx.getBean("SpotorderDAO");
	}
}