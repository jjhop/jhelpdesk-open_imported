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

import java.io.BufferedInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.berlios.jhelpdesk.dao.ArticleDAO;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.dao.UserDAO;
import de.berlios.jhelpdesk.model.AdditionalFile;
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.Ticket;

import static de.berlios.jhelpdesk.web.commons.PagingTools.*;

/**
 *
 * @author jjhop
 */
@Controller
public class TicketDetailsController {

    private static final int PAGE_SIZE = 10;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private ArticleDAO articleDAO;

    @Autowired
    private AttachmentUtils attachmentUtils;

    @RequestMapping(value = "/tickets/{ticketId}/details.html", method = RequestMethod.GET)
    public String showTicket(@PathVariable("ticketId") Long ticketId,
                             ModelMap mav) throws Exception {
        Ticket ticket = ticketDAO.getTicketById(ticketId);
        mav.addAttribute("ticket", ticket);
        mav.addAttribute("ticketId", ticket.getTicketId());

        mav.addAllAttributes(processComments(ticketId, 1));
        mav.addAllAttributes(processEvents(ticketId, 1));
        mav.addAllAttributes(processAttachments(ticketId, 1));
        mav.addAllAttributes(processAssignedArticles(ticketId, 1));

        return "ticketDetails";
    }

    @RequestMapping(value = "/tickets/{ticketId}/articles/new.html", method = RequestMethod.GET)
    public String prepareTicketArticleForm(@PathVariable("ticketId") Long ticketId,
                                           @RequestParam(value = "aId", required = false) Long articleId,
                                           ModelMap map) throws Exception {
        if (articleId != null) {
            Article article = articleDAO.getById(articleId);
            if (article != null) {
                map.addAttribute("article", article);
            } else {
                map.addAttribute("message", "Nie znaleziono");
            }
        }
        map.addAttribute("ticketId", ticketId);
        return "/ticket/articles/assign/form";
    }

    @RequestMapping(value = "/tickets/{ticketId}/articles/new.html", method = RequestMethod.POST)
    public String processTicketArticleForm(@PathVariable("ticketId") Long ticketId,
                                           @RequestParam(value = "aId") Long articleId) throws Exception {
        articleDAO.assignWithTicket(articleId, ticketId);

        return "/ticket/articles/assign/result";
    }

    @RequestMapping("/tickets/{ticketId}/articles/search.html")
    public String searchTickets(@RequestParam(value = "q", defaultValue = "") String query,
                                @PathVariable("ticketId") Long ticketId, ModelMap map) throws Exception {

        map.addAttribute("ticketId", ticketId);
        if (query.startsWith("#")) {
            try {
                long articleId = Long.parseLong(query.substring(1));
                List<Article> result = new ArrayList<Article>();
                result.add(articleDAO.getById(articleId));
                map.addAttribute("resultList", result);
                return "/tickets/articles/searchArticles";
            } catch (Exception ex) {
                // todo: widok z informację, ze nic nie ma...
                return "jakisInnyWidok";
            }
        }
        int count = articleDAO.countWithQuery(query);
        if (count > 0) {
            List<Article> result = articleDAO.searchWithQuery(query);
            map.addAttribute("resultList", result);
            if (count > result.size()) {
                map.addAttribute("moreResultCount", count - result.size());
            }
        } else {
            // todo: widok z informację, ze nic nie ma...
            // return ....
        }
        return "/tickets/articles/searchArticles";
    }

    @RequestMapping(value = "/tickets/{ticketId}/comments.html", method = RequestMethod.GET)
    public String showComments(@PathVariable("ticketId") Long ticketId,
                               @RequestParam("page") Integer currentPage,
                               ModelMap mav) throws Exception {
        mav.addAllAttributes(processComments(ticketId, currentPage));
        mav.addAttribute("ticketId", ticketId);
        return "panelComments";
    }

    @RequestMapping(value = "/tickets/{ticketId}/events.html", method = RequestMethod.GET)
    public String showEvents(@PathVariable("ticketId") Long ticketId,
                             @RequestParam("page") Integer currentPage,
                             ModelMap mav) throws Exception {
        mav.addAllAttributes(processEvents(ticketId, currentPage));
        mav.addAttribute("ticketId", ticketId);
        return "panelEvents";
    }
    
