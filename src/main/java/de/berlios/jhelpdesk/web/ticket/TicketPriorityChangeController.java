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

import java.util.List;
import java.util.ArrayList;
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
import de.berlios.jhelpdesk.mail.MailerService;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.TicketPriorityChangeForm;
import de.berlios.jhelpdesk.model.TicketPriority;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.TicketPriorityChangeFormValidator;
import de.berlios.jhelpdesk.web.tools.TicketPriorityEditor;

/**
 * @author jjhop
 */

@Controller
public class TicketPriorityChangeController {

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private TicketPriorityEditor priorityEditor;

    @Autowired
    private TicketPriorityChangeFormValidator validator;

    @Autowired
    private MailerService mailer;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(TicketPriority.class, priorityEditor);
    }

    @RequestMapping(value = "/tickets/{tId}/priorityChange.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("tId") Long ticketId, ModelMap map, HttpSession session) throws Exception {
        Ticket currentTicket = ticketDAO.getTicketById(ticketId);
        
        List<TicketPriority> priorities = new ArrayList<TicketPriority>(TicketPriority.getPriorities());
        priorities.remove(currentTicket.getTicketPriority());

        map.addAttribute("priorities", priorities);
        map.addAttribute("currentPriority", currentTicket.getTicketPriority());
        map.addAttribute("form", new TicketPriorityChangeForm());
        map.addAttribute("ticketId", ticketId);
        return "/tickets/priorityChange/form";
    }

    @RequestMapping(value = "/tickets/{tId}/priorityChange.html", method = RequestMethod.POST)
    public String processCategoryChange(@PathVariable("tId") Long ticketId,
                                        @ModelAttribute("form") TicketPriorityChangeForm form,
                                        BindingResult result, ModelMap map, HttpSession session) throws Exception {

        validator.validate(form, result);
        Ticket currentTicket = ticketDAO.getTicketById(ticketId);
        if (result.hasErrors()) {
            List<TicketPriority> priorities = new ArrayList<TicketPriority>(TicketPriority.getPriorities());
            priorities.remove(currentTicket.getTicketPriority());

            map.addAttribute("priorities", priorities);
            map.addAttribute("currentPriority", currentTicket.getTicketPriority());
            map.addAttribute("form", form);
            map.addAttribute("ticketId", ticketId);
            return "/tickets/priorityChange/form";
        }

        currentTicket.setTicketPriority(form.getPriority());
        ticketDAO.changePriorityWithComment(currentTicket, form.getPriority(), form.getCommentText(), (User) session.getAttribute("loggedUser"));

        // tutaj zapis mail itd
        return "/tickets/priorityChange/result";
    }
}
