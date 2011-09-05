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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author jjhop
 */
public enum TicketPriority {

    /**
     *
     */
    CRITICAL(1, "ticketPriority.critical"),

    /**
     *
     */
    MAJOR(2, "ticketPriority.major"),

    /**
     *
     */
    IMPORTANT(3, "ticketPriority.important"),

    /**
     *
     */
    NORMAL(4, "ticketPriority.normal"),

    /**
     *
     */
    LOW(5, "ticketPriority.low");

    private static final Logger log = LoggerFactory.getLogger(TicketPriority.class);

    private static final List<TicketPriority> ps;

    static {
        ps = new ArrayList<TicketPriority>();
        ps.add(TicketPriority.LOW);
        ps.add(TicketPriority.NORMAL);
        ps.add(TicketPriority.IMPORTANT);
        ps.add(TicketPriority.MAJOR);
        ps.add(TicketPriority.CRITICAL);
    }

    /**
     *
     */
    private final int priorityId;

    /**
     *
     */
    @Deprecated
    private final String priorityName;

    private final String priorityNameCode;

    /**
     * 
     * @param id
     * @param priorityNameCode
     */
    private TicketPriority(int id, String priorityNameCode) {
        this.priorityId = id;
        this.priorityName = priorityNameCode;
        this.priorityNameCode = priorityNameCode;
    }

    /**
     * 
     * @return
     */
    @Deprecated
    public int getPriorityId() {
        return this.priorityId;
    }

    /**
     *
     * @return
     */
    @Deprecated
    public String getPriorityName() {
        return this.priorityName;
    }

    public String getPriorityName(Locale locale) {
        ResourceBundle names = ResourceBundle.getBundle("priorityName", locale);
        return names.getString(priorityNameCode);
    }

    /**
     *
     * @return
     */
    public int toInt() {
        return this.priorityId;
    }

    /**
     *
     * @param id
     * @return
     */
    public static TicketPriority fromInt(int id) {
        for (TicketPriority value : TicketPriority.values()) {
            if (value.toInt() == id) {
                return value;
            }
        }
        throw new IllegalArgumentException("Wartosc spoza zakresu. Dostepne wartosci to: 1, 2, 3, 4, 5");
    }

    public static List<TicketPriority> listFromString(String inputString) {
        List<TicketPriority> resultList = new ArrayList<TicketPriority>();
        if (inputString != null) {
            for (String priorityId : inputString.split(",")) {
                try {
                    resultList.add(TicketPriority.fromInt(Integer.parseInt(priorityId)));
                } catch(NumberFormatException nfe) {
                    log.debug(nfe.getMessage());
                }
            }
        }
        return resultList;
    }

    public static String listAsString(List<TicketPriority> inputList) {
        StringBuilder tpBuf = new StringBuilder("");
        if (inputList != null) {
            for (Iterator<TicketPriority> it = inputList.iterator(); it.hasNext();) {
                tpBuf.append(it.next().toInt());
                if (it.hasNext()) {
                    tpBuf.append(",");
                }
            }
        }
        return tpBuf.toString();
    }

    public static List<TicketPriority> getPriorities() {
        return Collections.unmodifiableList(ps);
    }
}
