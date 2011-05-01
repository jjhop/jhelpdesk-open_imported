<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastTickets}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="ticket" items="${lastTickets}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta"><c:out value="${ticket.notifier}"/>, <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <a href="<c:url value="/tickets/${ticket.ticketId}/details.html"/>"><c:out value="${ticket.subject}"/></a><br/>
                    <span class="ticketPriority" title="<c:out value="${ticket.ticketPriority}"/>">
                    </span>

                        <c:choose>
                            <c:when test="${ticket.ticketCategory.id == 0}">
                                Brak
                            </c:when>
                            <c:otherwise>
                                <c:out value="${ticket.ticketCategory}"/>
                            </c:otherwise>
                        </c:choose>

                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>