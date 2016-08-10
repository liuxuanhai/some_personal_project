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

import com.pojo.Gonggao;
import com.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Gonggao entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Gonggao
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class GonggaoDAO {
	private static final Logger log = LoggerFactory.getLogger(GonggaoDAO.class);
	// property constants
	public static final String TITLE = "title";
	public static final String CONTENT = "content";
	public static final String LOOKNUM = "looknum";
	public static final String FILENAME = "filename";
	public static final String FILEPATH = "filepath";

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
	
	public List findTop7() {
		try {
			String queryString = "from Gonggao order by addtime desc";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setMaxResults(6);
			
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
	public int findNumsByLikeNameOrId(Object value)
	{
		try {
			String queryString = "select count(*) from Gonggao as model where  title like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			return ((Long)queryObject.uniqueResult()).intValue();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List gonggaoLikeNameOrId(Object v,Page p)
	{
		try {
			String queryString = "from Gonggao as model where title like ? order by addtime desc";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0,"%"+ v+"%");
			queryObject.setMaxResults(p.getEveryPage());
			queryObject.setFirstResult(p.getBeginIndex());
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public void save(Gonggao transientInstance) {
		log.debug("saving Gonggao instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Gonggao persistentInstance) {
		log.debug("deleting Gonggao instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Gonggao findById(java.lang.Integer id) {
		log.debug("getting Gonggao instance with id: " + id);
		try {
			Gonggao instance = (Gonggao) getCurrentSession().get(
					"com.pojo.Gonggao", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Gonggao instance) {
		log.debug("finding Gonggao instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Gonggao")
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
		log.debug("finding Gonggao instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Gonggao as model where model."
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

	public List findByFilename(Object filename) {
		return findByProperty(FILENAME, filename);
	}

	public List findByFilepath(Object filepath) {
		return findByProperty(FILEPATH, filepath);
	}

	public List findAll() {
		log.debug("finding all Gonggao instances");
		try {
			String queryString = "from Gonggao";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Gonggao merge(Gonggao detachedInstance) {
		log.debug("merging Gonggao instance");
		try {
			Gonggao result = (Gonggao) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Gonggao instance) {
		log.debug("attaching dirty Gonggao instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Gonggao instance) {
		log.debug("attaching clean Gonggao instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static GonggaoDAO getFromApplicationContext(ApplicationContext ctx) {
		return (GonggaoDAO) ctx.getBean("GonggaoDAO");
	}
}