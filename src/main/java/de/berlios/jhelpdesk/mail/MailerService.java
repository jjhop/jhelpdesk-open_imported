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
package de.berlios.jhelpdesk.mail;

import org.springframework.stereotype.Component;

import de.berlios.jhelpdesk.model.User;

@Component
public class MailerService {

    public void send(String recipient, String subject, String body) {

    }

    public void sendNotificationForTicketAssignEvent(Long ticketId) {
        // maile wrzucamy do kolejki może jakoś? a stamtąd będziemy je
        // jakimś mechanizmem pobierać i wysyłać...
        System.out.println("[assign] Wyslałem mail zwiazany z ticketem #" + ticketId);
    }

    public void sendNotificationForTicketRejectEvent(Long ticketId, User rejector, String comment) {
        // j.w.
        System.out.println("[reject] Wyslałem mail zwiazany z ticketem #" + ticketId);
    }

    public void sendNotificationForTicketCloseEvent(Long ticketId, User user, String comment) {
        System.out.println("[close] Wyslałem mail zwiazany z ticketem #" + ticketId);
    }

    public void sendNotificationForTicketResolveEvent(Long ticketId, User user, String comment) {
        System.out.println("[resolve] Wyslałem mail zwiazany z ticketem #" + ticketId);
    }
}
