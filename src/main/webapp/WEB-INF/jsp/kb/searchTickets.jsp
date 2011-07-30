<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<ul>
    <c:choose>
        <c:when test="${fn:length(resultList) > 0}">
            <c:forEach items="${resultList}" var="t">
                <li id="tid${t.ticketId}">#${t.ticketId} : ${t.subject} <span class="entryMeta">${t.createdAt}</span></li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li>Nic do pokazania...</li>
        </c:otherwise>
    </c:choose>

</ul>
<c:if test="${moreResultCount != null}">
<div>
    więcej o ${moreResultCount}
</div>
</c:if>