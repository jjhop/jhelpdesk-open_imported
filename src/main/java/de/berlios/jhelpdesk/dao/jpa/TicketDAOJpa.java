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

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.AdditionalFile;
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.CommentType;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.TicketCategory;
import de.berlios.jhelpdesk.model.TicketComment;
import de.berlios.jhelpdesk.model.TicketEvent;
import de.berlios.jhelpdesk.model.TicketFilter;
import de.berlios.jhelpdesk.model.TicketPriority;
import de.berlios.jhelpdesk.model.TicketStatus;
import de.berlios.jhelpdesk.model.User;

/**
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class TicketDAOJpa implements TicketDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public TicketDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    public Long countTicketsWithFilter(final TicketFilter ticketFilter) throws DAOException {
        try {
            return (Long) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = new QueryBuilder(ticketFilter, em).getFilteredQuery(true);
                    return q.getSingleResult();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getAllTickets() throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("Ticket.orderByCreateDateDESC");
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public Ticket getTicketById(Long ticketId) throws DAOException {
        try {
            return this.jpaTemplate.find(Ticket.class, ticketId);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsByCategory(TicketCategory ticketCategory) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("Ticket.allByCategory", ticketCategory);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsByPriority(TicketPriority ticketPriority) throws DAOException {
        try {
            // INFO: ticketPriority.toInt() musi być dlatego ze jest trick w encji...
            return this.jpaTemplate.findByNamedQuery("Ticket.allByPriority", ticketPriority.toInt());
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsByStatus(TicketStatus ticketStatus) throws DAOException {
        try {
            // INFO: ticketStatus.toInt() musi być dlatego ze jest trick w encji...
            return this.jpaTemplate.findByNamedQuery("Ticket.allByStatus", ticketStatus.toInt());
         } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsByStatus(final TicketStatus ticketStatus, final int howMuch) throws DAOException {
        try {
            return this.jpaTemplate.executeFind(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query query = em.createNamedQuery("Ticket.byStatusOrderByCreateDateDESC");
                    query.setParameter(1, ticketStatus.toInt());
                    query.setMaxResults(howMuch);
                    return query.getResultList();
                }
            });
        } catch(DataAccessException dae) {
            throw new DAOException(dae);
        }
    }

    public List<Ticket> getTicketsNotifyiedByUser(User user) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery("Ticket.allByNotifier", user);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsWithFilter(final TicketFilter ticketFilter, final int limit,
                                             final int offset) throws DAOException {
        try {
            return (List<Ticket>) this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = new QueryBuilder(ticketFilter, em).getFilteredQuery(false);
                    q.setMaxResults(limit);
                    q.setFirstResult(offset);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> getTicketsWithFilter(final TicketFilter filter) throws DAOException {
        try {
            return (List<Ticket>)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = new QueryBuilder(filter, em).getFilteredQuery(false);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void remove(Long ticketId) throws DAOException {
        try {
            Ticket toDelete = this.jpaTemplate.find(Ticket.class, ticketId);
            this.jpaTemplate.remove(toDelete);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void removeTicket(Ticket ticket) throws DAOException {
        try {
            this.jpaTemplate.remove(ticket);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void addComment(final TicketComment comment) throws DAOException {
        try {
            final TicketEvent event = TicketEvent.commentAdded(comment);
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    em.persist(comment);
                    em.persist(event);
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    /*
     * Uaktualnienie liczby zgłoszeń w danej kategorii realizowane
     * na poziomie bazy danych za pomocą trigerów
     */
    @Transactional(readOnly = false)
    public void save(final Ticket ticket) throws DAOException {
        try {
            // Tickety nie są uaktualniane
            assert ticket.getTicketId() == null;
            final TicketEvent event = TicketEvent.ticketCreated(ticket);
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    em.persist(ticket);
                    em.persist(event);
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void assignTicket(final Long ticketId, final Long userId, final Long assignerId) throws DAOException {
        try {
            User assigner = this.jpaTemplate.find(User.class, assignerId);
            User saviour = this.jpaTemplate.find(User.class, userId);
            Ticket ticket = getTicketById(ticketId);
            final TicketEvent event =
                    ticket.getSaviour() != null
                        ? TicketEvent.ticketReassigned(ticket, saviour, assigner)
                        : TicketEvent.ticketAssigned(ticket, saviour, assigner);

            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET saviour=?1, status=?2 WHERE id=?3");
                    q.setParameter(1, userId);
                    q.setParameter(2, TicketStatus.ASSIGNED.toInt());
                    q.setParameter(3, ticketId);
                    q.executeUpdate();
                    em.persist(event);
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void assignTicket(final Long ticketId, final Long userId) throws DAOException {
        try {
            User assigner = this.jpaTemplate.find(User.class, userId);
            Ticket ticket = getTicketById(ticketId);
            final TicketEvent event =
                    (ticket.getSaviour() != null)
                        ? TicketEvent.ticketReassigned(ticket, assigner)
                        : TicketEvent.ticketAssigned(ticket, assigner);

            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET saviour=?1, status=?2 WHERE id=?3");
                    q.setParameter(1, userId);
                    q.setParameter(2, TicketStatus.ASSIGNED.toInt());
                    q.setParameter(3, ticketId);
                    q.executeUpdate();
                    em.persist(event);
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void resolveWithComment(final TicketComment comment) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET status=?1 WHERE id=?2");
                    q.setParameter(1, TicketStatus.RESOLVED.toInt());
                    q.setParameter(2, comment.getTicket().getTicketId());
                    q.executeUpdate();

                    Ticket ticket  = comment.getTicket();
                    User user = comment.getCommentAuthor();

                    em.persist(TicketEvent.ticketResolved(ticket, user));
                    em.persist(comment);
                    return null;
                };
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void rejectWithComment(final TicketComment comment) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET status=?1 WHERE id=?2");
                    q.setParameter(1, TicketStatus.REJECTED.toInt());
                    q.setParameter(2, comment.getTicket().getTicketId());
                    q.executeUpdate();

                    Ticket ticket  = comment.getTicket();
                    User user = comment.getCommentAuthor();

                    em.persist(TicketEvent.ticketRejected(ticket, user));
                    em.persist(comment);
                    return null;
                };
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void close(final Ticket ticket, final User user) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET status=?1 WHERE id=?2");
                    q.setParameter(1, TicketStatus.CLOSED.toInt());
                    q.setParameter(2, ticket.getTicketId());
                    q.executeUpdate();

                    em.persist(TicketEvent.ticketClosed(ticket, user));
                    return null;
                };
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void reopenWithComment(final TicketComment comment) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET status=?1 WHERE id=?2");
                    q.setParameter(1, TicketStatus.ASSIGNED.toInt());
                    q.setParameter(2, comment.getTicket().getTicketId());
                    q.executeUpdate();

                    Ticket ticket  = comment.getTicket();
                    User user = comment.getCommentAuthor();

                    em.persist(TicketEvent.ticketReopened(ticket, user));
                    em.persist(comment);
                    return null;
                };
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void changeCategoryWithComment(final Ticket ticket, final TicketCategory category,
                                          final String commentText, final User user) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET ticket_category=?1 WHERE id=?2");
                    q.setParameter(1, category.getId());
                    q.setParameter(2, ticket.getTicketId());
                    q.executeUpdate();

                    em.persist(TicketEvent.categoryChange(ticket, user, category));

                    TicketComment comment = new TicketComment();
                    comment.setCommentAuthor(user);
                    comment.setTicket(ticket);
                    comment.setCommentDate(new Date());
                    comment.setCommentType(CommentType.CATEGORY_CHANGE);
                    comment.setCommentText(commentText);
                    comment.setNotForPlainUser(false);
                    em.persist(comment);
                    
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void changePriorityWithComment(final Ticket ticket, final TicketPriority priority,
                                          final String commentText, final User user) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("UPDATE ticket SET priority=?1 WHERE id=?2");
                    q.setParameter(1, priority.toInt());
                    q.setParameter(2, ticket.getTicketId());
                    q.executeUpdate();

                    em.persist(TicketEvent.priorityChange(ticket, user, priority));

                    TicketComment comment = new TicketComment();
                    comment.setCommentAuthor(user);
                    comment.setTicket(ticket);
                    comment.setCommentDate(new Date());
                    comment.setCommentType(CommentType.PRIORITY_CHANGE);
                    comment.setCommentText(commentText);
                    comment.setNotForPlainUser(false);
                    em.persist(comment);
                    
                    return null;
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<TicketEvent> getLastEvents(final int howMuch) throws DAOException {
        try {
            return (List<TicketEvent>)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "TicketEvent.getLastFewEventsOrderByEventDateDESC");
                    q.setMaxResults(howMuch);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<TicketComment> getCommentsForTicket(final Long ticketId, final int pageSize, 
                                                    final int offset) throws DAOException {
        try {
            return (List<TicketComment>)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "TicketComment.getCommentsForTicketOrderByCreatedAtDESC");
                    q.setParameter(1, ticketId);
                    q.setMaxResults(pageSize);
                    q.setFirstResult(offset);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<TicketEvent> getEventsForTicket(final Long ticketId, final int pageSize, 
                                                final int offset) throws DAOException {
        try {
            return (List<TicketEvent>)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "TicketEvent.getEventsForTicketOrderByEventDateDESC");
                    q.setParameter(1, ticketId);
                    q.setFirstResult(offset);
                    q.setMaxResults(pageSize);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<AdditionalFile> getAttachmentsForTicket(final Long ticketId, final int pageSize, 
                                                        final int offset) throws DAOException {
        try {
            return (List<AdditionalFile>)this.jpaTemplate.execute(new JpaCallback() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "AdditionalFile.getAttachmentsForTicketOrderByEventDateDESC");
                    q.setParameter(1, ticketId);
                    q.setFirstResult(offset);
                    q.setMaxResults(pageSize);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Article> getAssignedArticlesForTicket(final Long ticketId, final int pageSize,
                                                      final int offset) throws DAOException {
        try {
            return (List<Article>) this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("SELECT article_id FROM article_ticket WHERE ticket_id = ?1");
                    q.setParameter(1, ticketId);
                    List articleIds = q.getResultList();
                    q = em.createQuery("SELECT a FROM Article a WHERE a.id IN(?1) ORDER BY a.createdAt DESC");
                    q.setParameter(1, articleIds);
                    return q.getResultList();
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public List<Ticket> searchWithQuery(final String query) throws DAOException {
        try {
            return this.jpaTemplate.execute(new JpaCallback<List<Ticket>>() {
                public List<Ticket> doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT t FROM Ticket t WHERE t.subject LIKE '%" + query + "%'");
                    q.setMaxResults(5);
                    return q.getResultList();
                }
            });
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countWithQuery(final String query) throws DAOException {
        try {
            return (this.jpaTemplate.execute(new JpaCallback<Long>() {
                public Long doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("SELECT COUNT(t) FROM Ticket t WHERE t.subject LIKE '%" + query + "%'");
                    return (Long)q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countCommentsForTicket(final Long ticketId) throws DAOException {
        try {
            return (this.jpaTemplate.execute(new JpaCallback<Long>() {
                public Long doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "TicketComment.countCommentsForTicket");
                    q.setParameter(1, ticketId);
                    return (Long)q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countEventsForTicket(final Long ticketId) throws DAOException {
        try {
            return (this.jpaTemplate.execute(new JpaCallback<Long>() {
                public Long doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "TicketEvent.countEventsForTicket");
                    q.setParameter(1, ticketId);
                    return (Long)q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countAttachmentsForTicket(final Long ticketId) throws DAOException {
        try {
            return (this.jpaTemplate.execute(new JpaCallback<Long>() {
                public Long doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNamedQuery(
                            "AdditionalFile.countAttachmentsForTicket");
                    q.setParameter(1, ticketId);
                    return (Long)q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public int countAssignedArticlesForTicket(final Long ticketId) throws DAOException {
        try {
            return (this.jpaTemplate.execute(new JpaCallback<Long>() {
                public Long doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createNativeQuery("SELECT COUNT(*) FROM article_ticket WHERE ticket_id=?1");
                    q.setParameter(1, ticketId);
                    return (Long)q.getSingleResult();
                }
            })).intValue();
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void saveAdditionalFile(AdditionalFile addFile) throws DAOException {
        try {
            final TicketEvent event = TicketEvent.attachmentAdded(addFile);
            this.jpaTemplate.persist(event);
            this.jpaTemplate.persist(addFile);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }

    public AdditionalFile getAdditionalFileById(Long id) throws DAOException {
        try {
            return this.jpaTemplate.find(AdditionalFile.class, id);
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
    
    public void removeAdditionalFile(final AdditionalFile file) throws DAOException {
        removeAdditionalFile(file.getFileId());
    }
    
    @Transactional(readOnly = false)
    public void removeAdditionalFile(final Long id) throws DAOException {
        try {
            this.jpaTemplate.execute(new JpaCallback<Object>() {
                public Object doInJpa(EntityManager em) throws PersistenceException {
                    Query q = em.createQuery("DELETE FROM AdditionalFile f WHERE f.fileId = ?1");
                    q.setParameter(1, id);
                    q.executeUpdate();
                    return null;
                }
            });
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
}
