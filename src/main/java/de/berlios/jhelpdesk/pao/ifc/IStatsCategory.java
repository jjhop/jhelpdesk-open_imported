package de.berlios.jhelpdesk.pao.ifc;

import java.util.Map;

public interface IStatsCategory {
	// statystyki dla piechartów
	Map getStatsForCurrentWeek();
	Map getStatsForCurrentMonth();
	Map getStatsForThreePreviousMonths();
	Map getStatsForLastYear();
	Map getStatsForAll();	
}
