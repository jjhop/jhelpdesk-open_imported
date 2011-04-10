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
import org.springframework.beans.factory.annotation.Qualifier;
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
import de.berlios.jhelpdesk.web.tools.UserDataValidator;

/**
 * 
 * @author jjhop
 */
@Controller
public class PersonalDataEditController {

    private static final String PD_FORM_VIEW = "preferences/personalData";
    private static final String PD_PASSWORD_FORM_VIEW = "preferences/password/form";
    private static final String PD_PASSWORD_THANKS_VIEW = "preferences/password/thanks";

    @Autowired
    private UserDAO userDAO;

    @Autowired
    @Qualifier("onlyData")
    private UserDataValidator validator;
    
    @Autowired
    private PasswordFormValidator passwordValidator;

    @RequestMapping(value = "/preferences/personalData.html", method = RequestMethod.GET)
    public String prepareForm(HttpSession session, ModelMap map) {
        map.addAttribute("personalData", getUserFromSession(session));
        return PD_FORM_VIEW;
    }

    @RequestMapping(value = "/preferences/personalData/change.html", method = RequestMethod.POST)
    public String processPersonalDataChange(@ModelAttribute("personalData") User user,
                                            BindingResult result, ModelMap map, 
                                            HttpSession session) throws Exception {
        User currentUser = getUserFromSession(session);
        validator.validate(user, result);
        if (result.hasErrors()) {
            map.addAttribute("user", user);
            return PD_FORM_VIEW;
        }
        user.setUserId(currentUser.getUserId());
        userDAO.saveOrUpdate(user);
        return PD_FORM_VIEW;
    }

    @RequestMapping(value = "/preferences/personalData/password/change.html", method = RequestMethod.GET)
    public String preparePasswordChange(HttpSession session, ModelMap map) throws Exception {
        map.addAttribute("passwordForm", new PasswordForm());
        return PD_PASSWORD_FORM_VIEW;
    }

    @RequestMapping(value = "/preferences/personalData/password/change.html", method = RequestMethod.POST)
    public String processPasswordChange(@ModelAttribute("passwordForm") PasswordForm form,
                                        BindingResult result, ModelMap map, HttpSession session) throws Exception {
        User currentUser = getUserFromSession(session);
        passwordValidator.validate(form, result);

        boolean isCurrentPasswordValid =
                userDAO.authenticate(currentUser.getEmail(),
                                     currentUser.getHashedPassword(form.getCurrentPassword()));
        if (result.hasErrors() || !isCurrentPasswordValid) {
            if (!isCurrentPasswordValid) {
                result.rejectValue("currentPassword", "passw.change.current.notValid");
            }
            map.addAttribute("passwordForm", form);
            return PD_PASSWORD_FORM_VIEW;
        }
        userDAO.updatePasswordAndSalt(currentUser, form.getNewPassword());
        return PD_PASSWORD_THANKS_VIEW;
    }

    private User getUserFromSession(HttpSession session) {
        try {
            return userDAO.getById(((User) session.getAttribute("user")).getUserId());
        } catch (DAOException ex) {
            throw new RuntimeException(ex);
        }
    }
}
