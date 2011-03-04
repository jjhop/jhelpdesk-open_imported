<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty announcements}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="announcement" items="${announcements}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta">Rafał Kotusiewicz, <fmt:formatDate value="${announcement.createDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <a href="<c:url value="/announcements/${announcement.id}/show.html"/>"><c:out value="${announcement.title}"/></a><br/>
                    <c:out value="${announcement.lead}"/>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>