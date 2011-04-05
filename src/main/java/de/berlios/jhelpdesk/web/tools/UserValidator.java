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

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

import de.berlios.jhelpdesk.model.User;

@Component
@Qualifier("complete")
public class UserValidator extends UserDataValidator {

    @Override
    public void validate(Object user, Errors errors) {
        super.validate(user, errors);
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "errors.user.password");
        if (((User) user).getUserRole() == null) {
            errors.rejectValue("userRole", "errors.user.userRole.notset");
        }
    }
}
