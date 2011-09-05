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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import de.berlios.jhelpdesk.dao.DAOException;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.commons.PagingParamsEncoder;

/**
 * Kontroler częściowo obsługujący zarządzanie użytkownikami systemu. Obsługuje tylko wyświetlanie listy
 * użytkowników, szczegółów wybranego użytkownika oraz usuwanie (patrz uwagi {@link #removeUser(java.lang.Long))
 * użytkownika. Dodawanie i edycja zostały przeniesione do oddzielnego kontrolera.
 *
 * @author jjhop
 *
 * @see UserEditController
 */
@Controller
public class UserController {

    private final static Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserDAO userDAO;

    /**
     * Wyświetla dane użytkownika na podstawie dostarczonego identyfikatora.
     *
     * @param userId identyfikator użytkownika
     * @param map modelu widoku
     * @return identyfikator widoku prezentującego użytkownika
     */
    @RequestMapping("/manage/users/{id}/show.html")
    public String showUser(@PathVariable("id") Long userId, ModelMap map) {
        try {
            map.addAttribute("user", userDAO.getById(userId));
        } catch (DAOException ex) {
            log.error("Komunikat....", ex);
            throw new RuntimeException(ex);
        }
        return "/users/show";
    }

    /**
     * Wyświetla pełną listę użytkowników.
     *
     * @param map model widoku
     * @return identyfikator widoku prezentującego listę użytkowników
     */
    @RequestMapping("/manage/users/list.html")
    public String showAllUsers(HttpServletRequest request, HttpSession session, ModelMap map) {

        User currentUser = (User) session.getAttribute("loggedUser");
        int pageSize = currentUser.getUsersListSize();
        PagingParamsEncoder enc = new PagingParamsEncoder("user", null, request, pageSize);
        int offset = enc.getOffset();

        try {
            map.addAttribute("users", userDAO.getUsers(pageSize, offset));
            map.addAttribute("usersListSize", userDAO.countUsers());
            map.addAttribute("listSize", pageSize);
            map.addAttribute("offset", offset);
        } catch (DAOException ex) {
            log.error("Komunikat....", ex);
            throw new RuntimeException(ex);
        }
        return "/users/showAll";
    }

    /**
     * Usuwa użytkownika z bazy danych systemu. (Lub po prostu oznacza go jako nieaktywnego).
     *
     * @param userId identyfikator uzytkownika do usunięcia
     * @return identyfikator widoku do wyświetlenia po usunięciu użytkownika
     */
    @RequestMapping("/manage/users/{id}/remove.html")
    public String removeUser(@PathVariable("id") Long userId) throws Exception {

        // można usunąć użytkownika jeśli nie zgłosił żadnego ticketu,
        // nie dodał żadnego pliku ani komentarza (do ticketu lub artykułu w DB)
        // ani nie dodał żadnego ogłoszenia... normalnie jeśli nie zrobił nic...

        // w przeciwnym wypadku tylko deaktywacja
        userDAO.deactivate(userId);
        return "redirect:/manage/users/list.html";
    }
}
