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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.CommentType;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.TicketComment;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.TicketCommentValidator;

@Controller
public class TicketCommentsController {
    
    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private TicketCommentValidator commentValidator;

    @RequestMapping(value = "/tickets/{ticketId}/comments/save.html", method = RequestMethod.POST)
    public String processForm(@PathVariable("ticketId") Long ticketId,
                              @ModelAttribute("comment") TicketComment comment,
                              BindingResult result, ModelMap map, HttpSession session) throws Exception {

        commentValidator.validate(comment, result);
        if (result.hasErrors()) {
            map.addAttribute("comment", comment);
            map.addAttribute("ticketId", ticketId);
            return "tickets/commentForm";
        }

        Ticket ticket = ticketDAO.getTicketById(ticketId);
        comment.setTicket(ticket);
        comment.setCommentAuthor((User) session.getAttribute("loggedUser"));
        comment.setCommentType(CommentType.NORMAL);
        ticket.addComment(comment);
        ticketDAO.addComment(comment);
        return "tickets/commentThanks";
    }

    @RequestMapping(value = "/tickets/{ticketId}/comments/new.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("ticketId") Long ticketId, ModelMap map) {
        map.addAttribute("ticketId", ticketId);
        map.addAttribute("comment", new TicketComment());
        return "tickets/commentForm";
    }
}
