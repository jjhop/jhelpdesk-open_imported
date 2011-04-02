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

import org.apache.commons.lang.StringUtils;

/**
 *
 * @author jjhop
 */
public class PasswordForm {

    private String currentPassword;
    private String newPassword;
    private String newPasswordRepeated;

    public String getCurrentPassword() {
        return currentPassword;
    }

    public void setCurrentPassword(String currentPassword) {
        this.currentPassword = currentPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getNewPasswordRepeated() {
        return newPasswordRepeated;
    }

    public void setNewPasswordRepeated(String newPasswordRepeated) {
        this.newPasswordRepeated = newPasswordRepeated;
    }

    public boolean newPasswordValid() {
        boolean containsNumber = StringUtils.containsAny(newPassword, "0123456789");
        boolean containsSpecial = StringUtils.containsAny(newPassword, "!@#$%^&*()_+-=/*,.;:\\\"'`~'");
        return newPassword.length() >= 6
                && newPassword.equals(newPasswordRepeated)
                && containsNumber
                && containsSpecial;
    }
}