    @RequestMapping(value = "/tickets/{ticketId}/attachments.html", method = RequestMethod.GET)
    public String showAttachments(@PathVariable("ticketId") Long ticketId, 
                                  @RequestParam("page") Integer currentPage,
                                  ModelMap map) throws Exception {
        map.addAllAttributes(processAttachments(ticketId, currentPage));
        map.addAttribute("ticketId", ticketId);
        return "panelAttachments";
    }
    
    @RequestMapping(value = "/tickets/{ticketId}/attachments/{attachmentId}/get.html", method = RequestMethod.GET)
    public void getAttachment(@PathVariable("attachmentId") Long attachmentId,
                              HttpServletResponse response) throws Exception {
        
        AdditionalFile addFile = ticketDAO.getAdditionalFileById(attachmentId);
        response.setContentType(addFile.getContentType());
        response.addHeader("Content-Disposition", "attachment; filename=\"" + addFile.getOriginalFileName() + "\"");
        response.setContentLength(addFile.getFileSize().intValue());

        ServletOutputStream outputStream = response.getOutputStream();
        BufferedInputStream inputStream = new BufferedInputStream(attachmentUtils.getInputStream(addFile));
        byte[] buffer = new byte[4096];
        while (inputStream.read(buffer) != -1) {
            outputStream.write(buffer);
            outputStream.flush();
        }
        inputStream.close();
        outputStream.close();
    }

    @RequestMapping(value = "/tickets/{ticketId}/articles.html", method = RequestMethod.GET)
    public String showArticles(@PathVariable("ticketId") Long ticketId,
                               @RequestParam("page") Integer page,
                               ModelMap map) throws Exception {
        map.addAttribute(processAssignedArticles(ticketId, page));
        map.addAttribute("ticketId", ticketId);
        return "panelAssignedArticles";
    }

    private Map<String, Object> processComments(Long ticketId, Integer currentPage) throws Exception {
        int commentsCount = ticketDAO.countCommentsForTicket(ticketId);
        int offset = calculateOffset(PAGE_SIZE, currentPage);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("commentsPages", calculatePages(commentsCount, PAGE_SIZE));
        result.put("currentCommentsPage", currentPage);
        result.put("comments", ticketDAO.getCommentsForTicket(ticketId, PAGE_SIZE, offset));
        return result;
    }

    private Map<String, Object> processEvents(Long ticketId, Integer currentPage) throws Exception {
        int eventsCount = ticketDAO.countEventsForTicket(ticketId);
        int offset = calculateOffset(PAGE_SIZE, currentPage);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("eventsPages", calculatePages(eventsCount, PAGE_SIZE));
        result.put("currentEventsPage", currentPage);
        result.put("events", ticketDAO.getEventsForTicket(ticketId, PAGE_SIZE, offset));
        return result;
    }
    
    private Map<String, Object> processAttachments(Long ticketId, Integer currentPage) throws Exception {
        int attachmentsCount = ticketDAO.countAttachmentsForTicket(ticketId);
        int offset = calculateOffset(PAGE_SIZE, currentPage);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("attachmentsPages", calculatePages(attachmentsCount, PAGE_SIZE));
        result.put("currentAttachmentsPage", currentPage);
        result.put("attachments", ticketDAO.getAttachmentsForTicket(ticketId, PAGE_SIZE, offset));
        return result;
    }

    public Map<String, Object> processAssignedArticles(Long ticketId, Integer currentPage) throws Exception {
        int kbArticlesCount = ticketDAO.countAssignedArticlesForTicket(ticketId);
        int offset = calculateOffset(PAGE_SIZE, currentPage);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("kbArticlesPages", calculatePages(kbArticlesCount, PAGE_SIZE));
        result.put("currentKBArticlesPage", currentPage);
        result.put("kbArticles", ticketDAO.getAssignedArticlesForTicket(ticketId, PAGE_SIZE, offset));
        return result;
    }
}
