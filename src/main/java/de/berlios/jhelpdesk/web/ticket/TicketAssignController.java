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
package de.berlios.jhelpdesk.web.ticket;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.User;

/**
 *
 * @author jjhop
 */
@Controller
public class TicketAssignController {

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private UserDAO userDAO;

    @RequestMapping(value = "/tickets/{tId}/assign.html", method = RequestMethod.GET)
    public String assignTicket(@PathVariable("tId") Long ticketId,
                               @RequestParam("uId") Long userId,
                               HttpSession session) throws Exception {
        User currentUser = (User)session.getAttribute("user");

        ticketDAO.assignTicket(ticketId, userId, currentUser.getUserId());

        return "redirect:/tickets/" + ticketId + "/details.html";
    }

    @RequestMapping(value = "/tickets/{tId}/assignTo.html", method = RequestMethod.GET)
    public String assignTo(@PathVariable("tId") Long ticketId, ModelMap map, HttpSession session) throws Exception {

        map.addAttribute("saviours", userDAO.getByRole(Role.TICKETKILLER));
        return "/tickets/assignto/form";
    }
}
