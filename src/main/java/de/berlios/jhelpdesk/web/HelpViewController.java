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

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import de.berlios.jhelpdesk.model.Article;
import de.berlios.jhelpdesk.model.ArticleComment;
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

    @Autowired
    private ArticleDAO articleDAO;
    
    @Autowired
    private ArticleCategoryDAO articleCategoryDAO;

    @Autowired
    private ArticleCommentValidator validator;

    @Autowired
    private LuceneIndexer luceneIndexer;

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
                           HttpSession session) throws Exception {
        try {
            User currentUser = (User) session.getAttribute("user");
            List<Article> result = luceneIndexer.search(query, currentUser.getSearchResultLimit());
            map.addAttribute("result", result);
            if (result.size() < 1) {
                map.addAttribute("categories", articleCategoryDAO.getAllCategories());
                map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
                map.addAttribute("msg", "Nic nie znaleziono..."); // TODO: i18n
                return HELP_KB_INDEX;
            }
        } catch(SearchException se) {
            map.addAttribute("categories", articleCategoryDAO.getAllCategories());
            map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
            map.addAttribute("msg", "Niewłaściwy format łańucha wyszukiwania."); // TODO: i18n
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

    @RequestMapping(value = "/help/base/articles/{aId}/show.html", method = RequestMethod.POST)
    public String kBAddComment(@PathVariable("aId") Long articleId,
                               @ModelAttribute("comment") ArticleComment comment, 
                               BindingResult errors, ModelMap map,
                               HttpSession session) throws Exception {

        comment.setCreateDate(new Date());
        comment.setArticle(articleDAO.getById(articleId));
        comment.setAuthorId((User) session.getAttribute("user"));
        validator.validate(comment, errors);
        if (errors.hasErrors()) {
            map.addAttribute("article", articleDAO.getById(articleId));
            map.addAttribute("comment", comment);
            return HELP_KB_ARTICLE;
        }
        articleDAO.saveArticleComment(comment);
        return "redirect:/help/base/articles/" + articleId + "/show.html#c" + comment.getId();
    }
}
