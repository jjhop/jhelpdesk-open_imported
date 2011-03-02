<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastTickets}">
    <table cellspacing="0" class="standardtable">
        <tr>
            <th>Temat</th>
            <th>Zgłaszający</th>
            <th>Kategoria</th>
            <th>Priorytet</th>
            <th class="lastcol">Data</th>
        </tr>
        <c:forEach var="ticket" items="${lastTickets}">
            <tr>
                <td><a href="<c:url value="/tickets/${ticket.ticketId}/details.html"/>"><c:out value="${ticket.subject}"/></a></td>
                <td><c:out value="${ticket.notifier}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${ticket.ticketCategory.ticketCategoryId == 0}">
                            Brak
                        </c:when>
                        <c:otherwise>
                            <c:out value="${ticket.ticketCategory}"/>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><c:out value="${ticket.ticketPriority}"/></td>
                <td class="lastcol"><fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>