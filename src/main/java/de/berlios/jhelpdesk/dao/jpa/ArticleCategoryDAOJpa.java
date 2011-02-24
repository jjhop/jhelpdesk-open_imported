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
            ArticleCategory categoryToRemove = this.getById(categoryId);
            System.out.println("--------------------- DELETE MIDDLE --------------------");
            // TODO: tutaj nalezaloby jeszcze zmienic category_position dla wszystkich
            //       rekordow powyzej category_position - odjac 1 dla kazdemu - może
            //       to być zrealizowane za pomocą triggera w bazie danych
            this.jpaTemplate.remove(categoryToRemove);
            System.out.println("--------------------- DELETE END -----------------------");
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<ArticleCategory> getAllCategories() throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("ArticleCategory.getAllOrderByPositionASC");
        } catch(Exception ex) {
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
        try {
            this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("SELECT category_move_down(?1)");
                    q.setParameter(1, categoryId);
                    q.getSingleResult();
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void moveUp(final Long categoryId) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("SELECT category_move_up(?1)");
                    q.setParameter(1, categoryId);
                    q.getSingleResult();
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void saveOrUpdate(ArticleCategory category) throws DAOException {
        try {
            if (category.getId() == null) {
                this.jpaTemplate.persist(category);
            } else {
                this.jpaTemplate.merge(category);
            }
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }
}
