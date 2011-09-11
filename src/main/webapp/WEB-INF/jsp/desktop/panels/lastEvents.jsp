<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Locale" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketEvent" %>
<%@ page import="de.berlios.jhelpdesk.model.User" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

 <c:choose>
    <c:when test="${not empty lastEvents}">
        <table cellspacing="0" class="standardtable">
            <% User user = (User) session.getAttribute("loggedUser"); %>
            <c:forEach var="event" items="${lastEvents}">
                <tr>
                    <td class="lastcol">
                        <span class="entryMeta"><fmt:formatDate value="${event.evtDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                        <a class="eventTitle" href="<c:url value="/tickets/${event.ticket.ticketId}/details.html"/>">
                            <% TicketEvent evt = (TicketEvent) pageContext.getAttribute("event");%>
                            <%= evt.getEvtSubject(user.getPreferredLocale()) %>
                            <span class="eventType et<c:out value="${event.eventType}"/>"></span>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <%
            Locale currenUserLocale =
                ((User)session.getAttribute("loggedUser")).getPreferredLocale();
            if (currenUserLocale.equals(new Locale("pl"))) {
        %>
        <img src="<c:url value="/themes/blue/desktop/sample_events.png"/>" alt=""/>
        <% } else { %>
        <img src="<c:url value="/themes/blue/desktop/sample_events_en.png"/>" alt=""/>
        <% } %>
    </c:otherwise>
</c:choose>