<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<ul>
    <c:choose>
        <c:when test="${fn:length(resultList) > 0}">
            <c:forEach items="${resultList}" var="t">
                <li>${t.ticketId} : ${t.createdAt} : ${t.subject}</li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>Nic do pokazania...</li>
        </c:otherwise>
    </c:choose>

    <c:if test="${moreResultCount != null}">
        <li>więcej o ${moreResultCount}</li>
    </c:if>
</ul>