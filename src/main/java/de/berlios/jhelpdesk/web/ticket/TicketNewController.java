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

import java.util.Collection;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import de.berlios.jhelpdesk.dao.TicketCategoryDAO;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.TicketCategory;
import de.berlios.jhelpdesk.model.TicketPriority;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.utils.StampUtils;
import de.berlios.jhelpdesk.utils.FileUtils;
import de.berlios.jhelpdesk.web.tools.TicketCategoryEditor;
import de.berlios.jhelpdesk.web.tools.TicketPriorityEditor;
import de.berlios.jhelpdesk.web.tools.TicketValidator;
import de.berlios.jhelpdesk.web.tools.UserEditor;

/**
 * Kontroler obsługujący jednokrokowe dodawnie zgłoszenia.
 * 
 * @author jjhop
 */
@Controller
@SessionAttributes("ticket")
public class TicketNewController {

    private final static String NEW_TICKET_VIEW = "tickets/new";

    @Autowired
    private TicketValidator validator;

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private TicketCategoryDAO ticketCategoryDao;

    @Autowired
    private UserEditor userEditor;

    @Autowired
    private TicketPriorityEditor priorityEditor;

    @Autowired
    private TicketCategoryEditor categoryEditor;

    @Autowired
    private AttachmentUtils attachmentUtils;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(User.class, "notifier", userEditor);
        binder.registerCustomEditor(TicketPriority.class, priorityEditor);
        binder.registerCustomEditor(TicketCategory.class, categoryEditor);
    }

    @ModelAttribute("priorities")
    public Collection<TicketPriority> populateTicketPriorities() {
        return TicketPriority.getPriorities();
    }

    @ModelAttribute("categories")
    public Collection<TicketCategory> populateTicketCategories() throws Exception {
        return ticketCategoryDao.getAllCategoriesForView();
    }

    @RequestMapping(value = "/tickets/new.html", method = RequestMethod.GET)
    public String prepareForm(ModelMap map, HttpSession session) {
        Ticket t = new Ticket();
        User u = (User) session.getAttribute("loggedUser");
        t.setTicketstamp(StampUtils.craeteStampFromObjects(u, u.getUserId()));
        t.setInputer(u);
        if (u.isPlain()) {
            t.setNotifier(u);
        }
        map.addAttribute("ticket", t);
        return NEW_TICKET_VIEW;
    }

    @RequestMapping(value = "/tickets/new.html", method = RequestMethod.POST)
    public String processSubmit(@ModelAttribute("ticket") Ticket ticket, BindingResult result,
                                HttpServletRequest request, SessionStatus status, 
                                HttpSession session) throws Exception {
        
        if (isCheckLoginRequest(request)) { // only checkUser
            validator.validateNotifier(ticket, result);
            return NEW_TICKET_VIEW;
        }
        validator.validate(ticket, result);
        if (!result.hasErrors()) {
            attachmentUtils.storeToRepositoryAndBindWithTicket(
                ticket,
                (User) session.getAttribute("loggedUser"),
                (List<FileInfo>) session.getAttribute("currentUploadedFiles"));
            ticketDAO.save(ticket);
            // tutaj ustalamy pojedynczą ścieżkę
            Collection<String> paths =  (Collection<String>) session.getAttribute("paths");
            FileUtils.cleanPathsForTicketstamp(paths, ticket.getTicketstamp());
            status.setComplete();
        } else {
            return NEW_TICKET_VIEW;
        }
        return "redirect:/tickets/" + ticket.getTicketId() + "/details.html";
    }
    
    private boolean isCheckLoginRequest(HttpServletRequest req) {
        Enumeration<String> pnames = req.getParameterNames();
        while(pnames.hasMoreElements()) {
            String p = pnames.nextElement();
            if (p.startsWith("_checkLogin")) {
                return true;
            }
        }
        return false;
    }
}
