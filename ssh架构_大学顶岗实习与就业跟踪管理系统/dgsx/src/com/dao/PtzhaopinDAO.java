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

import com.pojo.Ptzhaopin;
import com.util.Page;

/**
 * A data access object (DAO) providing persistence and search support for
 * Ptzhaopin entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.pojo.Ptzhaopin
 * @author MyEclipse Persistence Tools
 */
@Transactional
public class PtzhaopinDAO {
	private static final Logger log = LoggerFactory
			.getLogger(PtzhaopinDAO.class);
	// property constants
	public static final String NAME = "name";
	public static final String PHONE = "phone";
	public static final String EMAIL = "email";
	public static final String CHUANZHEN = "chuanzhen";
	public static final String SHENFE = "shenfe";
	public static final String HANGYE = "hangye";
	public static final String ADDRESS = "address";
	public static final String HOMEURL = "homeurl";
	public static final String ZPADDR = "zpaddr";
	public static final String DWDESCR = "dwdescr";
	public static final String GANGWEI = "gangwei";
	public static final String XUELI = "xueli";
	public static final String ZHUANYE = "zhuanye";
	public static final String NUMS = "nums";
	public static final String GANGWEIDESCR = "gangweidescr";

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
			String queryString = "from Ptzhaopin order by addtime desc";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setMaxResults(6);
			
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	public void save(Ptzhaopin transientInstance) {
		log.debug("saving Ptzhaopin instance");
		try {
			getCurrentSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}
	
	public int findNumsByLikeNameOrId(Object value)
	{
		try {
			String queryString = "select count(*) from Ptzhaopin as model where model.name like ? or title like ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, "%"+value+"%");
			queryObject.setParameter(1, "%"+value+"%");
			return ((Long)queryObject.uniqueResult()).intValue();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public List ptzhaopinLikeNameOrId(Object v,Page p)
	{
		try {
			String queryString = "from Ptzhaopin as model where model.name like ? or title like ? order by addtime desc";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0,"%"+ v+"%");
			queryObject.setParameter(1, "%"+v+"%");
			queryObject.setMaxResults(p.getEveryPage());
			queryObject.setFirstResult(p.getBeginIndex());
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	public void delete(Ptzhaopin persistentInstance) {
		log.debug("deleting Ptzhaopin instance");
		try {
			getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Ptzhaopin findById(java.lang.Integer id) {
		log.debug("getting Ptzhaopin instance with id: " + id);
		try {
			Ptzhaopin instance = (Ptzhaopin) getCurrentSession().get(
					"com.pojo.Ptzhaopin", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Ptzhaopin instance) {
		log.debug("finding Ptzhaopin instance by example");
		try {
			List results = getCurrentSession()
					.createCriteria("com.pojo.Ptzhaopin")
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
		log.debug("finding Ptzhaopin instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Ptzhaopin as model where model."
					+ propertyName + "= ?";
			Query queryObject = getCurrentSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByName(Object name) {
		return findByProperty(NAME, name);
	}

	public List findByPhone(Object phone) {
		return findByProperty(PHONE, phone);
	}

	public List findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}

	public List findByChuanzhen(Object chuanzhen) {
		return findByProperty(CHUANZHEN, chuanzhen);
	}

	public List findByShenfe(Object shenfe) {
		return findByProperty(SHENFE, shenfe);
	}

	public List findByHangye(Object hangye) {
		return findByProperty(HANGYE, hangye);
	}

	public List findByAddress(Object address) {
		return findByProperty(ADDRESS, address);
	}

	public List findByHomeurl(Object homeurl) {
		return findByProperty(HOMEURL, homeurl);
	}

	public List findByZpaddr(Object zpaddr) {
		return findByProperty(ZPADDR, zpaddr);
	}

	public List findByDwdescr(Object dwdescr) {
		return findByProperty(DWDESCR, dwdescr);
	}

	public List findByGangwei(Object gangwei) {
		return findByProperty(GANGWEI, gangwei);
	}

	public List findByXueli(Object xueli) {
		return findByProperty(XUELI, xueli);
	}

	public List findByZhuanye(Object zhuanye) {
		return findByProperty(ZHUANYE, zhuanye);
	}

	public List findByNums(Object nums) {
		return findByProperty(NUMS, nums);
	}

	public List findByGangweidescr(Object gangweidescr) {
		return findByProperty(GANGWEIDESCR, gangweidescr);
	}

	public List findAll() {
		log.debug("finding all Ptzhaopin instances");
		try {
			String queryString = "from Ptzhaopin";
			Query queryObject = getCurrentSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Ptzhaopin merge(Ptzhaopin detachedInstance) {
		log.debug("merging Ptzhaopin instance");
		try {
			Ptzhaopin result = (Ptzhaopin) getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Ptzhaopin instance) {
		log.debug("attaching dirty Ptzhaopin instance");
		try {
			getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Ptzhaopin instance) {
		log.debug("attaching clean Ptzhaopin instance");
		try {
			getCurrentSession().buildLockRequest(LockOptions.NONE).lock(
					instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public static PtzhaopinDAO getFromApplicationContext(ApplicationContext ctx) {
		return (PtzhaopinDAO) ctx.getBean("PtzhaopinDAO");
	}
}