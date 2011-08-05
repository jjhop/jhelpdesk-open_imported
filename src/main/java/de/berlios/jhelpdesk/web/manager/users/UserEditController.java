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
package de.berlios.jhelpdesk.web.manager.users;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomBooleanEditor;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.RoleEditor;
import de.berlios.jhelpdesk.web.tools.UserValidator;

/**
 * Kontroler obsługujacy dodawanie nowych oraz edycję istniejących użytkowników systemu.
 * Został wydzielony z klasy UserController ze względu na konieczność dodatkowych
 * wywołań initBinder(...) i populateRoles() dla każdego żądania, co niepotrzebnie
 * obciążało wszystkie żądania (takżę te, które nie wymagały tych działań).
 *
 *
 * @see User
 * @see UserDAO
 * @see UserValidator
 * 
 * @author jjhop
 */
@Controller
public class UserEditController {

    private final static Logger log = LoggerFactory.getLogger(UserEditController.class);
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    private UserValidator validator;

    @Autowired
    private RoleEditor roleEditor;

    /**
     * Rejestruje edytory właściwości niezbędne podczas edycji danych
     * użytkownika.
     *
     * @param binder
     *
     * @see WebDataBinder
     */
    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Role.class, "userRole", roleEditor);
        binder.registerCustomEditor(Long.class, null, 
            new CustomNumberEditor(Long.class, NumberFormat.getNumberInstance(), true));
        binder.registerCustomEditor(Boolean.class, null, new CustomBooleanEditor(true));
    }

    /**
     * Przygotowuje formularz edycji użytkownika.
     *
     * @param userId identyfikator użytkownika do edycji
     * @param map model widoku
     * @return identyfikator widoku
     */
    @RequestMapping(value = "/manage/users/{userId}/edit.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("userId") Long userId, ModelMap map, HttpSession session) {
        User currentUser = (User)session.getAttribute("loggedUser");
        try {
            map.addAttribute("userForm", userDAO.getById(userId));
            map.addAttribute("roles", getRolesForModel(currentUser));
        } catch (DAOException ex) {
            log.error("Komunikat....", ex);
            throw new RuntimeException(ex);
        }
        return "/users/edit";
    }

    @RequestMapping(value = "/manage/users/new.html", method = RequestMethod.GET)
    public String prepareForm(ModelMap map, HttpSession session) {
        User currentUser = (User)session.getAttribute("loggedUser");
        map.addAttribute("userForm", new User());
        map.addAttribute("roles", getRolesForModel(currentUser));
        return "/users/edit";
    }
    
    /**
     * Obsługuje wysłany formularz i zapisuje podany obiekt. Decyzję o tym czy jest
     * to update czy dodanie nowego podejmuje stosowny obiekt DAO.
     *
     * @param user obiekt użytkownika do zapisania
     * @param result
     * @return identyfikator widoku do wyświetlenia
     * 
     */
    @RequestMapping(value = {"/manage/users/new.html", "/manage/users/{userId}/edit.html"},
                    method = RequestMethod.POST)
    public String processSubmit(@ModelAttribute("userForm") User user, BindingResult result,
                                ModelMap map, HttpSession session) {
        User currentUser = (User) session.getAttribute("loggedUser");
        validator.validate(user, result);
        if (result.hasErrors()) {
            map.addAttribute("roles", getRolesForModel(currentUser));
            return "/users/edit";
        }
        try {
            userDAO.saveOrUpdate(user);
        } catch (DAOException ex) {
            log.error("Komunikat....", ex);
            throw new RuntimeException(ex);
        }
        return "redirect:/manage/users/" + user.getUserId() + "/show.html";
    }

    private List<Role> getRolesForModel(User currentUser) {
        List<Role> roles = new ArrayList<Role>();
        roles.add(Role.CLIENT);
        roles.add(Role.TICKETKILLER);
        if (currentUser.isManager()) {
            roles.add(Role.MANAGER);
        }
        return roles;
    }
}
