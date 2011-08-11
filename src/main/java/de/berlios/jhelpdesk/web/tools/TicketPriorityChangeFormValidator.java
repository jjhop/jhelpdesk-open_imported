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
import org.springframework.validation.Validator;

import de.berlios.jhelpdesk.model.TicketPriorityChangeForm;

@Component
public class TicketPriorityChangeFormValidator implements Validator {

    public boolean supports(Class<?> clazz) {
        return TicketPriorityChangeForm.class.equals(clazz);
    }

    public void validate(Object target, Errors errors) {
        TicketPriorityChangeForm form = (TicketPriorityChangeForm) target;
        if (form.getCommentText() == null
                || form.getCommentText().trim().isEmpty()) { // isEmpty jest z jdk 1.6
            errors.rejectValue("commentText", "ticketCategoryChangeForm.commentText.empty");
        }
    }
}
