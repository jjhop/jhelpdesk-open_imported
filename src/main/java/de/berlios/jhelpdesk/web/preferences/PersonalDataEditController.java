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

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.PasswordForm;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.tools.PasswordFormValidator;
import de.berlios.jhelpdesk.web.tools.UserValidator;

/**
 * 
 * @author jjhop
 */
@Controller
public class PersonalDataEditController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private UserValidator validator;
    
    @Autowired
    private PasswordFormValidator passwordValidator;

    @RequestMapping(value = "/preferences/personalData.html", method = RequestMethod.GET)
    public String prepareForm(HttpSession session, ModelMap map) {
        map.addAttribute("personalData", getUserFromSession(session));
        return "preferences/personalData";
    }

    @RequestMapping(value = "/preferences/personalData/change.html", method = RequestMethod.POST)
    public String processPersonalDataChange(@ModelAttribute("personalData") User user,
                                            BindingResult result, ModelMap map) {
        validator.validate(user, result);
        if (result.hasErrors()) {
            map.addAttribute("user", user);
            return "preferences/personalData";
        }
        return "preferences/personalData";
    }

    @RequestMapping(value = "/preferences/personalData/password/change.html", method = RequestMethod.GET)
    public String preparePasswordChange(HttpSession session, ModelMap map) throws Exception {
        map.addAttribute("passwordForm", new PasswordForm());
        return "preferences/password/form";
    }

    @RequestMapping(value = "/preferences/personalData/password/change.html", method = RequestMethod.POST)
    public String processPasswordChange(@ModelAttribute("passwordForm") PasswordForm form,
                                        BindingResult result, ModelMap map, HttpSession session) throws Exception {
        User currentUser = getUserFromSession(session);
        passwordValidator.validate(form, result);

        currentUser.setPassword(form.getCurrentPassword());
        boolean isCurrentPasswordNotValid =
                !userDAO.authenticate(currentUser.getEmail(), currentUser.getPassword());
        
        if (result.hasErrors() || isCurrentPasswordNotValid) {
            if (isCurrentPasswordNotValid) {
                result.rejectValue("currentPassword", "passw.change.current.notValid");
            }
            map.addAttribute("passwordForm", form);
            return "preferences/password/form";
        }
        userDAO.updatePasswordAndSalt(currentUser, form.getNewPassword());
        return "preferences/password/thanks";
    }

    private User getUserFromSession(HttpSession session) {
        try {
            return userDAO.getById(((User) session.getAttribute("user")).getUserId());
        } catch (DAOException ex) {
            throw new RuntimeException(ex);
        }
    }
}
