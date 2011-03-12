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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.berlios.jhelpdesk.dao.TicketDAO;

/**
 *
 * @author jjhop
 */
@Controller
public class TicketAssignController {

    @Autowired
    private TicketDAO ticketDAO;

    @RequestMapping(value = "/tickets/{tId}/assign.html", method = RequestMethod.GET)
    public String assignTicket(@PathVariable("tId") Long ticketId,
                               @RequestParam("uId") Long userId) throws Exception {

        ticketDAO.assignTicket(ticketId, userId);

        return "redirect:/tickets/" + ticketId + "/details.html";
    }
}
