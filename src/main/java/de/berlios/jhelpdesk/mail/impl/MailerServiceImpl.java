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
package de.berlios.jhelpdesk.mail.impl;

import org.springframework.stereotype.Component;

import de.berlios.jhelpdesk.mail.MailerService;

@Component
public class MailerServiceImpl implements MailerService {
    
    public void send(String recipient, String subject, String body) {

    }

    public void sendNotificationForTicketAssignEvent(Long ticketId) {
        // maile wrzucamy do kolejki może jakoś? a stamtąd będziemy je
        // jakimś mechanizmem pobierać i wysyłać...
        System.out.println("Wyslałem mail zwiazany z ticketem #" + ticketId);
    }

    public void sendNotificationForTicketRejectEvent(Long ticketId, Long rejectorId) {
        // j.w.
    }
}
