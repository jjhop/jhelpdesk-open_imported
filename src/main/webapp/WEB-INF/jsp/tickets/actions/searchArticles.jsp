<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="de.berlios.jhelpdesk.model.Article" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%
    Long ticketId = (Long) request.getAttribute("ticketId");
%>
<ul>
    <c:choose>
        <c:when test="${fn:length(resultList) > 0}">
            <c:forEach items="${resultList}" var="a">
                <li id="aid${a.id}"
                    <%
                       Article article = (Article) pageContext.getAttribute("a");
                       if (article.isAssociatedWithTicket(ticketId)) {
                           out.print("class=\"connected\"");
                       }
                    %>>
                    <span class="entryText">${a.title}</span>
                    <span class="entryCategory">${a.category.categoryName}</span>
                    <span class="entryMeta">Dodany <strong><fmt:formatDate value="${a.createdAt}" pattern="yyyy-MM-dd HH:mm" /></strong> przez <strong>${a.author}</strong></span>
                </li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>Nic do pokazania...</li>
        </c:otherwise>
    </c:choose>
</ul>
<c:if test="${moreResultCount != null}">
    <div class="moreResults">więcej o ${moreResultCount}</div>
</c:if>
