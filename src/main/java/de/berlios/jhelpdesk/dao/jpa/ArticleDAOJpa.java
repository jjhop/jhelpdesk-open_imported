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

import java.util.Collections;
import java.util.List;

import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

    private static final Logger log = LoggerFactory.getLogger(ArticleDAOJpa.class);
    
    private final JpaTemplate jpaTemplate;

    @Autowired
    public ArticleDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    @Transactional(readOnly = false)
    public void delete(Article article) {
        try {
            this.delete(article.getArticleId());
        } catch (Exception ex) {
            log.error("Nie można usunąć artykułu o identyfikatorze [" + article.getArticleId() + "]", ex);
        }
    }

    @Transactional(readOnly = false)
    public void delete(Long articleId) {
        try {
            Article toDelete = this.jpaTemplate.find(Article.class, articleId);
            ArticleCategory category = 
                    this.jpaTemplate.find(ArticleCategory.class,
                                          toDelete.getCategory().getArticleCategoryId());
            category.setArticlesCount(category.getArticlesCount() - 1);

            this.jpaTemplate.merge(category);
            this.jpaTemplate.remove(toDelete);
        } catch (Exception ex) {
            log.error("Nie można usunąć artykułu o identyfikatorze [" + articleId + "]", ex);
        }
    }

    public Article getById(Long articleId) {
        try {
            return this.jpaTemplate.find(Article.class, articleId);
        } catch (Exception ex) {
            log.error("Wystąpił problem z pobranie artykułu o identyfikatorze [" + articleId + "]", ex);
        }
        return null;
    }

    public List<Article> getForSection(Long categoryId) {
        try {
            return this.jpaTemplate.findByNamedQuery("Article.getForCategory", categoryId);
        } catch (Exception ex) {
            log.error("Nie można pobrać artykułów dla wskazanej kategorii.", ex);
        }
        return Collections.<Article>emptyList();
    }

    public List<Article> getLastArticles(final int howMuch) {
        try {
            return (List<Article>) this.jpaTemplate.executeFind(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery("Article.lastAdded");
                    q.setMaxResults(howMuch);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            log.error("Nie można pobrać ostatnio dodanych artykułów.", ex);
        }
        return Collections.<Article>emptyList();
    }

    @Transactional(readOnly = false)
    public void saveOrUpdate(Article article) {
        if (article.getArticleId() == null) {
            ArticleCategory category = article.getCategory();
            int numOfArticlesInCategory = category.getArticlesCount();
            category.setArticlesCount(numOfArticlesInCategory + 1);
            this.jpaTemplate.merge(category);
            this.jpaTemplate.persist(article);
        } else {
            this.jpaTemplate.merge(article);
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
