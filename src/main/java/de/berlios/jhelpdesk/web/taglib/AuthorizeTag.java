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
package de.berlios.jhelpdesk.web.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import de.berlios.jhelpdesk.model.Role;
import de.berlios.jhelpdesk.model.User;

public class AuthorizeTag extends TagSupport {

    private static final long serialVersionUID = 2870805082059648632L;
    private static Logger log = LoggerFactory.getLogger(AuthorizeTag.class);
    private Role userRole;

    @Override
    public int doStartTag() throws JspException {
        User user = (User) pageContext.getSession().getAttribute("loggedUser");
        if (user == null) {
            return SKIP_BODY;
        }
        if (user.getUserRole().toInt() < userRole.toInt()) {
            return SKIP_BODY;
        }
        return EVAL_BODY_INCLUDE;
    }

    @Override
    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    public void setRequiredRole(String role) {
        try {
            this.userRole = Role.fromInt(Integer.parseInt(role));
        } catch (NumberFormatException nfe) {
            log.error(nfe.getMessage());
            throw new RuntimeException(nfe);
        }
    }
}
