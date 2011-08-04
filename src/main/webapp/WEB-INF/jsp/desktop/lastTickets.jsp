<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastTickets}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="ticket" items="${lastTickets}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta"><c:out value="${ticket.notifier}"/>, <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <span class="ticketCategory">
                        <c:choose>
                            <c:when test="${ticket.ticketCategory.id == 0}">
                                Brak
                            </c:when>
                            <c:otherwise>
                                <c:out value="${ticket.ticketCategory}"/>
                            </c:otherwise>
                        </c:choose>
                    </span>
                    <span class="ticketPriority  tp${ticket.ticketPriority}"
                          title="<c:out value="${ticket.ticketPriority}"/>"></span>
                    <a class="desktopAnchor" href="<c:url value="/tickets/${ticket.ticketId}/details.html"/>"><c:out value="${ticket.subject}"/></a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>