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
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 * @author jjhop
 */
@Entity
@Table(name = "ticket_category")
@SequenceGenerator(name = "ticket_category_sequence", sequenceName = "ticket_category_id_seq", allocationSize = 1)
public class TicketCategory implements Serializable {

    private static final long serialVersionUID = -8116103471359194082L;

    /**
     * 
     */
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ticket_category_sequence")
    @Column(name = "id")
    private Long id;

    /**
     *
     */
    @Column(name = "category_name")
    private String categoryName;

    /**
     *
     */
    @Column(name = "category_desc")
    private String categoryDesc;

    @Column(name = "ord")
    private Long order;
    
    /**
     *
     */
    @Column(name = "is_active")
    private boolean isActive;

    @Column(name = "tickets_count")
    private Long ticketsCount;

    @OneToMany(mappedBy = "ticketCategory")
    private Set<Ticket> tickets;

    /**
     *
     */
    public TicketCategory() {
        this.tickets = new HashSet<Ticket>();
    }

    /**
     *
     * @param categoryId
     * @param categoryName
     */
    public TicketCategory(int categoryId, String categoryName) {
        this.id = new Long(categoryId);
        this.categoryName = categoryName;
    }

    /**
     * @return Returns the ticketCategoryId.
     */
    public Long getId() {
        return id;
    }

    /**
     * @param ticketCategoryId The ticketCategoryId to set.
     */
    public void setId(Long ticketCategoryId) {
        this.id = ticketCategoryId;
    }

    /**
     * @return Returns the categoryDesc.
     */
    public String getCategoryDesc() {
        return categoryDesc;
    }

    /**
     * @param categoryDesc
     *            The categoryDesc to set.
     */
    public void setCategoryDesc(String categoryDesc) {
        this.categoryDesc = categoryDesc;
    }

    /**
     * @return Returns the categoryName.
     */
    public String getCategoryName() {
        return categoryName;
    }

    /**
     * @param categoryName
     *            The categoryName to set.
     */
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public Long getOrder() {
        return order;
    }

    public void setOrder(Long order) {
        this.order = order;
    }

    public Long getTicketsCount() {
        return ticketsCount;
    }

    public void setTicketsCount(Long ticketsCount) {
        this.ticketsCount = ticketsCount;
    }

    /**
     * @return Returns the isActive.
     */
    public boolean isActive() {
        return isActive;
    }

    /**
     * @param isActive
     *            The isActive to set.
     */
    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    public Set<Ticket> getTickets() {
        return tickets;
    }

    @Override
    public String toString() {
        return categoryName;
    }

    @Override
    public boolean equals(Object obj) {
       if (this == obj) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        if (this.id == null) {
            return false;
        }
        TicketCategory category = (TicketCategory) obj;
        return this.id.equals(category.id);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + (this.id != null ? this.id.hashCode() : 0);
        hash = 67 * hash + (this.categoryName != null ? this.categoryName.hashCode() : 0);
        hash = 67 * hash + (this.categoryDesc != null ? this.categoryDesc.hashCode() : 0);
        return hash;
    }
}
