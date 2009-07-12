package de.berlios.jhelpdesk.dao;

import java.util.Date;
import java.util.List;

import de.berlios.jhelpdesk.model.Bug;
import de.berlios.jhelpdesk.model.BugEvent;
import de.berlios.jhelpdesk.model.EventType;
import de.berlios.jhelpdesk.model.User;

/**
 * 
 * @author jjhop
 *
*/
public interface BugEventDAO {

	/**
	 * 
	 * @param eventId
	 * @return
	*/
	public BugEvent getById( Long eventId );
	
	/**
	 * 
	 * @param user
	 * @return
	*/
	public List<BugEvent> getByUser( User user );
	
	/**
	 * 
	 * @param userId
	 * @return
	*/
	public List<BugEvent> getByUser( Long userId );
	
	/**
	 * 
	 * @param bug
	 * @return
	*/
	public List<BugEvent> getByBug( Bug bug );
	
	/**
	 * 
	 * @param bugId
	 * @return
	*/
	public List<BugEvent> getByBug( Long bugId );
	
	/**
	 * 
	 * @param type
	 * @return
	*/
	public List<EventType> getByType( EventType type );
	
	/**
	 * 
	 * @param date
	 * @return
	*/
	public List<BugEvent> getByDate( Date date );
	
	/**
	 * 
	 * @param from
	 * @param to
	 * @return
	*/
	public List<BugEvent> getByDate( Date from, Date to);
	
	/**
	 * 
	 * @param howMuch
	 * @return
	*/
	public List<BugEvent> getLastFewEvents( int howMuch );
	
	/**
	 * 
	 * @param event
	*/
	public void save( BugEvent event );
}