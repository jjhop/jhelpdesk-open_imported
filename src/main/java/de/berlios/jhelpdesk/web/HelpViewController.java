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
package de.berlios.jhelpdesk.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import de.berlios.jhelpdesk.dao.ArticleCategoryDAO;
import de.berlios.jhelpdesk.dao.ArticleDAO;
import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.ArticleComment;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.search.LuceneIndexer;
import de.berlios.jhelpdesk.web.search.SearchException;
import de.berlios.jhelpdesk.web.tools.ArticleCommentValidator;

import static de.berlios.jhelpdesk.web.commons.PagingTools.*;

/**
 * Obsługa funkcji znajdujących się w menu "Pomoc" programu (w tym obsługa
 * przeglądania bazy wiedzy dzialu wsparcia).
 * 
 * @author jjhop
 */
@Controller
public class HelpViewController {

    private final static int NUM_OF_LAST_ADDED_ARTICLES = 10;

    private final static String HELP_INDEX = "help/index";
    private final static String HELP_ABOUT = "help/about";
    private final static String HELP_KB_INDEX = "help/base"; // zamienić na help/kb/index
    private final static String HELP_KB_CATEGORY = "help/kb/category";
    private final static String HELP_KB_ARTICLE = "help/base/one"; // zamienić na help/kb/one
    private final static String HELP_KB_SEARCH_RESULT = "help/kb/searchResult";

    private final static String HELP_KB_COMMENT_FORM = "/help/kb/comment/form";
    private final static String HELP_KB_COMMENT_RESULT = "/help/kb/comment/result";

    private final static String HELP_KB_TICKET_ASSIGN_FORM = "/help/kb/ticketAssign/form";
    private final static String HELP_KB_TICKET_ASSIGN_RESULT = "/help/kb/ticketAssign/result";
    private final static String HELP_KB_TICKET_SEARCH = "/help/base/articles/searchTickets";

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private ArticleDAO articleDAO;
    
    @Autowired
    private ArticleCategoryDAO articleCategoryDAO;

    @Autowired
    private ArticleCommentValidator validator;

    @Autowired
    private LuceneIndexer luceneIndexer;

    @Autowired
    private MessageSource ms;

    /**
     * Wyświetla pomoc do programu.
     * 
     * @return identyfikator widoku pomocy
     */
    @RequestMapping("/help/index.html")
    public String indexView() {
        return HELP_INDEX;
    }

    /**
     * Wyświetla stronę z informacjami o programie.
     *
     * @return identyfikator widoku z informacjami o programie
     */
    @RequestMapping("/help/about.html")
    public String aboutView() {
        return HELP_ABOUT;
    }

    /**
     * Obsługuje przeglądanie bazy wiedzy działu wsparcia.
     *
     * @param map model widoku
     * @return identyfikator widoku
     */
    @RequestMapping(value = "/help/kb/index.html", method = RequestMethod.GET)
    public String kBView(ModelMap map) throws Exception {
        map.addAttribute("categories", articleCategoryDAO.getAllCategories());
        map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
        return HELP_KB_INDEX;
    }

    @RequestMapping(value = "/help/kb/search.html", method = RequestMethod.GET)
    public String kBSearch(@RequestParam("query") String query, ModelMap map,
                           HttpSession session, Locale currentLocale) throws Exception {
        try {
            User currentUser = (User) session.getAttribute("user");
            List<Article> result = luceneIndexer.search(query, currentUser.getSearchResultLimit());
            map.addAttribute("result", result);
            if (result.size() < 1) {
                map.addAttribute("categories", articleCategoryDAO.getAllCategories());
                map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
                map.addAttribute("msg", ms.getMessage("kb.search.notfound.error", null, currentLocale));
                return HELP_KB_INDEX;
            }
        } catch(SearchException se) {
            map.addAttribute("categories", articleCategoryDAO.getAllCategories());
            map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
            map.addAttribute("msg", ms.getMessage("kb.search.string.format.error", null, currentLocale));
            return HELP_KB_INDEX;
        }
        return HELP_KB_SEARCH_RESULT;
    }

