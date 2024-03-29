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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.TicketCategoryDAO;
import de.berlios.jhelpdesk.dao.TicketFilterDAO;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.TicketCategory;
import de.berlios.jhelpdesk.model.TicketFilter;
import de.berlios.jhelpdesk.model.TicketPriority;
import de.berlios.jhelpdesk.model.TicketStatus;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.TicketCategoryEditor;
import de.berlios.jhelpdesk.web.tools.TicketFilterValidator;
import de.berlios.jhelpdesk.web.tools.UserEditor;

/**
 *
 * @author jjhop
 */
@Controller
public class CustomFilterEditController {

    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private TicketFilterDAO ticketFilterDAO;

    @Autowired
    private TicketCategoryDAO  ticketCategoryDAO;

    @Autowired
    private UserEditor userEditor;

    @Autowired
    private TicketCategoryEditor categoryEditor;

    @Autowired
    private TicketFilterValidator ticketFilterValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
        binder.registerCustomEditor(User.class, userEditor);
        binder.registerCustomEditor(TicketCategory.class, categoryEditor);
    }

    @ModelAttribute("ticketCategories")
    public List<TicketCategory> populateTicketCategories() throws Exception {
        return ticketCategoryDAO.getAllCategoriesForView();
    }

    @ModelAttribute("ticketPriorities")
    public List<TicketPriority> populateTicketPriorities() {
        return TicketPriority.getPriorities();
    }

    @ModelAttribute("ticketStatuses")
    public TicketStatus[] populateTicketStatuses() {
        return TicketStatus.getAllStatuses();
    }
    
    @ModelAttribute("saviours")
    public List<User> populateSaviuours() throws Exception {
        return userDAO.getByRole(Role.TICKETKILLER);
    }

    @ModelAttribute("notifiers")
    public List<User> populateNotifiers() {
        try {
            return userDAO.getAllUsers();
        } catch (DAOException ex) {
            throw new RuntimeException(ex);
        }
    }

    @RequestMapping(value = "/preferences/filters/{filterId}/edit.html", method = GET)
    public String prepareEditForm(@PathVariable("filterId") Long filterId,
                                  ModelMap map) throws Exception {
        map.addAttribute("filter", ticketFilterDAO.getById(filterId));
        return "preferences/filters/edit";
    }

    @RequestMapping(value = "/preferences/filters/new.html", method = GET)
    public String prepareNewForm(ModelMap map, HttpSession session) {
        User currentUser = (User)session.getAttribute("loggedUser");
        TicketFilter filter = new TicketFilter();
        filter.setOwner(currentUser);
        map.addAttribute("filter", filter);
        String message = (String) session.getAttribute("message");
        if (message != null) {
            session.removeAttribute("message");
            map.addAttribute("message", message);
        }
        return "preferences/filters/edit";
    }

    @RequestMapping(value = "/preferences/filters/save.html", method = POST)
    public String processForm(@ModelAttribute("filter") TicketFilter filter,
                              BindingResult result, ModelMap map,
                              HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        ticketFilterValidator.validate(filter, result);
        if (result.hasErrors()) {
            map.addAttribute(filter);
            return "preferences/filters/edit";
        }
        ticketFilterDAO.saveOrUpdate(filter);
        session.setAttribute("loggedUser", userDAO.getByEmailFetchFilters(currentUser.getEmail()));
        session.setAttribute("message", "Filtr został zapisany."); // ms.get
        map.clear();
        return "redirect:/preferences/filters/" + filter.getId() + "/edit.html";
    }
}
