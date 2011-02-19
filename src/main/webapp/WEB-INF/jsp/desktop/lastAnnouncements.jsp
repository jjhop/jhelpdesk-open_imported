<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastAnnouncements}">
    <table cellspacing="0" class="standardtable">
        <tr>
            <th>Data</th>
            <th class="lastcol">Tytuł</th>
        </tr>
        <c:forEach var="announcement" items="${lastAnnouncements}">
            <tr>
                <td><fmt:formatDate value="${announcement.createDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                <td class="lastcol">
                    <a href="<c:url value="/announcements/${announcement.announcementId}/show.html"/>"><c:out value="${announcement.title}"/></a>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="lastcol"><c:out value="${announcement.lead}"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>