    @RequestMapping(value = "/help/base/category/{id}/show.html", method = RequestMethod.GET)
    public String kBCategoryView(@RequestParam(value="p",required=false,defaultValue="1") int page,
                                 @PathVariable("id") Long cId,  ModelMap map,
                                 HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("user");
        int pageSize = currentUser.getArticlesListSize();
        int articlesInSection = articleDAO.countForSection(cId);

        int offset = calculateOffset(pageSize, page);

        map.addAttribute("category", articleCategoryDAO.getById(cId));
        map.addAttribute("articles", articleDAO.getForSection(cId, pageSize, offset));
        map.addAttribute("currentPage", page);
        map.addAttribute("pages", calculatePages(articlesInSection, pageSize));
        map.addAttribute("offset", offset);
        return HELP_KB_CATEGORY;
    }

    /**
     * Wyświetla artykuł oznaczony w bazie wiedzy identyfikatorem {@code id}
     * 
     * @param id identyfikator artykułu do wyświetlenia
     * @param map model widoku
     * @return identyfikator widoku
     */
    @RequestMapping(value = "/help/base/articles/{aId}/show.html", method = RequestMethod.GET)
    public String kBItemView(@PathVariable("aId") Long id, ModelMap map) throws Exception {
        Article article = articleDAO.getById(id);
        if (article != null) {
            map.addAttribute("article", article);
        } else {
            map.addAttribute("message", "Nie znaleziono");
        }
        map.addAttribute("comment", new ArticleComment());
        return HELP_KB_ARTICLE;
    }

    @RequestMapping(value = "/help/base/articles/{aId}/comments/new.html", method = RequestMethod.GET)
    public String prepareCommentForm(@PathVariable("aId") Long articleId, ModelMap map) {
        map.addAttribute("comment", new ArticleComment());
        return HELP_KB_COMMENT_FORM;
    }

    @RequestMapping(value = "/help/base/articles/{aId}/comments/new.html", method = RequestMethod.POST)
    public String processCommentForm(@PathVariable("aId") Long articleId,
                                     @ModelAttribute("comment") ArticleComment comment,
                                     BindingResult errors, ModelMap map, HttpSession session) throws Exception {
        validator.validate(comment, errors);
        if (errors.hasErrors()) {
            map.addAttribute("comment", comment);
            return HELP_KB_COMMENT_FORM;
        }
        comment.setCreateDate(new Date());
        comment.setArticle(articleDAO.getById(articleId));
        comment.setAuthorId((User) session.getAttribute("user"));
        articleDAO.saveArticleComment(comment);
        return HELP_KB_COMMENT_RESULT;
    }

    @RequestMapping(value = "/help/base/articles/{aId}/tickets/new.html", method = RequestMethod.GET)
    public String prepareArticleTicketForm(@PathVariable("aId") Long articleId,
                                           @RequestParam(value = "tId", required = false) Long ticketId,
                                           ModelMap map) throws Exception {
        if (ticketId != null) {
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            if (ticket != null) {
                map.addAttribute("ticket", ticket);
            } else {
                map.addAttribute("message", "Nie znaleziono");
            }
        }
        map.addAttribute("articleId", articleId);
        return HELP_KB_TICKET_ASSIGN_FORM;
    }

    @RequestMapping(value = "/help/base/articles/{aId}/tickets/new.html", method = RequestMethod.POST)
    public String processArticleTicketForm(@PathVariable("aId") Long articleId,
                                           @RequestParam(value = "tId") Long ticketId) throws Exception {

        articleDAO.assignWithTicket(articleId, ticketId);
        // todo: co jeszcze?
        return HELP_KB_TICKET_ASSIGN_RESULT;
    }

    @RequestMapping("/help/base/articles/{aId}/searchTickets.html")
    public String searchTickets(@PathVariable("aId") Long articleId,
                                @RequestParam(value = "q", defaultValue = "") String query,
                                ModelMap map) throws Exception {
        map.addAttribute("article", articleDAO.getById(articleId));
        if (query.startsWith("#")) {
            try {
                long ticketId = Long.parseLong(query.substring(1));
                List<Ticket> result = new ArrayList<Ticket>();
                result.add(ticketDAO.getTicketById(ticketId));
                map.addAttribute("resultList", result);
                return HELP_KB_TICKET_SEARCH;
            } catch (Exception ex) {
                // todo: widok z informację, ze nic nie ma...
                return "jakisInnyWidok";
            }
        }

        int count = ticketDAO.countWithQuery(query);
        if (count > 0) {
            List<Ticket> result = ticketDAO.searchWithQuery(query);
            map.addAttribute("resultList", result);
            if (count > result.size()) {
                map.addAttribute("moreResultCount", count - result.size());
            }
        } else {
            // todo: widok z informację, ze nic nie ma...
            // return ....
        }
        return HELP_KB_TICKET_SEARCH;
    }
}
