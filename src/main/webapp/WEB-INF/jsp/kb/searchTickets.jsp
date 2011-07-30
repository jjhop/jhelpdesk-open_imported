<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="de.berlios.jhelpdesk.model.Article" %>
<%@ page import="de.berlios.jhelpdesk.model.Ticket" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<%
    Article article = (Article) request.getAttribute("article");
%>

<ul>
    <c:choose>
        <c:when test="${fn:length(resultList) > 0}">
            <c:forEach items="${resultList}" var="t">
                <li id="tid${t.ticketId}"
                    <% Ticket t = (Ticket) pageContext.getAttribute("t");
                       if (article.isAssociatedWithTicket(t.getTicketId())) {
                           out.print("class=\"connected\"");
                       }
                    %>>
                    <span>#${t.ticketId}</span>
                    <span>${t.shortSubject}</span>
                    <span class="category">${t.ticketCategory.categoryName}</span>
                    <span class="entryMeta">${t.createdAt}</span>
                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>Nic do pokazania...</li>
        </c:otherwise>
    </c:choose>
</ul>
<c:if test="${moreResultCount != null}">
    <div>więcej o ${moreResultCount}</div>
</c:if>
