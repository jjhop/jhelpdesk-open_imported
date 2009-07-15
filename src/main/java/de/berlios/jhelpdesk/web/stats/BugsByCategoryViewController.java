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
package de.berlios.jhelpdesk.web.stats;

import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import de.berlios.jhelpdesk.pao.StatsCategoryPAO;
import de.berlios.jhelpdesk.web.charts.BugStatsByCategoryDatasetProducer;
import de.berlios.jhelpdesk.web.charts.BugsStatsByCategoryFullDatasetProducer;
import de.berlios.jhelpdesk.web.charts.category.Vertical3DChartCategoryDatasetProducer;

@Controller("bugsByCategoryStatsViewController")
public class BugsByCategoryViewController {

    @Autowired
    private StatsCategoryPAO statsPAO;

    @RequestMapping
    public String handleRequest(ModelMap map) {
        TreeMap<String, Long> currentWeekMap = new TreeMap<String, Long>(statsPAO.getStatsForCurrentWeek());
        TreeMap<String, Long> currentMonthMap = new TreeMap<String, Long>(statsPAO.getStatsForCurrentMonth());
        TreeMap<String, Long> threeMonthsMap = new TreeMap<String, Long>(statsPAO.getStatsForThreePreviousMonths());
        Map<String, Long> allMap = rebuildMap(statsPAO.getStatsForAll(), 9);

        map.addAttribute("currentWeekData", currentWeekMap);
        map.addAttribute("currentMonthData", currentMonthMap);
        map.addAttribute("threeMonthsData", threeMonthsMap);
        map.addAttribute("allData", allMap);

        map.addAttribute("currentWeek", new BugStatsByCategoryDatasetProducer(currentWeekMap));
        map.addAttribute("currentWeekDayByDayData", new Vertical3DChartCategoryDatasetProducer(currentWeekMap));

        map.addAttribute("currentMonth", new BugStatsByCategoryDatasetProducer(currentMonthMap));
        map.addAttribute("currentMonthWeekByWeekData", new Vertical3DChartCategoryDatasetProducer(currentWeekMap));

        map.addAttribute("threeMonths", new BugStatsByCategoryDatasetProducer(threeMonthsMap));
        map.addAttribute("threeMonthsMonthByMonth", new Vertical3DChartCategoryDatasetProducer(threeMonthsMap));

        map.addAttribute("allTime", new BugStatsByCategoryDatasetProducer(allMap));
        map.addAttribute("allTimeFull", new BugsStatsByCategoryFullDatasetProducer(allMap));
        return "stats/bugsByCategory";
    }

    private static Map<String, Long> rebuildMap(Map<String, Long> entryMap, int maxSize) {
        Map<String, Long> newMapToReturn = new LinkedHashMap<String, Long>();

        SortedSet<Entry<String, Long>> ss = new TreeSet<Entry<String, Long>>(new CustomComparator());
        ss.addAll(entryMap.entrySet());
        int count = 0;
        long otherSum = 0;

        for (Iterator<Entry<String, Long>> it = ss.iterator(); it.hasNext(); count++) {
            Entry<String, Long> entry = it.next();
            if (count < maxSize) {
                newMapToReturn.put(entry.getKey(), entry.getValue());
            } else {
                otherSum += entry.getValue();
            }
        }
        if (count > maxSize) {
            newMapToReturn.put("Pozostałe...", otherSum);
        }

        return newMapToReturn;
    }

    private static class CustomComparator implements Comparator<Entry<String, Long>> {

        public int compare(Entry<String, Long> o1, Entry<String, Long> o2) {
            return o2.getValue().compareTo(o1.getValue());
        }
    }
}
