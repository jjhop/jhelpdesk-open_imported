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

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.mail.MailerService;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.User;

/**
 * @author jjhop
 */
@Controller
public class TicketCloseController {

    private final static String FORM_VIEW  = "/tickets/close/form";
    private final static String RESULT_VIEW = "/ticket/action/result/lite";

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private MailerService mailer;

    @RequestMapping(value = "/tickets/{ticketId}/close.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("ticketId") Long ticketId, ModelMap map) {
        map.addAttribute("ticketId", ticketId);
        return FORM_VIEW;
    }

    @RequestMapping(value = "/tickets/{ticketId}/close.html", method = RequestMethod.POST)
    public String processRequest(@PathVariable("ticketId") Long ticketId, ModelMap map,
                                 HttpSession session) throws Exception {

        User currentUser = (User) session.getAttribute("loggedUser");
        Ticket ticket = ticketDAO.getTicketById(ticketId);

        ticketDAO.close(ticket, currentUser);
        mailer.sendNotificationForTicketCloseEvent(ticketId);
        return RESULT_VIEW;
    }
}
