<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<form action="" method="get">
    <input type="text" name="tId"/>
    <input type="submit">
</form>
<hr/>
<c:if test="${ticket != null}">
    TicketSubject: ${ticket.subject}<br/>
    TicketCreatedAt: ${ticket.createdAt}<br/>
    TicketNotifier: ${ticket.notifier}<br/>
    TicketCategory: ${ticket.ticketCategory}

    <hr/>
    <form action="" method="post">
        <input type="hidden" name="tId" value="${ticket.ticketId}"/>
        <input type="submit" value="Powiąż">
    </form>
</c:if>
<c:if test="${message != null}">
    ${message}
</c:if>


