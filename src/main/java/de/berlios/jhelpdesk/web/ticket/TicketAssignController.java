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
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.mail.MailerService;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.TicketActionForm;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.TicketActionFormValidator;
import de.berlios.jhelpdesk.web.tools.UserEditor;

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

    @Autowired
    private UserEditor userEditor;

    @Autowired
    private MailerService mailer;

    @Autowired
    private TicketActionFormValidator validator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(User.class, "user", userEditor);
    }

    @RequestMapping(value = "/tickets/{tId}/assignToMe.html", method = RequestMethod.GET)
    public String assignTicketToMeAsk(@PathVariable("tId") Long ticketId,
                                      HttpSession session) {
        User currentUser = (User)session.getAttribute("user");
        return "/tickets/assigntome/form";
    }

    @RequestMapping(value = "/tickets/{tId}/assignToMe.html", method = RequestMethod.POST)
    public String assignTicketToMe(@PathVariable("tId") Long ticketId,
                                   HttpSession session) throws Exception {
        User currentUser = (User)session.getAttribute("user");
        ticketDAO.assignTicket(ticketId, currentUser.getUserId());
        mailer.sendNotificationForTicketAssignEvent(ticketId);
        return "/tickets/assigntome/result";
    }

    @RequestMapping(value = "/tickets/{tId}/assignTo.html", method = RequestMethod.GET)
    public String assignTo(@PathVariable("tId") Long ticketId, ModelMap map,
                           HttpSession session) throws Exception {
        User currentUser = (User)session.getAttribute("user");
        if (currentUser.isManager()) {
            map.addAttribute("saviours", userDAO.getByRole(Role.TICKETKILLER));
            map.addAttribute("assignForm", new TicketActionForm());
            map.addAttribute("ticketId", ticketId);
            return "/tickets/assignto/form";
        } else {
            throw new RuntimeException("Niewystarczające uprawnienia!");
        }
    }

    @RequestMapping(value = "/tickets/{tId}/assignTo.html", method = RequestMethod.POST)
    public String processAssignTo(@PathVariable("tId") Long ticketId,
                                  @ModelAttribute("assignForm") TicketActionForm form,
                                  BindingResult result, ModelMap map,
                                  HttpSession session) throws Exception {
        User currentUser = (User)session.getAttribute("user");
        if (currentUser.isManager()) {
            validator.validate(form, result);
            if (result.hasErrors()) {
                map.addAttribute("saviours", userDAO.getByRole(Role.TICKETKILLER));
                map.addAttribute("ticketId", ticketId);
                return "/tickets/assignto/form";
            }
            ticketDAO.assignTicket(ticketId, form.getUser().getUserId(), currentUser.getUserId());
            mailer.sendNotificationForTicketAssignEvent(ticketId);
            return "/tickets/assignto/result";
        } else {
            throw new RuntimeException("Niewystarczające uprawnienia!");
        }
    }
}
