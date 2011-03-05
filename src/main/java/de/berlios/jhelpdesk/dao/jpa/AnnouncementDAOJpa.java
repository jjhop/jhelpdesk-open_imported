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

import de.berlios.jhelpdesk.dao.AnnouncementDAO;
import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.model.Announcement;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class AnnouncementDAOJpa implements AnnouncementDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public AnnouncementDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    public Announcement getById(Long announcementId) throws DAOException {
        try {
            return this.jpaTemplate.find(Announcement.class, announcementId);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Announcement> getAll() throws DAOException {
        return this.jpaTemplate.findByNamedQuery("Announcement.allOrderByCreatedAtDesc");
    }

    public List<Announcement> get(final int pageSize, final int page) throws DAOException {
        try {
            return this.jpaTemplate.executeFind(new JpaCallback<List<Announcement>>() {
                public List<Announcement> doInJpa(EntityManager em) throws PersistenceException {
                    int offset = (int) (pageSize * (page - 1));
                    Query q = em.createQuery(
                        "SELECT a FROM Announcement a ORDER BY a.createdAt DESC");
                    q.setFirstResult(offset);
                    q.setMaxResults(pageSize);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Announcement> getLastAnnouncements(final int howMuch) throws DAOException {
        try {
             return (List<Announcement>)this.jpaTemplate.executeFind(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery("Announcement.allOrderByCreatedAtDesc");
                    q.setMaxResults(howMuch);
                    return q.getResultList();
                }
            });
         } catch(Exception ex) {
             throw new DAOException(ex);
         }
    }

    public int countAll() throws DAOException {
        try {
            return ((Long)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT COUNT(a) FROM Announcement a");
                    return q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
             throw new DAOException(ex);
         }
    }

    @Transactional(readOnly = false)
    public void save(Announcement announcement) throws DAOException {
        if (announcement.getId() == null) {
            this.jpaTemplate.persist(announcement);
        } else {
            this.jpaTemplate.merge(announcement);
        }
    }

    @Transactional(readOnly = false)
    public void delete(final Long announcementId) throws DAOException {
        try {
            Announcement toDelete = this.jpaTemplate.find(Announcement.class, announcementId);
            this.jpaTemplate.remove(toDelete);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void delete(Announcement announcement) throws DAOException {
        this.jpaTemplate.remove(announcement);
    }
}
