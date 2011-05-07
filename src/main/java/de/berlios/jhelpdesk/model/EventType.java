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
 * Typ zdarzenia związanego z <i>życiem</i> zgłoszenia w systemie.
 * 
 * @author jjhop
 *
 * @see Ticket
 * @see TicketEvent
 */
public enum EventType {

    /**
     * 
     */
    CREATE(1, "eventType.create"), // page_add

    /**
     *
     */
    ASSIGN(2, "eventType.assign"), // page_go

    /**
     *
     */
    REASSIGN(3, "eventType.reassign"), // page_refresh

    /**
     *
     */
    CLOSE(4, "eventType.close"), // page_green

    /**
     *
     */
    REJECT(5, "eventType.reject"), // page_delete

    /**
     * 
     */
    CATEGORYCHANGE(6, "eventType.categoryChange"), // page_code

    /**
     *
     */
    PRIORITYCHANGE(7, "eventType.priorityChange"),  // page_lightning

    /**
     *
     */
    STATUSCHANGE(8, "eventType.statusChange"), // page_gear

    /**
     *
     */
    COMMENTADD(9, "eventType.commentAdd"), // page_paintbrush
    
    /**
     * 
     */
    ATTACHMENTADD(10, "eventType.attachmentAdd"); // page_attach

    /**
     * Liczbowy identyfikator zdarzenia. Za jego pomocą można
     * zapisywać je w bazie danych.
     */
    private final int code;

    /**
     * Nazwa zdarzenia.
     */
    private final String eventNameCode;

    /**
     * Konstruktor tworzący zdarzenie za pomocą podanego kodu liczbowego oraz
     * nazwy.
     * 
     * @param code kod liczbowy, identyfikator zdarzenia
     * @param eventNameCode nazwa zdarzenia
     * 
     * @see #code
     * @see #eventNameCode
     */
    private EventType(int code, String eventNameCode) {
        this.code = code;
        this.eventNameCode = eventNameCode;
    }

    /**
     * Zwraca liczbową reprezentację typu zdarzenia. Na jej podstawie można
     * bezpiecznie odtworzyć type za pomocą {@link #fromInt(int)}.
     * 
     * @return liczbowa reprezentacja zdarzenia
     * 
     * @see #code
     */
    public int toInt() {
        return code;
    }

    /**
     * Zwraca nazwę zdarzenia. Nazwa jest ustalana podczas tworzenia obiektu.
     * 
     * @return nazwa zdarzenia
     *
     * @see #eventNameCode
     */
    public String getTypeName(Locale locale) {
        ResourceBundle names = ResourceBundle.getBundle("eventType", locale);
        return names.getString(eventNameCode);
    }
    
    /**
     * <p>
     * Odtwarza typ zdarzenia z podanego identyfikatora. Identyfikator musi mieć
     * wartość ze z góry ustalonego zbioru. Dla każdej inne wartości zgłasza
     * wyjątek RuntimeException.
     * </p>
     * <p>
     * W bazie danych spójność powinna być zachowana poprzez zdefiniowanie
     * domeny z odpowiednimi wartościami lub zastosowanie mechanizmu sprawdzanai
     * wartości przed zapisaniem zdarzenia za pomocą CHECK lub TRIGGERa.
     * </p>
     * 
     * @param code identyfikator zdarzenia
     * @return prawidłowy obiekt zdarzenia
     * @throws RuntimeException jesli podana liczba jest spoza spodziewanego zbioru
     * 
     * @see #code
     * @see #toInt()
     * @see TicketEvent
     */
    public static EventType fromInt(int code) {
        switch (code) {
            case 1:
                return CREATE;
            case 2:
                return ASSIGN;
            case 3:
                return REASSIGN;
            case 4:
                return CLOSE;
            case 5:
                return REJECT;
            case 6:
                return CATEGORYCHANGE;
            case 7:
                return PRIORITYCHANGE;
            case 8:
                return STATUSCHANGE;
            case 9:
                return COMMENTADD;
            default:
                throw new RuntimeException("Nieznany typ zdarzenia.");
        }
    }

    /**
     * Zwraca łańcuchową reprezentację typu zdarzenia.
     *
     * @return łańcuchowa reprezentacja typu zdarzenia
     *
     * @see #eventNameCode
     */
    @Override
    public String toString() {
        return eventNameCode;
    }
}
