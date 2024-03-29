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
package de.berlios.jhelpdesk.dao;

import java.util.List;

import de.berlios.jhelpdesk.model.TicketFilter;
import de.berlios.jhelpdesk.model.User;

/**
 *
 * @author jjhop
 */
public interface TicketFilterDAO {

    void saveOrUpdate(TicketFilter ticketFilter) throws DAOException;

    List<TicketFilter> getAllFiltersForUser(User user) throws DAOException;

    TicketFilter getById(Long filterId) throws DAOException;

    void delete(Long filterId) throws DAOException;

    void delete(TicketFilter filter) throws DAOException;

    List<TicketFilter> getForUser(User currentUser, int pageSize, int page) throws DAOException;
}
