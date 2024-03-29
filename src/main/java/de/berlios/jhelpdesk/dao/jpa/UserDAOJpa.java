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

import de.berlios.jhelpdesk.model.Preferences;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.User;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class UserDAOJpa implements UserDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public UserDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    public List<User> getAllUsers() throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("User.allOrderByLastName");
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<User> getUsers(final int limit, final int offset) throws DAOException {
        try {
            return (List<User>) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery("User.allOrderByLastName");
                    q.setMaxResults(limit);
                    q.setFirstResult(offset);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countUsers() throws DAOException {
        try {
            return ((Long) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery("User.countAll");
                    return q.getSingleResult();
                }
            })).intValue();
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<User> getByRole(Role role) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("User.allByRoleOrderByLastName", role.toInt());
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<User> getActiveByRole(Role role) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("User.activeByRoleOrderByLastName", role.toInt());
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public User getById(Long id) throws DAOException {
        try {
            return this.jpaTemplate.find(User.class, id);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public User getByEmailFetchFilters(String email) throws DAOException {
        try {
            List<User> users = this.jpaTemplate.findByNamedQuery("User.byEmailFetchFilters", email);
            return users.isEmpty() ? null : users.get(0);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public User getByEmail(String email) throws DAOException {
        try {
            List<User> users = this.jpaTemplate.findByNamedQuery("User.byEmail", email);
            return users.isEmpty() ? null : users.get(0);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public boolean authenticate(String email, String passw) throws DAOException {
        try {
            List<User> users = this.jpaTemplate.findByNamedQuery(
                    "User.byEmailAndHashedPassword", email, passw);
            return users.isEmpty() ? false : true;
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void saveOrUpdate(final User user) throws DAOException {
        try {
            if (user.getUserId() == null) {
                this.jpaTemplate.persist(user);
                Preferences p = Preferences.getDefault();
                p.setUser(user);
                p.setId(user.getUserId());
                jpaTemplate.persist(p);
                user.setPreferences(p);
            } else {
                this.jpaTemplate.execute(new JpaCallback<Object>() {
                    public Object doInJpa(EntityManager em) throws PersistenceException {
                        Query q = em.createNativeQuery("UPDATE users SET first_name=?1, "
                                                     + "last_name=?2, phone=?3, mobile=?4, "
                                                     + "email=?5, is_active=?6 WHERE user_id=?7");
                        q.setParameter(1, user.getFirstName());
                        q.setParameter(2, user.getLastName());
                        q.setParameter(3, user.getPhone());
                        q.setParameter(4, user.getMobile());
                        q.setParameter(5, user.getEmail());
                        q.setParameter(6, user.isActive());
                        q.setParameter(7, user.getUserId());
                        q.executeUpdate();
                        return null;
                    }
                });
            }
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void updatePasswordAndSalt(final User user, final String password) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    User u = em.find(User.class, user.getUserId());
                    if (u != null) {
                        u.setPassword(password); // TODO: zbadać czy to ma sens (vide moppee)
                        em.merge(u);
                    }
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void deactivate(final Long userId) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE users SET is_active=? WHERE user_id=?");
                    q.setParameter(1, false);
                    q.setParameter(2, userId);
                    q.executeUpdate();
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }
}
