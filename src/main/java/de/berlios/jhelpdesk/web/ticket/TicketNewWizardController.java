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

import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
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
import org.springframework.web.multipart.support.ByteArrayMultipartFileEditor;

import de.berlios.jhelpdesk.dao.TicketCategoryDAO;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.TicketCategory;
import de.berlios.jhelpdesk.model.TicketPriority;
import de.berlios.jhelpdesk.model.TicketStatus;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.utils.FileUtils;
import de.berlios.jhelpdesk.utils.StampUtils;
import de.berlios.jhelpdesk.web.tools.TicketCategoryEditor;
import de.berlios.jhelpdesk.web.tools.TicketPartialValidator;
import de.berlios.jhelpdesk.web.tools.TicketPriorityEditor;
import de.berlios.jhelpdesk.web.tools.UserEditor;

/**
 * Kontroler obsługujący krokowe dodawania zgłoszenia.
 *
 * Metody #isFinish oraz #getTarget na podstawie AbstractWizardFormController ze SpringWebMVC,
 * której autorem jest Juergen Hoeller.
 * 
 * @author jjhop
 */
@Controller
@SessionAttributes("hdticket")
public class TicketNewWizardController {

    private static final String[] SUBMIT_IMAGE_SUFFIXES = {".x", ".y"};

    private static final String[] views = new String[]{
        "ticketWizard/step1", "ticketWizard/step2",
        "ticketWizard/step3", "ticketWizard/step4",
        "ticketWizard/summary" };

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private TicketPartialValidator partialValidator;

    @Autowired
    private TicketCategoryDAO ticketCategoryDao;

    @Autowired
    private UserEditor userEditor;

    @Autowired
    private TicketPriorityEditor ticketPriorityEditor;

    @Autowired
    private TicketCategoryEditor ticketCategoryEditor;

    @Autowired
    private AttachmentUtils attachmentUtils;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        NumberFormat nf = NumberFormat.getNumberInstance();
        binder.registerCustomEditor(Long.class, null, new CustomNumberEditor(Long.class, nf, true));
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(byte[].class, new ByteArrayMultipartFileEditor());
        binder.registerCustomEditor(User.class, userEditor);
        binder.registerCustomEditor(TicketPriority.class, ticketPriorityEditor);
        binder.registerCustomEditor(TicketCategory.class, ticketCategoryEditor);
    }

    @ModelAttribute("categories")
    public Collection<TicketCategory> populateTicketCategories() throws Exception {
        return ticketCategoryDao.getAllCategoriesForView();
    }

    @ModelAttribute("priorities")
    public Collection<TicketPriority> populateTicketPriorities() {
        return TicketPriority.getPriorities();
    }

    @ModelAttribute("readOnly")
    public Boolean testReadOnly(HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedUser");
        return currentUser.getUserRole().equals(Role.CLIENT);
    }

    @RequestMapping(value="/tickets/wizzard.html")
    public String prepareWizzard(ModelMap map, HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        Ticket ticket = new Ticket();
        ticket.setTicketstamp(
            StampUtils.craeteStampFromObjects(currentUser, currentUser.getUserId()));
        ticket.setTicketStatus(TicketStatus.NOTIFIED);
        ticket.setInputer(currentUser);
        ticket.setTicketCategory(ticketCategoryDao.getDefault());
        map.addAttribute("hdticket", ticket);
        if (currentUser.getUserRole().equals(Role.CLIENT)) {
            ticket.setNotifier(currentUser);
        }
        return views[0];
    }

    @RequestMapping(value = "/tickets/wizzard.html", method = RequestMethod.POST)
    public String processRequest(@ModelAttribute("hdticket") Ticket ticket,
                                 BindingResult result, SessionStatus status, ModelMap map,
                                 HttpServletRequest request, HttpSession session) throws Exception {
        int currentPage = getCurrentPage(request);
        int targetPage = getTarget(request, currentPage);
        this.validatePage(ticket, request, result, currentPage);
        if (isFinish(request)) {
            return this.processFinnish(ticket, status, map, session);
        }
        int viewIndex = !result.hasErrors() || targetPage <= currentPage
                ? targetPage : currentPage;
        map.addAttribute("currentFiles", session.getAttribute(ticket.getTicketstamp() + "_files"));
        return views[viewIndex];
    }

    private void validatePage(Ticket ticket, HttpServletRequest request, BindingResult status, int page) {
        switch (page) {
            case 0:
                partialValidator.validateUser(ticket, request.getParameter("notifier"), status);
                break;
            case 1:
                partialValidator.validateSubjectAndDescription(ticket, status);
                break;
        }
    }

    private int getTarget(HttpServletRequest request, int currentPage) {
        if (request.getParameter("_checkLogin") != null) {
            return 0;
        }
        String paramPrefix  = "_target";
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            if (paramName.startsWith(paramPrefix)) {
                for (int i = 0; i < SUBMIT_IMAGE_SUFFIXES.length; i++) {
                    String suffix = SUBMIT_IMAGE_SUFFIXES[i];
                    if (paramName.endsWith(suffix)) {
                        paramName = paramName.substring(0, paramName.length() - suffix.length());
                    }
                }
                return Integer.parseInt(paramName.substring(paramPrefix.length()));
            }
        }
        return currentPage;
    }

    private int getCurrentPage(HttpServletRequest request) {
        String page = request.getParameter("currentPage");
        if (page != null) {
            return Integer.parseInt(page) - 1;
        }
        return 0;
    }

    private boolean isFinish(HttpServletRequest request) {
        String paramName = "_finish";
        if (request.getParameter(paramName) != null) {
            return true;
        }
        for (String suffix : SUBMIT_IMAGE_SUFFIXES) {
            if (request.getParameter(paramName + suffix) != null) {
                return true;
            }
        }
        return false;
    }
    
    private String processFinnish(Ticket ticket, SessionStatus status, ModelMap map, HttpSession session) throws Exception {
        attachmentUtils.storeToRepositoryAndBindWithTicket(
                ticket,
                (User) session.getAttribute("loggedUser"),
                (List<FileInfo>) session.getAttribute(ticket.getTicketstamp() + "_files"));
        ticketDAO.save(ticket);
        status.setComplete();
        Collection<String> paths =  (Collection<String>) session.getAttribute("paths");
        FileUtils.cleanPathsForTicketstamp(paths, ticket.getTicketstamp());
        map.clear();
        return "redirect:/tickets/" + ticket.getTicketId() + "/details.html";
    }
}
