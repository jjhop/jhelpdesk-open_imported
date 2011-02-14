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
package de.berlios.jhelpdesk.web.tools;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

import de.berlios.jhelpdesk.model.Ticket;

/**
 *
 * @author jjhop
 */
@Component("ticketPartialValidator")
public class TicketPartialValidator {
    
    public void validateUser(Ticket ticket, String notifier, Errors errors) {
        if (ticket.getNotifier() == null) {
            if ("".equalsIgnoreCase(notifier)) {
                errors.rejectValue("notifier", "ticket.notifier.notEmpty");
            } else {
                errors.rejectValue("notifier", "ticket.notifier.notExists",
                        new Object[]{notifier}, null);
            }
        }
    }

    public void validateSubjectAndDescription(Ticket ticket, Errors errors) {
        if (ticket.getSubject() == null || ticket.getSubject().trim().length() < 3) {
            errors.rejectValue("subject", "ticket.subject.empty");
        }
        if (ticket.getDescription() == null || ticket.getDescription().trim().length() < 1) {
            errors.rejectValue("description", "ticket.description.empty");
        }
    }
}
