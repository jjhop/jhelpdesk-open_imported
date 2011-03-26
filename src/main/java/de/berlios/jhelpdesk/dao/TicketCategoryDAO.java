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
package de.berlios.jhelpdesk.dao;

import java.util.List;

import de.berlios.jhelpdesk.model.TicketCategory;

/**
 * 
 * @author jjhop
 */
public interface TicketCategoryDAO {

    /**
     *
     * @return
     */
    List<TicketCategory> getAllCategories() throws DAOException;

    /**
     * 
     * @param pageSize
     * @param page
     * @return
     * @throws DAOException
     */
    List<TicketCategory> getCategories(int pageSize, int page) throws DAOException;
    
    /**
     * 
     * @return
     */
    List<TicketCategory> getAllCategoriesForView() throws DAOException;

    /**
     *
     * @param id
     * @return
     */
    TicketCategory getById(Long id) throws DAOException;

    /**
     * Zwraca domyślną kategorię dla zgłoszeń, który nie nadano jej wprost.
     * (np. zgłoszenia wysłane emailem). W domyślnej instalacji pierwsza kategoria,
     * jest kategorią domyślną. Jeśli takiej kategorii nie ma to odpowiedni mechanizm,
     * próbuje wyszukać najbardziej odpowiednią dla danego problemu.
     *
     * @return domyślna kategoria
     */
    TicketCategory getDefault() throws DAOException;

    /**
     *
     * @param category
     */
    void deleteCategory(TicketCategory category) throws DAOException;

    /**
     *
     * @param category
     */
    void updateCategory(TicketCategory category) throws DAOException;

    /**
     * 
     * @param category
     */
    void save(TicketCategory category);

    int countAll() throws DAOException;

    void moveUp(Long id) throws DAOException;
    
    void moveDown(Long id) throws DAOException;

}
