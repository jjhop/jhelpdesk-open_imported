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
package de.berlios.jhelpdesk.web.manager.ticketcategory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import de.berlios.jhelpdesk.dao.TicketCategoryDAO;
import de.berlios.jhelpdesk.model.TicketCategory;
import de.berlios.jhelpdesk.model.User;
import de.berlios.jhelpdesk.web.commons.PagingParamsEncoder;

/**
 *
 * @author jjhop
 */
@Controller
public class TicketCategoryController {

    @Autowired
    private TicketCategoryDAO categoryDAO;

    /**
     * 
     * @return
     */
    @RequestMapping("/manage/category/list.html")
    public String showAllCategories(HttpServletRequest request,
                                    HttpSession session, ModelMap map) throws Exception {
        User currentUser = (User) session.getAttribute("loggedUser");
        int pageSize = currentUser.getDefaultListSize();

        PagingParamsEncoder enc =
                new PagingParamsEncoder("c", null, request, pageSize);
        int offset = enc.getOffset();
        map.addAttribute("listSize", pageSize);
        map.addAttribute("offset", offset);
        map.addAttribute("categories", categoryDAO.getCategories(pageSize, offset));
        map.addAttribute("categoriesListSize", categoryDAO.countAll());
        return "manager/category/showAll";
    }

    /**
     * 
     * @param id
     * @param map
     * @return
     */
    @RequestMapping("/manage/category/{id}/show.html")
    public String showOneCategory(@PathVariable("id") Long id, ModelMap map) throws Exception {
        map.addAttribute("category", categoryDAO.getById(id));
        return "manager/categor/show";
    }

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping("/manage/category/{id}/remove.html")
    public String removeCategory(@PathVariable("id") Long id, ModelMap map) throws Exception {
        TicketCategory category = categoryDAO.getById(id);
        if (category.getTicketsCount() == 0) {
            categoryDAO.deleteCategory(category.getId());
            map.addAttribute("msg", "Kategoria została usunięta.");
        } else {
            map.addAttribute("msg", "Nie można usunąć kategorii ze zgłoszeniami.");
        }
        return "redirect:/manage/category/list.html";
    }

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping("/manage/category/{id}/up.html")
    public String moveUp(@PathVariable("id") Long id) throws Exception {
        categoryDAO.moveUp(id);
        return "redirect:/manage/category/list.html";
    }

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping("/manage/category/{id}/down.html")
    public String moveDown(@PathVariable("id") Long id) throws Exception {
        categoryDAO.moveDown(id);
        return "redirect:/manage/category/list.html";
    }
}
