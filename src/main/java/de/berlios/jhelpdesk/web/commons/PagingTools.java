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
package de.berlios.jhelpdesk.web.commons;

/**
 * @author jjhop
 */
public class PagingTools {

    /**
     * Zwraca ilość stron przy podanych paramatrach.
     *
     * @param count ilość wszystkich obiektów
     * @param pageSize rozmiar strony
     * @return ilość stron
     */
    public static int calulatePages(int count, int pageSize) {
        return count > pageSize
                ? count / pageSize + (count % pageSize == 0 ? 0 : 1)
                : 1;
    }
}
