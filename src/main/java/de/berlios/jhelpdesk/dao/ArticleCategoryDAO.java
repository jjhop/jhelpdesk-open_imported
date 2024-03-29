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

import de.berlios.jhelpdesk.model.ArticleCategory;

/**
 * Interfejs DAO dla obiektów ArticleCategory. Nieco rozszerzony ponad
 * standardowe operacje CRUD.
 *
 * @author jjhop
 *
 * @see ArticleCategory
 */
public interface ArticleCategoryDAO {

    /**
     * Zwraca listę wszystkich dostępnych kategorii. Zwracana lista zawsze
     * jest prawidłowym obiektem - nigdy {@code null}. Jeśli nie ma
     * żadnych kategorii zwracana jest pusta lista.
     *
     * @return lista obiektów ArticleCategory
     *
     * @see java.util.Collections#EMPTY_LIST
     */
    List<ArticleCategory> getAllCategories() throws DAOException;

    /**
     *
     * @param pageSize
     * @param offset
     * @return
     * @throws DAOException
     */
    List<ArticleCategory>  getCategories(int pageSize, int offset) throws DAOException;

    /**
     * 
     * @return
     * @throws DAOException
     */
    int countAll() throws DAOException;
    
    /**
     * Zwraca obiekt ArticleCategory na podstawie dostarczonego identyfikatora
     * lub {@code ull} jeśli w bazie nie ma obiektu z takim identyfikatorem.
     *
     * @param categoryId identyfikator oczekiwanego obiektu ArticleCategory
     * @return obiekt ArticleCategory lub {@code null} jeśli nie zostanie
     * znaleziony
     */
    ArticleCategory getById(Long categoryId) throws DAOException;

    /**
     * Usuwa wskazany obiekt ArticleCategory na podstawie dostarczonego
     * identyfikatora.
     * <p>UWAGA! Metoda ta usuwa również wszystkie artykuły z tej kategorii,
     * wszystkie komentarza do tych artykułow a także wszystkie powiązania
     * pomiędzy artykułami i zgłoszeniami. Należy ją stosować niezwykle
     * ostrożnie i zawsze ostrzegać użytkownika przed skutkami jej
     * zastosowania.</p>
     *
     * @param categoryId identyfikator obiektu ArticleCategory do usunięcia
     * @param categoryId
     */
    void delete(Long categoryId) throws DAOException;

    /**
     * Przenosi kategorię o podanym identyfikatorze o jedno miejsce w górę
     * w kolejności wyświetlania.
     *
     * @param categoryId identyfikator kategorii do przeniesienia
     *
     * @see #moveDown(java.lang.Long)
     */
    void moveUp(Long categoryId) throws DAOException;

    /**
     * Przenosi kategorię o podanym identyfikatorze o jedno miejsce w dół w
     * kolejności wyświetlania.
     *
     * @param categoryId identyfikator kategorii do przeniesienia
     *
     * @see #moveUp(java.lang.Long)
     */
    void moveDown(Long categoryId) throws DAOException;

    /**
     * Zapisuje lub uaktualnia podany obiekt ArticleCategory. Operacja do
     * wykonania wybierana jest na podstawie wartości
     * {@link ArticleCategory#id} dostarczonego obiektu. Jeśli
     * jest on równy {@code null} to obiekt zapisywany jest jako nowy a
     * identyfikator jest uzupełniany. Jeśli dostarczony obiekt posiada już
     * identyfikator({@code category.getArticleCategoryId() != null}) to w bazie
     * danych uaktualniane są jego dane.
     *
     * @param category obiekt ArticleCategory do zapisania (lub uaktualnienia)
     *
     * @see ArticleCategory
     */
    void saveOrUpdate(ArticleCategory category) throws DAOException;
}
