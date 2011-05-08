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
package de.berlios.jhelpdesk.web.desktop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import de.berlios.jhelpdesk.dao.AnnouncementDAO;
import de.berlios.jhelpdesk.dao.ArticleDAO;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.TicketStatus;

/**
 *
 * @author jjhop
 */
@Controller
public class DesktopViewController {

    /**
     * Stała określająca liczbę wyświetlanych na biurku zdarzeń.
     */
    private static int NUMBER_OF_EVENTS_IN_DESKTOP = 5;

    /**
     * Stała określająca liczbę wyświetlanych na biurku
     * nowych i nieprzypisanych do nikogo zgłoszeń.
     */
    private static int NUMBER_OF_NONASSIGNED_TICKETS = 5;

    /**
     * Stała określająca liczbę wyświetalnych na biurku
     * ostatnio dodanych artykułów.
     */
    private static int NUMBER_OF_LAST_ADDED_ARTICLES = 5;

    /**
     * Stała określająca liczbę wyświetalnych na biurku 
     * ostatnio dodanych ogłoszeń.
     */
    private static int NUMBER_OF_LAST_ANNOUNCEMENTS = 5;

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private ArticleDAO articleDAO;

    @Autowired
    private AnnouncementDAO announcementDAO;

    /**
     *
     * @param map
     * @return
     * @throws Exception
     */
    @RequestMapping("/desktop/main.html")
    public String showDesktop(ModelMap map) throws Exception {
        fillLastTickets(map);
        fillLastEvent(map);
        fillLastArticles(map);
        fillLastAnnouncemenets(map);
        return "/desktop/main";
    }

    @RequestMapping("/desktop/lastTickets.html")
    public String lastTickets(ModelMap map) throws Exception {
        fillLastTickets(map);
        return "/desktop/lastTickets";
    }

    @RequestMapping("/desktop/lastEvents.html")
    public String lastEvents(ModelMap map) throws Exception {
        fillLastEvent(map);
        return "/desktop/lastEvents";
    }

    @RequestMapping("/desktop/lastArticles.html")
    public String lastArticles(ModelMap map) throws Exception {
        fillLastArticles(map);
        return "/desktop/lastArticles";
    }

    @RequestMapping("/desktop/lastAnnouncements.html")
    public String lastAnnouncements(ModelMap map) throws Exception {
        fillLastAnnouncemenets(map);
        return "/desktop/lastAnnouncements";
    }

    private void fillLastArticles(ModelMap map) throws Exception {
        map.addAttribute("lastArticles", articleDAO.getLastArticles(NUMBER_OF_LAST_ADDED_ARTICLES));
    }

    private void fillLastAnnouncemenets(ModelMap map) throws Exception {
        map.addAttribute("announcements", announcementDAO.getLastAnnouncements(NUMBER_OF_LAST_ANNOUNCEMENTS));
    }

    private void fillLastEvent(ModelMap map) throws Exception {
        map.addAttribute("lastEvents", ticketDAO.getLastEvents(NUMBER_OF_EVENTS_IN_DESKTOP));
    }

    private void fillLastTickets(ModelMap map) throws Exception {
        map.addAttribute("lastTickets", ticketDAO.getTicketsByStatus(TicketStatus.NOTIFIED, NUMBER_OF_NONASSIGNED_TICKETS));
    }
}
