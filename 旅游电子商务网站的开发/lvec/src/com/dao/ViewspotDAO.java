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

import com.pojo.Viewspot;

/**
 * A data access object (DAO) providing persistence and search support for
 * Viewspot entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Viewspot
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class ViewspotDAO {
	private static final Logger log = LoggerFactory
			.getLogger(ViewspotDAO.class);
	// property constants
	public static final String SPOTNAME = "spotname";
	public static final String SPOTCITY = "spotcity";
	public static final String SPOTADDR = "spotaddr";
	public static final String SPOTDESCR = "spotdescr";
	public static final String SPOTPRICE = "spotprice";
	public static final String SPOTREMARK = "spotremark";
	public static final String SPORTIMAGE = "sportimage";

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

	public List findAllCity()
	{
		try {
			String queryString = "select DISTINCT spotcity from Viewspot";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public void save(Viewspot transientInstance) {
		log.debug("saving Viewspot instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Viewspot persistentInstance) {
		log.debug("deleting Viewspot instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Viewspot findById(java.lang.Integer id) {
		log.debug("getting Viewspot instance with id: " + id);
		try {
			Viewspot instance = (Viewspot) getCurrentSession().get(
					"com.pojo.Viewspot", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByLikeNameOrId(Object value)
	{
		try {
			String queryString = "from Viewspot as model where model.spotname like ?  or model.spotcity like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	

	
	public List findByLikeNameOrId(Object value,Object city)
	{
		try {
			String queryString = "from Viewspot as model where model.spotname like ?  and model.spotcity like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+city+"%");
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByExample(Viewspot instance) {
		log.debug("finding Viewspot instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Viewspot")
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
		log.debug("finding Viewspot instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Viewspot as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findBySpotname(Object spotname) {
		return findByProperty(SPOTNAME, spotname);
	}

	public List findBySpotcity(Object spotcity) {
		return findByProperty(SPOTCITY, spotcity);
	}

	public List findBySpotaddr(Object spotaddr) {
		return findByProperty(SPOTADDR, spotaddr);
	}

	public List findBySpotdescr(Object spotdescr) {
		return findByProperty(SPOTDESCR, spotdescr);
	}

	public List findBySpotprice(Object spotprice) {
		return findByProperty(SPOTPRICE, spotprice);
	}

	public List findBySpotremark(Object spotremark) {
		return findByProperty(SPOTREMARK, spotremark);
	}

	public List findBySportimage(Object sportimage) {
		return findByProperty(SPORTIMAGE, sportimage);
	}

	public List findAll() {
		log.debug("finding all Viewspot instances");
		try {
			String queryString = "from Viewspot";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Viewspot merge(Viewspot detachedInstance) {
		log.debug("merging Viewspot instance");
		try {
			Viewspot result = (Viewspot) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Viewspot instance) {
		log.debug("attaching dirty Viewspot instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Viewspot instance) {
		log.debug("attaching clean Viewspot instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static ViewspotDAO getFromApplicationContext(ApplicationContext ctx) {
		return (ViewspotDAO) ctx.getBean("ViewspotDAO");
	}
}