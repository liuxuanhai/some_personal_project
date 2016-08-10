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

import com.pojo.Spotuser;

/**
 * A data access object (DAO) providing persistence and search support for
 * Spotuser entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Spotuser
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class SpotuserDAO {
	private static final Logger log = LoggerFactory
			.getLogger(SpotuserDAO.class);
	// property constants
	public static final String USERNAME = "username";
	public static final String USERPWD = "userpwd";
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

	public void save(Spotuser transientInstance) {
		log.debug("saving Spotuser instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Spotuser persistentInstance) {
		log.debug("deleting Spotuser instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Spotuser findById(java.lang.Integer id) {
		log.debug("getting Spotuser instance with id: " + id);
		try {
			Spotuser instance = (Spotuser) getCurrentSession().get(
					"com.pojo.Spotuser", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Spotuser instance) {
		log.debug("finding Spotuser instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Spotuser")
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
		log.debug("finding Spotuser instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Spotuser as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List findByLikeNameOrId(Object value)
	{
		try {
			String queryString = "from Spotuser as model where model.username like ?  or model.name like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	
	// 查找用户密码是否存在
	public boolean userLogin(Object value1,Object value2)
	{
		try {
			String queryString = "from Spotuser as model where model.username =? and model.userpwd=?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value1);
			queryObject.setParameter(1, value2);
			if(queryObject.list().size()>0) return true;
			else
				return false;
			//return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	

	public List findByUsername(Object username) {
		return findByProperty(USERNAME, username);
	}

	public List findByUserpwd(Object userpwd) {
		return findByProperty(USERPWD, userpwd);
	}

	public List findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	public List findByAddr(Object addr) {
		return findByProperty(ADDR, addr);
	}

	public List findAll() {
		log.debug("finding all Spotuser instances");
		try {
			String queryString = "from Spotuser";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Spotuser merge(Spotuser detachedInstance) {
		log.debug("merging Spotuser instance");
		try {
			Spotuser result = (Spotuser) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Spotuser instance) {
		log.debug("attaching dirty Spotuser instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Spotuser instance) {
		log.debug("attaching clean Spotuser instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static SpotuserDAO getFromApplicationContext(ApplicationContext ctx) {
		return (SpotuserDAO) ctx.getBean("SpotuserDAO");
	}
}