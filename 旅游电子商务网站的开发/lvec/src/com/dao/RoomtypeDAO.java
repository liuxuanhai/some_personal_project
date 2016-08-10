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

import com.pojo.Roomtype;

/**
 * A data access object (DAO) providing persistence and search support for
 * Roomtype entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Roomtype
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class RoomtypeDAO {
	private static final Logger log = LoggerFactory
			.getLogger(RoomtypeDAO.class);
	// property constants
	public static final String HOTELID = "hotelid";
	public static final String ROOMNAME = "roomname";
	public static final String ROOMDESCR = "roomdescr";
	public static final String ROOMPRICE = "roomprice";

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

	public void save(Roomtype transientInstance) {
		log.debug("saving Roomtype instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Roomtype persistentInstance) {
		log.debug("deleting Roomtype instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Roomtype findById(java.lang.Integer id) {
		log.debug("getting Roomtype instance with id: " + id);
		try {
			Roomtype instance = (Roomtype) getCurrentSession().get(
					"com.pojo.Roomtype", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Roomtype instance) {
		log.debug("finding Roomtype instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Roomtype")
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
		log.debug("finding Roomtype instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Roomtype as model where model."
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

	public List findByRoomname(Object roomname) {
		return findByProperty(ROOMNAME, roomname);
	}

	public List findByRoomdescr(Object roomdescr) {
		return findByProperty(ROOMDESCR, roomdescr);
	}

	public List findByRoomprice(Object roomprice) {
		return findByProperty(ROOMPRICE, roomprice);
	}

	public List findAll() {
		log.debug("finding all Roomtype instances");
		try {
			String queryString = "from Roomtype";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Roomtype merge(Roomtype detachedInstance) {
		log.debug("merging Roomtype instance");
		try {
			Roomtype result = (Roomtype) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Roomtype instance) {
		log.debug("attaching dirty Roomtype instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Roomtype instance) {
		log.debug("attaching clean Roomtype instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static RoomtypeDAO getFromApplicationContext(ApplicationContext ctx) {
		return (RoomtypeDAO) ctx.getBean("RoomtypeDAO");
	}
}