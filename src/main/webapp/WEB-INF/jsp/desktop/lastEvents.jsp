<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="de.berlios.jhelpdesk.model.TicketEvent"%>
<%@page import="de.berlios.jhelpdesk.model.User"%>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastEvents}">
    <table cellspacing="0" class="standardtable">
        <% User user = (User)session.getAttribute("user"); %>
        <c:forEach var="event" items="${lastEvents}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta"><fmt:formatDate value="${event.evtDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <span class="eventType et<c:out value="${event.eventType}"/>" title="<c:out value="${event.eventType}"/>"></span>
                    <a href="<c:url value="/tickets/${event.ticket.ticketId}/details.html"/>">
                        <% TicketEvent evt = (TicketEvent)pageContext.getAttribute("event");%>
                        <%= evt.getEvtSubject(user.getPreferredLocale()) %>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
