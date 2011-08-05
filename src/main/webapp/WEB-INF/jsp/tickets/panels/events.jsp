<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@page import="de.berlios.jhelpdesk.model.TicketEvent"%>
<%@page import="de.berlios.jhelpdesk.model.User"%>

<table width="100%" cellspacing="12" cellpadding="4">
    <tr>
        <td>
            <c:if test="${not empty events}">
                <table cellspacing="0" class="standardtable">
                    <tr>
                        <th>Zdarzenie</th>
                        <th width="100" class="lastcol">Data</th>
                    </tr>
                    <% User user = (User) session.getAttribute("loggedUser");%>
                    <c:forEach var="event" items="${events}" varStatus="status">
                    <tr>
                        <td>
                            <span class="eventType et<c:out value="${event.eventType}"/>"></span>
                            <% TicketEvent evt = (TicketEvent) pageContext.getAttribute("event");%>
                            <%= evt.getEvtSubject(user.getPreferredLocale())%>
                        </td>
                        <td class="lastcol">
                            <fmt:formatDate value="${event.evtDate}" pattern="yyyy-MM-dd HH:mm"/>

                        </td>
                    </tr>
                    </c:forEach>
                </table>
                <c:if test="${eventsPages > 1}">
                <ul class="panelPager">
                    <c:if test="${currentEventsPage > 1}">
                        <li><a href="javascript:remoteLoad('panel_events', '<c:url value="/tickets/${ticketId}/events.html?page=${currentEventsPage-1}"/>');">&laquo; &lsaquo;</a></li>
                    </c:if>
                    <%
                        int eventsPages = (Integer) request.getAttribute("eventsPages");
                        for (int cPage = 1; cPage <= eventsPages; ++cPage) {
                    %>
                        <li><a href="javascript:remoteLoad('panel_events', '<c:url value="/tickets/${ticketId}/events.html?page="/><%=cPage%>');"><%=cPage%></a></li>
                    <% } %>
                    <c:if test="${currentEventsPage < eventsPages}">
                        <li><a href="javascript:remoteLoad('panel_events', '<c:url value="/tickets/${ticketId}/events.html?page=${currentEventsPage+1}"/>');">&rsaquo; &raquo;</a></li>
                    </c:if>
                </ul>
                </c:if>
            </c:if>
        </td>
    </tr>
</table>