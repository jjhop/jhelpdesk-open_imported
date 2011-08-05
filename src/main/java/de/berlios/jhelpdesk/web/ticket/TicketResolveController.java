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
import de.berlios.jhelpdesk.model.TicketComment;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.TicketCommentValidator;

/**
 * @author jjhop
 */
@Controller
public class TicketResolveController {

    private static final String FORM_VIEW = "/tickets/resolve/form";
    private static final String RESULT_VIEW = "/tickets/resolve/result";

    @Autowired
    private TicketCommentValidator validator;

    @Autowired
    private TicketDAO ticketDAO;

    @RequestMapping(value = "/tickets/{ticketId}/resolve.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("ticketId") Long ticketId, ModelMap map) {

        map.addAttribute("ticketId", ticketId);
        map.addAttribute("comment", new TicketComment());
        return FORM_VIEW;
    }

    @RequestMapping(value = "/tickets/{ticketId}/resolve.html", method = RequestMethod.POST)
    public String processRequest(@ModelAttribute("comment") TicketComment comment, BindingResult result,
                                 @PathVariable("ticketId") Long ticketId, ModelMap map,
                                 HttpSession session) throws Exception {

        validator.validate(comment, result);
        if (result.hasErrors()) {
            map.addAttribute("ticketId", ticketId);
            map.addAttribute("comment", comment);
            return FORM_VIEW;
        }
        comment.setTicket(ticketDAO.getTicketById(ticketId));
        comment.setCommentType(CommentType.REJECT);
        comment.setNotForPlainUser(false);
        comment.setCommentAuthor((User) session.getAttribute("loggedUser"));

        ticketDAO.resolveWithComment(comment);

        return RESULT_VIEW;
    }

}
