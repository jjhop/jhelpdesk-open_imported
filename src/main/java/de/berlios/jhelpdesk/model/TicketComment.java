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
@Table(name = "ticket_comment") // -> ticket_comments
@SequenceGenerator(name = "ticket_comment_sequence", sequenceName = "ticket_comment_id_seq", allocationSize = 1)
@NamedQueries({
    @NamedQuery(name = "TicketComment.getCommentsForTicketOrderByCreatedAtDESC",
                query = "SELECT t FROM TicketComment t WHERE t.ticket.ticketId=?1 ORDER BY t.commentDate DESC"),
    @NamedQuery(name = "TicketComment.countCommentsForTicket", query = "SELECT COUNT(tc) FROM TicketComment tc WHERE tc.ticket.ticketId=?1")
})
public class TicketComment implements Serializable {

    private static final long serialVersionUID = -29584625086517989L;

	@Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="ticket_comment_sequence")
    @Column(name = "id")
    private Long id;

    @ManyToOne
    @JoinColumn(name="ticket_id")
    private Ticket ticket;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id")
    private User commentAuthor;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "comment_date")
    private Date commentDate;

    @Column(name = "comment_text", length = 4096)
    private String commentText;

    @Transient
    private CommentType commentType;

    @Basic
    @Column(name = "comment_type")
    private int commentTypeAsInt;

    /**
     * Warto to zmienic na private lub coś w ten deseń...
     */
    @Column(name="not_for_plain_user")
    private boolean notForPlainUser;

    public TicketComment() {
        this.notForPlainUser = true;
        this.commentDate = new Date();
    }

    /**
     * @return Returns the id.
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id The id to set.
     */
    public void setId(Long id) {
        this.id = id;
    }

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }

    /**
     * @return Returns the commentAuthor.
     */
    public User getCommentAuthor() {
        return commentAuthor;
    }

    /**
     * @param commentAuthor The commentAuthor to set.
     */
    public void setCommentAuthor(User commentAuthor) {
        this.commentAuthor = commentAuthor;
    }

    /**
     * @return Returns the commentDate.
     */
    public Date getCommentDate() {
        return commentDate;
    }

    /**
     * @param commentDate The commentDate to set.
     */
    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }

    /**
     * @return Returns the commentText.
     */
    public String getCommentText() {
        return commentText;
    }

    /**
     * @param commentText The commentText to set.
     */
    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public CommentType getCommentType() {
        return commentType;
    }

    public void setCommentType(CommentType commentType) {
        this.commentType = commentType;
    }

    /**
     * @param notForPlainUser The notForPlainUser to set.
     */
    public void setNotForPlainUser(boolean notForPlainUser) {
        this.notForPlainUser = notForPlainUser;
    }

    /**
     * @return Returns the notForPlainUser.
     */
    public boolean isNotForPlainUser() {
        return notForPlainUser;
    }

    @PrePersist
    protected void populateCommentTypeDB() {
        this.commentTypeAsInt = this.commentType.toInt();
    }

    @PostLoad
    protected void populateCommentTypeTransient() {
        this.commentType = CommentType.fromInt(commentTypeAsInt);
    }
}
