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

import java.io.StringWriter;
import java.io.Writer;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.context.Context;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import de.berlios.jhelpdesk.dao.TicketDAO;
import de.berlios.jhelpdesk.model.Ticket;
import de.berlios.jhelpdesk.model.User;

@Component
public class MailerService {

    @Autowired
    private TicketDAO ticketDAO;

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private VelocityEngine velocityEngine;

    public void send(String recipient, String subject, String body) {

    }

    public void sendNotificationForTicketAssignEvent(Long ticketId) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jHelpDesk <moppee@mygreatcode.com>");
        message.setSubject("Zgłoszenie  #" + ticketId + " zostało przypisane.");
        try {
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            Template template = this.velocityEngine.getTemplate("ticketAssignEvent.vm", "UTF-8");
            Context context = new VelocityContext();
            
            context.put("ticket", ticket);
            Writer writer = new StringWriter();
            template.merge(context, writer);
            message.setTo(ticket.getNotifier().getEmail());
            message.setBcc("r.kotusiewicz@gmail.com");
            message.setText(writer.toString());
            this.mailSender.send(message);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void sendNotificationForNewSaviourForTicket(Long ticketId, User assigner, String comment) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jHelpDesk <moppee@mygreatcode.com>");
        message.setSubject("Zgłoszenie  #" + ticketId + " zostało zlecone Tobie.");
        try {
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            Template template = this.velocityEngine.getTemplate("ticketNotificationForNewSaviour.vm", "UTF-8");
            Context context = new VelocityContext();

            context.put("ticket", ticket);
            context.put("assigner", assigner);
            context.put("comment", comment);
            Writer writer = new StringWriter();
            template.merge(context, writer);
            message.setTo(ticket.getNotifier().getEmail());
            message.setBcc("r.kotusiewicz@gmail.com");
            message.setText(writer.toString());
            this.mailSender.send(message);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void sendNotificationForTicketRejectEvent(Long ticketId, User rejector, String comment) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jHelpDesk <moppee@mygreatcode.com>");
        message.setSubject("Zgłoszenie  #" + ticketId + " zostało odrzucone.");
        try {
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            Template template = this.velocityEngine.getTemplate("ticketRejectEvent.vm", "UTF-8");
            Context context = new VelocityContext();
            context.put("ticket", ticket);
            context.put("comment", comment);
            context.put("rejector", rejector);
            Writer writer = new StringWriter();
            template.merge(context, writer);
            message.setTo(ticket.getNotifier().getEmail());
            message.setBcc("r.kotusiewicz@gmail.com");
            message.setText(writer.toString());
            this.mailSender.send(message);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void sendNotificationForTicketCloseEvent(Long ticketId) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("jHelpDesk <moppee@mygreatcode.com>");
        message.setSubject("Zgłoszenie  #" + ticketId + " zostało odrzucone.");
        try {
            Ticket ticket = ticketDAO.getTicketById(ticketId);
            Template template = this.velocityEngine.getTemplate("ticketRejectEvent.vm", "UTF-8");
            Context context = new VelocityContext();
            context.put("ticket", ticket);
            Writer writer = new StringWriter();
            template.merge(context, writer);
            message.setTo(ticket.getNotifier().getEmail());
            message.setBcc("r.kotusiewicz@gmail.com");
            message.setText(writer.toString());
            this.mailSender.send(message);
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void sendNotificationForTicketResolveEvent(Long ticketId, User user, String comment) {
        System.out.println("[resolve] Wyslałem mail zwiazany z ticketem #" + ticketId);
    }
}
