<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastEvents}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="event" items="${lastEvents}">
            <tr>
                <td class="lastcol">
                    <a href="<c:url value="/tickets/${event.ticket.ticketId}/details.html"/>"><c:out value="${event.evtSubject}"/></a><br/>
                    <c:out value="${event.eventType}"/><br/>
                    <fmt:formatDate value="${event.evtDate}" pattern="dd/MM/yyyy HH:mm"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>
