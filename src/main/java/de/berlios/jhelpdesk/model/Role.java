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
package de.berlios.jhelpdesk.model;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * <p>
 * Role użytkowników w systemie. Dla wygody programisty zawiera statyczne
 * wartości dla wszystkich ról oraz metody pozwalające na wygodne używanie 
 * jej obiektów (np. zapisywanie ról w bazie za pomocą liczb i odtwarzenie
 * tychże z zapisanych liczba - szczegóły w dokumentacji poszczególnych metod).
 * </p>
 * 
 * @author jjhop
 */
public enum Role {

    /**
     * Rola CLIENT. Użytkownik w tej roli może przede wszystkim zgłaszać błędy. Może także
     * w ograniczony sposób korzystać z pozostałych części systemu, nie może jednak edytować
     * nic poza częścią swoich danych osobowych.
     */
    CLIENT(1, "role.client"),
    
    /**
     * Rola TICKETKILLER. Uzytkownik w tej roli może zgłaszać problemy w swoim imieniu, oraz
     * w imieniu innych użytkowników. Może także w pewnym zakresie edytować zgłoszenia
     * (np. przypisywać je do rozwiązania przez siebie ale nie przez innych użytkowników).
     * Może także edytować wiele innych elementów systemu.
     */
    TICKETKILLER(10, "role.ticketkiller"),

    /**
     * Rola MANAGER. Użytkownik z nieograniczonymi uprawnieniami w systemie. Może zmieniać role
     * innych użytkowników, przypisywać zgłoszenia do rozwiązania przez dowolnego użytkownika
     * z rolą TICKETKILLER. W pełni może edytować wszystkie obiekty w systemie.
     */
    MANAGER(100, "role.manager");

    /**
     * Liczba, za pomocą której rola może być przedstawiana w bazie danych.
     */
    private final int code;

    /**
     * Nazwa roli.
     */
    private final String roleName;

    /**
     * <p>
     * Odtwarza rolę z podanego identyfikatora. Identyfikator musi mieć wartość jedną z trzech:
     * 1, 10 lub 100. Dla każdej innej wartości zgłasza wyjątk RuntimeException.
     * </p>
     * <p>
     * W bazie danych spójność powinna być zachowywana poprzez zdefiniowanie domeny z podanymi
     * wartościami lub zastosowanie mechanizmu sprawdzania wartości przed zapisaniem użytkownika
     * za pomocą CHECK lub TRIGGERa.
     * </p>
     * @param code identyfikator roli
     * @return prawidłowy obiekt Role
     * @throws RuntimeException jeśli podana liczba ma wartość inną niż 1, 10, lub 100
     *
     * @see #code
     * @see #getRoleCode()
     * @see User
     */
    public static Role fromInt(int code) {
        switch (code) {
            case 1:
                return CLIENT;
            case 10:
                return TICKETKILLER;
            case 100:
                return MANAGER;
            default:
                throw new RuntimeException("Nieznana rola. [" + code + "]");
        }
    }

    /**
     * Tworzy rolę na podstawie podanego identyfikatora i nazwy.
     * 
     * @param code identyfikator roli
     * @param roleName nazwa roli
     */
    private Role(int code, String roleName) {
        this.code = code;
        this.roleName = roleName;
    }

    /**
     * Zwraca liczbową reprezenację roli. Zwrócona liczba jest identyfikatorem roli.
     * Na jej podstawie można bezpieczenie odtworzyć role za pomocą {@link #fromInt(int)}.
     *
     * @return liczbowa reprezentacja roli
     *
     * @see #code
     * @see #getRoleCode()
     */
    public int toInt() {
        return this.getRoleCode();
    }

    /**
     * Zwraca nazwę roli. Nazwa jest ustalana podczas tworzenia roli.
     *
     * @return zlokalizowana nazwa roli
     * 
     * @see #roleName
     */
    public String getRoleName(Locale locale) {
        ResourceBundle names = ResourceBundle.getBundle("role", locale);
        return names.getString(roleName);
    }

    /**
     * Zwraca identyfikator roli. Na podstawie identyfikatora można bezpiecznie odtwarzać 
     * role za pomocą {@link #fromInt(int)}.
     *
     * @return identyfikator roli
     *
     * @see #code
     * @see #toInt()
     */
    public int getRoleCode() {
        return code;
    }
}
