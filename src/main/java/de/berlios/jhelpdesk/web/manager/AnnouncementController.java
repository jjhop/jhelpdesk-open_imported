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
package de.berlios.jhelpdesk.web.manager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import de.berlios.jhelpdesk.dao.AnnouncementDAO;
import de.berlios.jhelpdesk.model.Announcement;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.commons.PagingParamsEncoder;
import de.berlios.jhelpdesk.web.tools.AnnouncementValidator;

/**
 * Kontroler obsługujący zarządzanie ogłoszeniami z działu wsparcia.
 *
 * @author jjhop
 * 
 * @see Announcement
 * @see AnnouncementDAO
 * @see AnnouncementValidator
 */
@Controller
public class AnnouncementController {

    private static Logger log = LoggerFactory.getLogger(AnnouncementController.class);

    @Autowired
    private AnnouncementValidator validator;

    @Autowired
    private AnnouncementDAO announcementDAO;

    /**
     * Wyświetla ogłoszenie na podstawie dostarczonego identyfikatora.
     *
     * @param infoId identyfikator ogłoszenia
     * @param map modelu widoku
     * @return identyfikator widoku prezentującego ogłoszenia
     */
    @RequestMapping("/announcements/{id}/show.html")
    public String showAnnouncement(@PathVariable("id") Long infoId,
                                   ModelMap map) throws Exception {
        try {
            map.addAttribute("announcement", announcementDAO.getById(infoId));
        } catch (Exception e) {
            log.error(e.getMessage());
            map.addAttribute("errorInfo", e.getMessage());
        }
        return "announcement/show";
    }

    /**
     * Wyświetla pełną listę ogłoszeń.
     * TODO: stronicowanie announcementsIterator
     *
     * @param map model widoku
     * @return identyfikator widoku prezentującego listę ogłoszeń
     */
    @RequestMapping("/announcements/list.html")
    public String showAllAnnouncements(HttpServletRequest request, HttpSession session,
                                       ModelMap map) throws Exception {
        User currentUser = (User) session.getAttribute("user");
        int pageSize = currentUser.getAnnouncementsListSize();

        PagingParamsEncoder enc =
                new PagingParamsEncoder("announcementsIterator", null, request, pageSize);
        int offset = enc.getOffset();
        map.addAttribute("listSize", pageSize);
        map.addAttribute("offset", offset);
        map.addAttribute("announcements", announcementDAO.get(pageSize, offset));
        map.addAttribute("announcementsListSize", announcementDAO.countAll());
        return "announcement/showAll";
    }

    /**
     * Usuwa ogłoszenie na podstawie dostarczonego identyfikatora.
     *
     * @param annId identyfikator ogłoszenia do usunięcia
     * @return widok do wyświetlania po usunięciu ogłoszenia
     */
    @RequestMapping("/announcements/{id}/remove.html")
    public String removeAnnouncement(@PathVariable("id") Long annId) throws Exception {
        try {
            announcementDAO.delete(annId);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return "redirect:/announcements/list.html";
    }

    /**
     * Przygotowuje formularz do dodania (lub edycji) ogłoszenia. Jeśli w
     * żądaniu znaduje się identyfikator ogłoszenia to zostanie ono przygotowane
     * do edycji, w przeciwnym wypadku do modelu zostanie dołączony nowy (pusty)
     * obiekt ogłoszenia.
     * 
     * @param infoId identyfikator ogłoszenia do edycji
     * @param map model widoku
     * @return identyfikato widoku
     */
    @RequestMapping(value = "/announcements/{id}/edit.html", method = RequestMethod.GET)
    protected String prepareEditForm(@PathVariable("id") Long infoId,
                                     ModelMap map) throws Exception {
        map.addAttribute("announcement", announcementDAO.getById(infoId));
        return "announcement/edit";
    }

    @RequestMapping(value = "/announcements/new.html", method = RequestMethod.GET)
    protected String prepareNewForm(ModelMap map) {
        map.addAttribute(new Announcement());
        return "announcement/edit";
    }

    /**
     * Obsługuje wysłany formularz i zapisuje podany obiekt. Decyzję o tym czy
     * jest to update czy dodanie nowego podejmuje stosowny obiekt DAO.
     *
     * @param announcement obiekt ogłoszenia do zapisania (po poprawnym zwalidowaniu)
     *
     * @param result
     * @param status
     * @return identyfikator widoku do wyświetlenia
     * 
     */
    @RequestMapping(value = "/announcements/save.html", method = RequestMethod.POST)
    protected String processSubmit(@ModelAttribute("announcement") Announcement announcement,
                                   BindingResult result, SessionStatus status) throws Exception {

        validator.validate(announcement, result);
        if (result.hasErrors()) {
            return "announcement/edit";
        }
        announcementDAO.save(announcement);
        status.setComplete();
        return "redirect:list.html";
    }
}
