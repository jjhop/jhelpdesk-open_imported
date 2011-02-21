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

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
    private final static String HELP_KB_ARTICLE = "help/base/one";
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
    public String knowledgeBaseView(ModelMap map) {
        map.addAttribute("categories", articleCategoryDAO.getAllCategories());
        map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
        return HELP_KB_INDEX;
    }

    @RequestMapping(value = "/help/kb/search.html", method = RequestMethod.GET)
    public String knowledgeBaseSearch(@RequestParam("query") String query, ModelMap map) {
        try {
            map.addAttribute("result", luceneIndexer.search(query));
        } catch(SearchException se) {
            map.addAttribute("categories", articleCategoryDAO.getAllCategories());
            map.addAttribute("latest", articleDAO.getLastArticles(NUM_OF_LAST_ADDED_ARTICLES));
            map.addAttribute("msg", "Niewłaściwy format łańucha wyszukiwania."); // TODO: i18n
            return HELP_KB_INDEX;
        }
        return HELP_KB_SEARCH_RESULT;
    }

    /**
     * Wyświetla artykuł oznaczony w bazie wiedzy identyfikatorem {@code id}
     * 
     * @param id identyfikator artykułu do wyświetlenia
     * @param map model widoku
     * @return identyfikator widoku
     */
    @RequestMapping(value = "/help/base/articles/{aId}/show.html", method = RequestMethod.GET)
    public String knowledgeBaseItemView(@PathVariable("aId") Long id, ModelMap map) {
        Article article = articleDAO.getById(id);
        if (article != null) {
            map.addAttribute("article", article);
        } else {
            map.addAttribute("message", "Nie znaleziono");
        }
        return HELP_KB_ARTICLE;
    }

    @RequestMapping(value = "/help/base/articles/{aId}/show.html", method = RequestMethod.POST)
    public String knowledgeBaseAddComment(@PathVariable("aId") Long articleId,
                                          @RequestParam("title") String title,
                                          @RequestParam("comment") String body,
                                          ModelMap map, HttpSession session) throws Exception {

        // tutaj jeszcze walidacja i jak jest do dupy to HELP_KB_ARTICLE
        // w przeciwnym wypadku redirect "/help/base/articles/" + articleId + "/show.html"
        ArticleComment comment = new ArticleComment();
        comment.setCreateDate(new Date());
        comment.setArticle(articleDAO.getById(articleId));
        comment.setTitle(title);
        comment.setBody(body);
        comment.setAuthorId((User) session.getAttribute("user"));
//        validator.validate(comment, null);
        articleDAO.saveArticleComment(comment);
        map.addAttribute("article", articleDAO.getById(articleId));
        return HELP_KB_ARTICLE;
    }
}
