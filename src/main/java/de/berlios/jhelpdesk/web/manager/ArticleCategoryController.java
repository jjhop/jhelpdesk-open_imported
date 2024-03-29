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

import de.berlios.jhelpdesk.dao.ArticleCategoryDAO;
import de.berlios.jhelpdesk.model.ArticleCategory;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.commons.PagingParamsEncoder;
import de.berlios.jhelpdesk.web.tools.ArticleCategoryValidator;

@Controller
public class ArticleCategoryController {

    private static final Logger log = LoggerFactory.getLogger(ArticleCategoryController.class);

    private final static String MANAGE_KB_CATEGORY_LIST_RDR = "redirect:/manage/kb/categories/list.html";
    private final static String MANAGE_KB_CATEGORY_LIST = "manager/knowledge/category/showAll";
    private final static String MANAGE_KB_CATEGORY_EDIT = "manager/knowledge/category/edit";

    @Autowired
    private ArticleCategoryValidator validator;

    @Autowired
    private ArticleCategoryDAO categoryDAO;

    @RequestMapping("/manage/kb/categories/list.html")
    public String showAll(HttpServletRequest request, HttpSession session,
                          ModelMap map) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        int pageSize = currentUser.getDefaultListSize();

        PagingParamsEncoder enc =
                new PagingParamsEncoder("c", null, request, pageSize);
        int offset = enc.getOffset();

        map.addAttribute("listSize", pageSize);
        map.addAttribute("offset", offset);
        map.addAttribute("categories", categoryDAO.getCategories(pageSize, offset));
        map.addAttribute("categoriesListSize", categoryDAO.countAll());
        return MANAGE_KB_CATEGORY_LIST;
    }

    @RequestMapping("/manage/kb/category/{id}/remove.html")
    public String processRemove(@PathVariable("id") Long categoryId, ModelMap map) {
        try {
            ArticleCategory category = categoryDAO.getById(categoryId);
            if (category.getArticlesCount() > 0) {
                // todo: i18n dla komunikatu
                map.addAttribute("message", "Nie można usunąć kategorii, w której sa artykuły");
                // tutaj warto przejść na jakis widok z komunikatem
            } else {
                categoryDAO.delete(categoryId);
            }
        } catch (Exception ex) {
            log.error(ex.getMessage());
        }
        return MANAGE_KB_CATEGORY_LIST_RDR;
    }

    @RequestMapping("/manage/kb/category/{cId}/up.html")
    public String moveUp(@PathVariable("cId") Long categoryId) {
        try {
            categoryDAO.moveUp(categoryId);
        } catch (Exception ex) {
            log.error(ex.getMessage());
        }
        return MANAGE_KB_CATEGORY_LIST_RDR;
    }

    @RequestMapping("/manage/kb/category/{cId}/down.html")
    public String moveDown(@PathVariable("cId") Long categoryId) {
        try {
            categoryDAO.moveDown(categoryId);
        } catch (Exception ex) {
            log.error(ex.getMessage());
        }
        return MANAGE_KB_CATEGORY_LIST_RDR;
    }

    @RequestMapping(value = "/manage/kb/category/new.html", method = RequestMethod.GET)
    public String prepareForm(ModelMap map) throws Exception {
        map.addAttribute("category", new ArticleCategory());
        return MANAGE_KB_CATEGORY_EDIT;
    }

    @RequestMapping(value = "/manage/kb/category/{cId}/edit.html", method = RequestMethod.GET)
    public String prepareForm(@PathVariable("cId") Long cId, ModelMap map) throws Exception {
        map.addAttribute("category", categoryDAO.getById(cId));
        return MANAGE_KB_CATEGORY_EDIT;
    }

    @RequestMapping(value = "/manage/kb/category/save.html", method = RequestMethod.POST)
    public String processSubmit(@ModelAttribute("category") ArticleCategory category,
                                BindingResult result, ModelMap map) throws Exception {
        validator.validate(category, result);
        if (result.hasErrors()) {
            map.addAttribute("category", category);
            return MANAGE_KB_CATEGORY_EDIT;
        }
        categoryDAO.saveOrUpdate(category);
        return "redirect:/manage/kb/category/" + category.getId() + "/articles.html";
    }
}
