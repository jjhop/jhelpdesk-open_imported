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

public enum CommentType {
    NORMAL(0),
    REJECT(1),
    RESOLVE(2),
    REOPEN(3),
    CLOSE(4);

    private final int id;

    private CommentType(int id) {
        this.id = id;
    }

    public int toInt() {
        return id;
    }

    public static CommentType fromInt(int id) {
        for (CommentType t : CommentType.values()) {
            if (t.id == id) return t;
        }
        throw new RuntimeException("Unknowny TicketComment.CommentType");
    }
}