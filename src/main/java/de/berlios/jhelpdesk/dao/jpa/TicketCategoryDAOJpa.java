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
import de.berlios.jhelpdesk.dao.TicketCategoryDAO;
import de.berlios.jhelpdesk.model.TicketCategory;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class TicketCategoryDAOJpa implements TicketCategoryDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public TicketCategoryDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }
    
    @Transactional(readOnly = false)
    public void deleteCategory(final Long categoryId) throws DAOException {
        this.jpaTemplate.execute(new JpaCallback<Object>() {
            public Object doInJpa(EntityManager em) throws PersistenceException {
                TicketCategory category = em.find(TicketCategory.class, categoryId);
                if (category.getTicketsCount() == 0) {
                    Query q = em.createNativeQuery(
                        "UPDATE ticket_category " +
                        "SET ord=ord-1 " +
                        "WHERE ord>(SELECT ord FROM ticket_category WHERE id=?)");
                    q.setParameter(1, categoryId);
                    q.executeUpdate();
                    Query q2 = em.createNativeQuery(
                            "DELETE FROM ticket_category WHERE id=?");
                    q2.setParameter(1, categoryId);
                    q2.executeUpdate();
                }
                return null;
            }
        });
    }

    @Transactional(readOnly = false)
    public void deleteCategory(final TicketCategory category) throws DAOException {
        if (category.getTicketsCount() > 0) {
            return;
        }
        try {
            this.jpaTemplate.remove(category);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
    
    public List<TicketCategory> getAllCategories() throws DAOException {
        try {
            return (List<TicketCategory>) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery(
                        "SELECT tc FROM TicketCategory tc ORDER BY tc.order ASC");
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<TicketCategory> getCategories(final int pageSize, final int offset) throws DAOException {
        try {
            return this.jpaTemplate.executeFind(new JpaCallback<List<TicketCategory>>() {
                public List<TicketCategory> doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery(
                        "SELECT tc FROM TicketCategory tc ORDER BY tc.order ASC");
                    q.setFirstResult(offset);
                    q.setMaxResults(pageSize);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<TicketCategory> getAllCategoriesForView() throws DAOException {
        try {
            return (List<TicketCategory>) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery(
                        "SELECT tc FROM TicketCategory tc WHERE tc.isActive=?1 ORDER BY tc.order ASC");
                    q.setParameter(1, Boolean.TRUE);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countAll() throws DAOException {
        try {
            return ((Long) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT COUNT(tc) FROM TicketCategory tc");
                    return q.getSingleResult();
                }
            })).intValue();
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void moveUp(final Long id) throws DAOException {
        this.jpaTemplate.execute(new JpaCallback<Object>() {
            public Object doInJpa(EntityManager em) throws PersistenceException {
                TicketCategory target = em.find(TicketCategory.class, id);
                Query q = em.createQuery("SELECT tc FROM TicketCategory tc WHERE tc.order < ?1 ORDER BY tc.order DESC");
                q.setParameter(1, target.getOrder());
                q.setMaxResults(1);
                List result = q.getResultList();
                if (result.size() > 0) {
                    TicketCategory n = (TicketCategory) result.get(0);
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
    public void moveDown(final Long id) throws DAOException {
        this.jpaTemplate.execute(new JpaCallback<Object>() {
            public Object doInJpa(EntityManager em) throws PersistenceException {
                TicketCategory target = em.find(TicketCategory.class, id);
                Query q = em.createQuery("SELECT tc FROM TicketCategory tc WHERE tc.order > ?1 ORDER BY tc.order ASC");
                q.setParameter(1, target.getOrder());
                q.setMaxResults(1);
                List result = q.getResultList();
                if (result.size() > 0) {
                    TicketCategory n = (TicketCategory) result.get(0);
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

    public TicketCategory getById(Long id) throws DAOException {
        try {
            return this.jpaTemplate.find(TicketCategory.class, id);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public TicketCategory getDefault() throws DAOException {
        try {
            return this.jpaTemplate.execute(new JpaCallback<TicketCategory>() {
                public TicketCategory doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT tc FROM TicketCategory tc WHERE tc.isDefault=?1");
                    q.setParameter(1, Boolean.TRUE);
                    return (TicketCategory) q.getSingleResult();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void save(final TicketCategory category) {
        // jeśli nowa kategoria ma być domyślną to dotychczasowa domyslna musi przestać nią być
        if (category.isDefault()) {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("UPDATE TicketCategory tc SET tc.isDefault=?1 WHERE tc.isDefault=?2");
                    q.setParameter(1, Boolean.FALSE);
                    q.setParameter(2, Boolean.TRUE);
                    q.executeUpdate();
                    return null;
                }
            });
        }
        if (category.getId() == null) {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("SELECT MAX(ord) FROM ticket_category");
                    Integer maxOrder = (Integer)q.getSingleResult();
                    category.setOrder(maxOrder.longValue()+1);
                    category.setTicketsCount(0L);
                    em.persist(category);
                    return null;
                }
            });
        } else {
            this.jpaTemplate.merge(category);
        }
    }
    
    @Transactional(readOnly = false)
    public void updateCategory(TicketCategory category) throws DAOException {
        try {
            this.jpaTemplate.merge(category);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
}
