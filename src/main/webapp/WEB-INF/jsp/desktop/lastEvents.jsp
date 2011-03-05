<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastEvents}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="event" items="${lastEvents}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta">Rafał Kotusiewicz, <fmt:formatDate value="${event.evtDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <img src="<c:url value="/themes/blue/i/remove.gif"/>" class="eventType" title="<c:out value="${event.eventType}"/>" alt="<c:out value="${event.eventType}"/>" /><a href="<c:url value="/tickets/${event.ticket.ticketId}/details.html"/>"><c:out value="${event.evtSubject}"/></a>
                    
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
