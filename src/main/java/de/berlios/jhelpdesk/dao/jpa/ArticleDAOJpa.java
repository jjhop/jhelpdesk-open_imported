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

import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import de.berlios.jhelpdesk.dao.ArticleDAO;
import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.ArticleComment;
import de.berlios.jhelpdesk.model.ArticleCategory;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class ArticleDAOJpa implements ArticleDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public ArticleDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    @Transactional(readOnly = false)
    public void delete(Article article) throws DAOException {
        try {
            this.delete(article.getId());
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void delete(Long articleId) throws DAOException {
        try {
            Article toDelete = this.jpaTemplate.find(Article.class, articleId);
            ArticleCategory category = 
                    this.jpaTemplate.find(ArticleCategory.class,
                                          toDelete.getCategory().getId());
            category.setArticlesCount(category.getArticlesCount() - 1);

            this.jpaTemplate.merge(category);
            this.jpaTemplate.remove(toDelete);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public Article getById(Long articleId) throws DAOException {
        try {
            return this.jpaTemplate.find(Article.class, articleId);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    // TODO: do usunięcia, oznaczona jako @Deprecated w interfejsie
    public List<Article> getForSection(Long categoryId) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("Article.getForCategory", categoryId);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Article> getForSection(final Long cId, final int pageSize, final int page) throws DAOException {
        try {
            return this.jpaTemplate.executeFind(new JpaCallback<List<Article>>() {
                public List<Article> doInJpa(EntityManager em) throws PersistenceException {
                    int offset = (int) (pageSize * (page - 1));
                    Query q = em.createQuery(
                        "SELECT a FROM Article a WHERE a.category.id=?1 ORDER BY a.createdAt DESC");
                    q.setParameter(1, cId);
                    q.setFirstResult(offset);
                    q.setMaxResults(pageSize);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countForSection(final Long categoryId) throws DAOException {
        try {
            return ((Long)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery(
                        "SELECT COUNT(a) FROM Article a WHERE a.category.id=?1");
                    q.setParameter(1, categoryId);
                    return q.getSingleResult();
                }
            })).intValue();
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Article> getLastArticles(final int howMuch) throws DAOException {
        try {
            return (List<Article>) this.jpaTemplate.executeFind(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery("Article.lastAdded");
                    q.setMaxResults(howMuch);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void saveOrUpdate(Article article) throws DAOException {
        try {
            if (article.getId() == null) {
                ArticleCategory category = article.getCategory();
                int numOfArticlesInCategory = category.getArticlesCount();
                category.setArticlesCount(numOfArticlesInCategory + 1);
                this.jpaTemplate.merge(category);
                this.jpaTemplate.persist(article);
            } else {
                this.jpaTemplate.merge(article);
            }
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void saveArticleComment(ArticleComment comment) throws DAOException {
        try {
            this.jpaTemplate.persist(comment);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
}
