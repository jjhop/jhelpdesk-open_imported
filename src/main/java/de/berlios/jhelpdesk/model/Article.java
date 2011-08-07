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
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import de.berlios.jhelpdesk.utils.MarkdownTranslator;

/**
 *
 * @author jjhop
 */
@Entity
@Table(name = "article")
@SequenceGenerator(name = "article_sequence", sequenceName = "article_id_seq", allocationSize = 1)
@NamedQueries({
    @NamedQuery(name = "Article.lastAdded", query = "SELECT a FROM Article a ORDER BY a.createdAt DESC"),
    @NamedQuery(name = "Article.getForCategory", 
        query = "SELECT a FROM Article a WHERE a.category.id=?1 ORDER BY a.createdAt DESC")
})
// @NamedQuery(name = "TicketComment.countCommentsForTicket",
// query = "SELECT COUNT(tc) FROM TicketComment tc WHERE tc.ticket.ticketId=?1")
public class Article implements Serializable {

    private static final long serialVersionUID = 6398694944488620526L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="article_sequence")
    @Column(name = "id")
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "category_id")
    private ArticleCategory category;

    /**
     *
     */
    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private User author;

    /**
     *
     */
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;

    @Column(name = "ord")
    private Long order;

    /**
     *
     */
    @Column(name = "title", length = 255)
    private String title;

    /**
     *
     */
    @Column(name = "lead", length = 4096)
    private String lead;

    /**
     *
     */
    @Column(name = "body", length = 16384)
    private String body;

    /**
     *
     */
    @OneToMany(mappedBy = "article", cascade = {CascadeType.REMOVE})
    @OrderBy(value = "createDate")
    private List<ArticleComment> comments;

    /**
     *
     */
    @ManyToMany
    @JoinTable(name = "article_ticket",
        joinColumns = {@JoinColumn(name = "article_id")},
        inverseJoinColumns = {@JoinColumn(name = "ticket_id")})
    private Set<Ticket> associatedTickets;

    @Transient
    private MarkdownTranslator translator = new MarkdownTranslator();
    
    /**
     * 
     */
    public Article() {
        this.comments = new ArrayList<ArticleComment>();
        this.associatedTickets = new HashSet<Ticket>();
        this.createdAt = new Date();
    }

    public Article(Long id, String title, String lead, Date createdAt) {
        this();
        this.id = id;
        this.createdAt = createdAt;
        this.title = title;
        this.lead = lead;
    }

    /**
     * @return returns createdAt.
     */
    public Date getCreatedAt() {
        return createdAt;
    }

    /**
     * @param createdAt createdAt to set.
     */
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    
    public Long getOrder() {
        return order;
    }

    public void setOrder(Long order) {
        this.order = order;
    }
    
    /**
     * @return Returns the articleId.
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id The articleId to set.
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * 
     * @return
     */
    public ArticleCategory getCategory() {
        return category;
    }

    /**
     * 
     * @param category
     */
    public void setCategory(ArticleCategory category) {
        this.category = category;
    }

    /**
     * @return Returns the title.
     */
    public String getTitle() {
        return title;
    }

    /**
     * @param title The title to set.
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * @return Returns the author.
     */
    public User getAuthor() {
        return author;
    }

    /**
     * @param author The author to set.
     */
    public void setAuthor(User author) {
        this.author = author;
    }

    /**
     * @return Returns the body.
     */
    public String getBody() {
        return body;
    }

    public String getHtmlBody() {
        return this.translator.processMarkdown(this.body);
    }

    /**
     * @param body The body to set.
     */
    public void setBody(String body) {
        this.body = body;
    }

    /**
     * @return Returns the lead.
     */
    public String getLead() {
        return lead;
    }

    /**
     * @param lead The lead to set.
     */
    public void setLead(String lead) {
        this.lead = lead;
    }

    /**
     * @return Returns the comments.
     */
    public List<ArticleComment> getComments() {
        return comments;
    }

    /**
     * @param comments The comments to set.
     */
    public void setComments(List<ArticleComment> comments) {
        this.comments = comments;
    }

    /**
     * @return Returns the associatedTickets.
     */
    public Set<Ticket> getAssociatedTickets() {
        return associatedTickets;
    }

    /**
     * @param associatedTickets The associatedTickets to set.
     */
    public void setAssociatedTickets(Set<Ticket> associatedTickets) {
        this.associatedTickets = associatedTickets;
    }

    public boolean isAssociatedWithTicket(Long ticketId) {
        assert ticketId != null;
        for (Ticket ticket : associatedTickets) {
            if (ticket.getTicketId().equals(ticketId)) {
                return true;
            }
        }
        return false;
    }

    public void setTranslator(MarkdownTranslator translator) {
        this.translator = translator;
    }
}
