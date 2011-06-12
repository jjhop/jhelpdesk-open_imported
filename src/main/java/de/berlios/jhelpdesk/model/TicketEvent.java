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

import java.io.Serializable;
import java.util.Date;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.PostLoad;
import javax.persistence.PrePersist;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * @author jjhop
 */
 @Entity
@Table(name = "ticket_event")
@SequenceGenerator(name = "ticket_event_sequence", sequenceName = "ticket_event_id_seq", allocationSize = 1)
@NamedQueries({
    @NamedQuery(name = "TicketEvent.getByTicketOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.ticket=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "SELECT t TicketEvent.getByTicketIdOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.ticket.ticketId=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.getByEventTypeOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.eventTypeAsInt=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.getByUserOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.evtAuthor=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.getByUserIdOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.evtAuthor.userId=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.getLastFewEventsOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.getEventsForTicketOrderByEventDateDESC",
                query = "SELECT t FROM TicketEvent t WHERE t.ticket.ticketId=?1 ORDER BY t.evtDate DESC"),
    @NamedQuery(name = "TicketEvent.countEventsForTicket", query = "SELECT COUNT(evt) FROM TicketEvent evt WHERE evt.ticket.ticketId=?1")
})
public class TicketEvent implements Serializable {

    private static final long serialVersionUID = 357930254796886251L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="ticket_event_sequence")
    @Column(name = "id")
    private Long ticketEventId;

    @ManyToOne
    @JoinColumn(name="ticket_id")
    private Ticket ticket;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "event_date")
    private Date evtDate;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    private User evtAuthor;

    @Column(name = "event_data")
    private String eventData;

    /**
     * @see #eventTypeAsInt
     * @see #populateEventTypeDB()
     * @see #populateEventTypeTransient()
     */
    @Transient
    private EventType eventType;

    /**
     * Pole służące do utrwalania w bazie typu zdarzenia. Niedostępne
     * za pomocą żadnych metod i używane tylko przez JPA.
     *
     * @see #populateEventTypeDB()
     * @see #populateEventTypeTransient()
     */
    @Basic
    @Column(name = "event_type")
    @SuppressWarnings("unused")
    private int eventTypeAsInt;

    public static TicketEvent ticketCreated(Ticket ticket) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.CREATE);
        event.setEvtAuthor(ticket.getInputer());
        event.setEvtDate(new Date());
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketAssigned(Ticket ticket, User assigner) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.ASSIGN);
        event.setEvtAuthor(assigner);
        event.setEvtDate(new Date());
        event.setEventData(assigner);
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketAssigned(Ticket ticket, User saviour, User assigner) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.ASSIGN);
        event.setEvtAuthor(assigner);
        event.setEvtDate(new Date());
        event.setEventData(saviour);
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketReassigned(Ticket ticket, User assigner) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.REASSIGN);
        event.setEvtAuthor(assigner);
        event.setEvtDate(new Date());
        event.setEventData(assigner);
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketReassigned(Ticket ticket, User saviour, User assigner) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.REASSIGN);
        event.setEvtAuthor(assigner);
        event.setEvtDate(new Date());
        event.setEventData(saviour);
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketResolved(Ticket ticket, User user) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.RESOLVE);
        event.setEvtAuthor(user);
        event.setEvtDate(new Date());
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketRejected(Ticket ticket, User user) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.REJECT);
        event.setEvtAuthor(user);
        event.setEvtDate(new Date());
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent ticketReopened(Ticket ticket, User user) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.REOPEN);
        event.setEvtAuthor(user);
        event.setEvtDate(new Date());
        event.setTicket(ticket);
        return event;
    }

    public static TicketEvent commentAdded(TicketComment comment) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.COMMENTADD);
        event.setEvtAuthor(comment.getCommentAuthor());
        event.setEvtDate(new Date());
        event.setTicket(comment.getTicket());
        return event;
    }
    
    public static TicketEvent attachmentAdded(AdditionalFile addFile) {
        TicketEvent event = new TicketEvent();
        event.setEventType(EventType.ATTACHMENTADD);
        event.setEvtAuthor(addFile.getCreator());
        event.setEvtDate(new Date());
        event.setEventData(addFile);
        event.setTicket(addFile.getTicket());
        return event;
    }

    /**
     * @return Returns the ticketEventId.
     */
    public Long getTicketEventId() {
        return ticketEventId;
    }

    /**
     * @param ticketEventId The ticketEventId to set.
     */
    public void setTicketEventId(Long ticketEventId) {
        this.ticketEventId = ticketEventId;
    }

    /**
     * @return Returns the evtAuthor.
     */
    public User getEvtAuthor() {
        return evtAuthor;
    }

    /**
     * @param evtAuthor The evtAuthor to set.
     */
    public void setEvtAuthor(User evtAuthor) {
        this.evtAuthor = evtAuthor;
    }

    /**
     * @return Returns the evtDate.
     */
    public Date getEvtDate() {
        return evtDate;
    }

    /**
     * @param evtDate The evtDate to set.
     */
    public void setEvtDate(Date evtDate) {
        this.evtDate = evtDate;
    }

    public void setEventData(Object data) {
        if (data instanceof User) {
            this.eventData = ((User)data).getFullName();
        } else if (data instanceof AdditionalFile) {
            this.eventData = ((AdditionalFile) data).getOriginalFileName();
        }
    }

    public Object getEventData() {
        return eventData;
    }

    /**
     * @return Returns the evtSubject.
     */
    public String getEvtSubject(Locale locale) {
        ResourceBundle names = ResourceBundle.getBundle("eventType", locale);
        switch (getEventType()) {
            case ASSIGN:
                return String.format(locale,
                                     names.getString("ticketEvent.assign"),
                                     ticket.getTicketId(), eventData, evtAuthor);
            case CATEGORYCHANGE:
                return String.format(locale,
                                     names.getString("ticketEvent.category.change"),
                                     evtAuthor, ticket.getTicketId());
            case CLOSE:
                return String.format(locale,
                                     names.getString("ticketEvent.close"),
                                     evtAuthor, ticket.getTicketId());
            case COMMENTADD:
                return String.format(locale,
                                     names.getString("ticketEvent.comment.add"),
                                     evtAuthor, ticket.getTicketId());
            case CREATE:
                return String.format(locale,
                                     names.getString("ticketEvent.create"),
                                     evtAuthor);
            case PRIORITYCHANGE:
                return String.format(locale,
                                     names.getString("ticketEvent.priority.change"),
                                     evtAuthor, ticket.getTicketId());
            case REASSIGN:
                return String.format(locale,
                                     names.getString("ticketEvent.reassign"),
                                     evtAuthor, ticket.getTicketId(), eventData);
            case RESOLVE:
                return String.format(locale,
                                     names.getString("ticketEvent.resolve"),
                                     evtAuthor, ticket.getTicketId());
            case REOPEN:
                return String.format(locale,
                                     names.getString("ticketEvent.reopen"),
                                     evtAuthor, ticket.getTicketId());
            case REJECT:
                return String.format(locale,
                                     names.getString("ticketEvent.reject"),
                                     evtAuthor, ticket.getTicketId());
            case STATUSCHANGE:
                return String.format(locale,
                                     names.getString("ticketEvent.status.change"),
                                     ticket.getTicketId());
            case ATTACHMENTADD:
                return String.format(locale,
                                     names.getString("ticketEvent.attachmentAdd"),
                                     evtAuthor, eventData, ticket.getTicketId());
        }
        throw new RuntimeException("Nieznany rodzaj zdarzenia.");
    }

    /**
     * @return Returns the eventType.
     */
    public EventType getEventType() {
        return eventType;
    }

    /**
     * @param eventType The eventType to set.
     */
    public void setEventType(EventType eventType) {
        this.eventType = eventType;
        this.eventTypeAsInt = eventType.toInt();
    }

    public int getEventTypeAsInt() {
        return eventTypeAsInt;
    }

    public void setEventTypeAsInt(int eventTypeAsInt) {
        this.eventTypeAsInt = eventTypeAsInt;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    @Override
    public String toString() {
        return "[" + ticketEventId + "] => [" + getEvtSubject(Locale.getDefault()) + "]";
    }
 
    @PrePersist
    protected void populateEventTypeDB() {
        this.eventTypeAsInt = this.eventType.toInt();
    }

    @PostLoad
    protected void populateEventTypeTransient() {
        this.eventType = EventType.fromInt(this.eventTypeAsInt);
    }
}
