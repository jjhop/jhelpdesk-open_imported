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
package de.berlios.jhelpdesk.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 
 * @author jjhop
 */
public class DateUtil {

    private Date target;
    private Calendar cal = Calendar.getInstance();
    private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    private static long MILLIS_IN_WEEK = 60480000;

    public DateUtil() {
        target = new Date();
    }

    public DateUtil(String dateToParse) {
        try {
            target = formatter.parse(dateToParse);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public DateUtil(Date date) {
        target = date;
    }

    public static boolean isOlderThankWeek(Date date) {
        long millisFromDate = System.currentTimeMillis() - date.getTime();
        return millisFromDate > MILLIS_IN_WEEK;
    }

    public String getWeekStartDate() {
        cal.setTime(target);
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        return formatter.format(cal.getTime());
    }

    public String getWeekEndDate() {
        cal.setTime(target);
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) + 6);
        return formatter.format(cal.getTime());
    }

    public String getMonthStartDate() {
        cal.setTime(target);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        return formatter.format(cal.getTime());
    }

    public String getMonthEndDate() {
        cal.setTime(target);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        return formatter.format(cal.getTime());
    }

    public String getXMonthsEarlierDate(int months) {
        cal.setTime(target);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.roll(Calendar.MONTH, - months);
        return formatter.format(cal.getTime());
    }

    public String getPreviousMonthLastDayDate() {
        cal.setTime(target);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.roll(Calendar.MONTH, -1);
        cal.roll(Calendar.DAY_OF_MONTH, -1);
        return formatter.format(cal.getTime());
    }
}
