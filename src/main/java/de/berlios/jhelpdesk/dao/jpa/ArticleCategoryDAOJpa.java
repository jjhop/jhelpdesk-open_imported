/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright: (C) 2006 jHelpdesk Developers Team
 */
package de.berlios.jhelpdesk.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.ArticleCategoryDAO;
import de.berlios.jhelpdesk.model.ArticleCategory;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class ArticleCategoryDAOJpa implements ArticleCategoryDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public ArticleCategoryDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    @Transactional(readOnly = false)
    public void delete(final Long categoryId) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery(
                        "UPDATE article_category " +
                        "SET ord=ord-1 " +
                        "WHERE ord>(SELECT ord FROM article_category WHERE id=?)");
                    q.setParameter(1, categoryId);
                    q.executeUpdate();
                    Query q2 = em.createNativeQuery(
                            "DELETE FROM article_category WHERE id=?");
                    q2.setParameter(1, categoryId);
                    q2.executeUpdate();
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<ArticleCategory> getAllCategories() throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("ArticleCategory.getAllByOrderASC");
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countAll() throws DAOException {
        try {
            return ((Long) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT COUNT(ac) FROM ArticleCategory ac");
                    return q.getSingleResult();
                }
            })).intValue();
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public ArticleCategory getById(Long categoryId) throws DAOException {
        try {
            return this.jpaTemplate.find(ArticleCategory.class, categoryId);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void moveDown(final Long categoryId) throws DAOException {
        this.jpaTemplate.execute(new JpaCallback<Object>() {
            public Object doInJpa(EntityManager em) throws PersistenceException {
                ArticleCategory target = em.find(ArticleCategory.class, categoryId);
                Query q = em.createQuery("SELECT ac FROM ArticleCategory ac WHERE ac.order > ?1 ORDER BY ac.order ASC");
                q.setParameter(1, target.getOrder());
                q.setMaxResults(1);
                List result = q.getResultList();
                if (result.size() > 0) {
                    ArticleCategory n = (ArticleCategory) result.get(0);
                    Long targetNewOrd = n.getOrder();
                    n.setOrder(target.getOrder());
                    target.setOrder(targetNewOrd);
                    em.merge(target);
                    em.merge(n);
                }
                return null;
            }
        });
    }

    @Transactional(readOnly = false)
    public void moveUp(final Long categoryId) throws DAOException {
        this.jpaTemplate.execute(new JpaCallback<Object>() {
            public Object doInJpa(EntityManager em) throws PersistenceException {
                ArticleCategory target = em.find(ArticleCategory.class, categoryId);
                Query q = em.createQuery("SELECT ac FROM ArticleCategory ac WHERE ac.order < ?1 ORDER BY ac.order DESC");
                q.setParameter(1, target.getOrder());
                q.setMaxResults(1);
                List result = q.getResultList();
                if (result.size() > 0) {
                    ArticleCategory n = (ArticleCategory) result.get(0);
                    Long targetNewOrd = n.getOrder();
                    n.setOrder(target.getOrder());
                    target.setOrder(targetNewOrd);
                    em.merge(target);
                    em.merge(n);
                }
                return null;
            }
        });
    }

    @Transactional(readOnly = false)
    public void saveOrUpdate(final ArticleCategory category) throws DAOException {
        try {
            if (category.getId() == null) {
                this.jpaTemplate.execute(new JpaCallback<Object>() {
                    public Object doInJpa(EntityManager em) throws PersistenceException {
                        Query q = em.createNativeQuery("SELECT MAX(ord) FROM article_category");
                        Integer maxOrder = (Integer)q.getSingleResult();
                        category.setOrder(maxOrder.longValue()+1);
                        category.setArticlesCount(0);
                        em.persist(category);
                        return null;
                    }
                });
            } else {
                this.jpaTemplate.execute(new JpaCallback<Object>() {
                    public Object doInJpa(EntityManager em) throws PersistenceException {
                        Query q = em.createNativeQuery(
                            "UPDATE article_category SET category_name=? WHERE id=?");
                        q.setParameter(1, category.getCategoryName());
                        q.setParameter(2, category.getId());
                        q.executeUpdate();
                        return null;
                    }
                });
            }
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }
}
