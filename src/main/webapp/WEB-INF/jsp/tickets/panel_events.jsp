<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@page import="de.berlios.jhelpdesk.model.TicketEvent"%>
<%@page import="de.berlios.jhelpdesk.model.User"%>

<table width="100%" cellspacing="12" cellpadding="4">
    <tr>
        <td>
            <table cellspacing="0" class="standardtable">
                <tr>
                    <th>Lp.</th>
                    <th>Zdarzenie</th>
                    <th width="100" class="lastcol">Data</th>
                </tr>
                <% User user = (User) session.getAttribute("user");%>
                <c:forEach var="event" items="${ticket.events}" varStatus="status">
                    <tr>
                        <td class="scount"><c:out value="${status.count}"/></td>
                    <td>
                        <% TicketEvent evt = (TicketEvent) pageContext.getAttribute("event");%>
                        <%= evt.getEvtSubject(user.getPreferredLocale())%>
                    </td>
                    <td class="lastcol"><fmt:formatDate value="${event.evtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
</table>