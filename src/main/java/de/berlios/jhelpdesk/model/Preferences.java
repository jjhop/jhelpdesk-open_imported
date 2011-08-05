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
import java.util.Locale;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 *
 * @author jjhop
 */
@Entity
@Table(name = "user_preferences")
public class Preferences implements Serializable {

    private static final long serialVersionUID = 7120658431650439152L;

    public static Preferences getDefault() {
        Preferences p = new Preferences();
        p.setWelcomePage("desktop");
        p.setAnnouncementsListSize(10);
        p.setArticlesListSize(10);
        p.setFiltersListSize(10);
        p.setNewTicketFormView("form");
        p.setPreferredLocale(Locale.getDefault());
        p.setSearchResultLimit(10);
        p.setTicketsListSize(10);
        p.setUsersListSize(10);
        return p;
    }

	@Id
    @Column(name = "id")
    private Long id;

    @OneToOne(mappedBy = "preferences")
    private User user;

    @Column(name = "welcome_page")
    private String welcomePage;

    @Column(name = "locale")
    private Locale preferredLocale;

    @Column(name = "filter_id")
    private Long filterId;

    @Column(name = "new_ticket_form_view")
    private String newTicketFormView;

    @Column(name = "tickets_list_size")
    private Integer ticketsListSize;

    @Column(name = "announcements_list_size")
    private Integer announcementsListSize;

    @Column(name = "articles_list_size")
    private Integer articlesListSize;

    @Column(name = "users_list_size")
    private Integer usersListSize;

    @Column(name = "filters_list_size")
    private Integer filtersListSize;

    @Column(name = "search_result_limit")
    private Integer searchResultLimit;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Locale getPreferredLocale() {
        return preferredLocale;
    }

    public void setPreferredLocale(Locale preferredLocale) {
        this.preferredLocale = preferredLocale;
    }

    public String getWelcomePage() {
        return welcomePage;
    }

    public void setWelcomePage(String welcomePage) {
        this.welcomePage = welcomePage;
    }

    public void setFilterId(Long filterId) {
        this.filterId = filterId;
    }

    public Long getFilterId() {
        return this.filterId;
    }

    public void setNewTicketFormView(String view) {
        this.newTicketFormView = view;
    }

    public String getNewTicketFormView() {
        return this.newTicketFormView;
    }
    public Integer getAnnouncementsListSize() {
        return announcementsListSize;
    }

    public void setAnnouncementsListSize(Integer announcementsListSize) {
        this.announcementsListSize = announcementsListSize;
    }

    public Integer getFiltersListSize() {
        return filtersListSize;
    }

    public void setFiltersListSize(Integer filtersListSize) {
        this.filtersListSize = filtersListSize;
    }

    public Integer getTicketsListSize() {
        return ticketsListSize;
    }

    public void setTicketsListSize(Integer ticketsListSize) {
        this.ticketsListSize = ticketsListSize;
    }

    public Integer getUsersListSize() {
        return usersListSize;
    }

    public void setUsersListSize(Integer usersListSize) {
        this.usersListSize = usersListSize;
    }

    public Integer getArticlesListSize() {
        return this.articlesListSize;
    }

    public void setArticlesListSize(Integer articlesListSize) {
        this.articlesListSize = articlesListSize;
    }

    public Integer getSearchResultLimit() {
        return this.searchResultLimit;
    }

    public void setSearchResultLimit(Integer searchResultLimit) {
        this.searchResultLimit = searchResultLimit;
    }
}
