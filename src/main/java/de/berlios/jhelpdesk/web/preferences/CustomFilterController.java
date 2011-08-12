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
package de.berlios.jhelpdesk.web.preferences;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.TicketFilterDAO;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.TicketFilter;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.commons.PagingParamsEncoder;

/**
 *
 * @author jjhop
 */
@Controller
public class CustomFilterController {

    @Autowired
    private TicketFilterDAO ticketFilterDAO;

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/preferences/filters/list.html", method = RequestMethod.GET)
    public String showAllFilters(ModelMap map, HttpServletRequest request,
                                 HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        int pageSize = currentUser.getFiltersListSize();
        int filtersCount = currentUser.getFilters().size();
        PagingParamsEncoder enc =
                new PagingParamsEncoder("filtersIterator", null, request, pageSize);
        int offset = enc.getOffset();

        map.addAttribute("filters", ticketFilterDAO.getForUser(currentUser, pageSize, offset));
        map.addAttribute("offset", offset);
        map.addAttribute("listSize", pageSize);
        map.addAttribute("filtersListSize", filtersCount);
        return "preferences/filters/showAll";
    }

    @RequestMapping(value = "/preferences/filters/{filterId}/delete.html", method = RequestMethod.GET)
    public String deleteFilter(@PathVariable("filterId") Long filterId,
                               HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        TicketFilter filter = ticketFilterDAO.getById(filterId);
        if (filter != null && filter.isOwnedBy(currentUser)) {
            try {
                ticketFilterDAO.delete(filter);
                session.setAttribute("loggedUser", userDAO.getByEmailFetchFilters(currentUser.getEmail()));
            } catch (DAOException ex) {
                throw new RuntimeException(ex);
            }
        }
        return "redirect:/preferences/filters/list.html";
    }
}
