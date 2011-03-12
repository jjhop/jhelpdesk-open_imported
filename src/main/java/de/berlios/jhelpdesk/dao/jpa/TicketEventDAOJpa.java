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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.TicketEventDAO;
import de.berlios.jhelpdesk.model.TicketEvent;

/**
 *
 * @author jjhop
 */
@Repository
@Transactional(readOnly = true)
public class TicketEventDAOJpa implements TicketEventDAO {

    private final JpaTemplate jpaTemplate;

    @Autowired
    public TicketEventDAOJpa(EntityManagerFactory emf) {
        this.jpaTemplate = new JpaTemplate(emf);
    }

    public List<TicketEvent> getByTicket(Long ticketId) throws DAOException {
        try {
            return this.jpaTemplate.findByNamedQuery(
                    "TicketEvent.getByTicketIdOrderByEventDateDESC", ticketId);
        } catch (Exception ex) {
            throw new DAOException(ex);
        }
    }

    @Transactional(readOnly = false)
    public void save(TicketEvent event) throws DAOException {
        try {
            if (event.getTicketEventId() == null) {
                this.jpaTemplate.persist(event);
            } else {
                this.jpaTemplate.merge(event);
            }
        } catch(Exception ex) {
            throw new DAOException(ex);
        }
    }
}
