<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:choose>
    <c:when test="${not empty announcements}">
        <table cellspacing="0" class="standardtable">
            <c:forEach var="announcement" items="${announcements}">
                <tr>
                    <td class="lastcol">
                        <span class="entryMeta">
                            <c:out value="${announcement.author.fullName}"/>, <fmt:formatDate value="${announcement.createDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                        <a class="desktopAnchor" href="<c:url value="/announcements/${announcement.id}/show.html"/>"><c:out value="${announcement.title}"/></a>
                        <span class="entryText">
                            <c:out value="${announcement.lead}"/>
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:when>
    <c:otherwise>
        <img src="<c:url value="/themes/blue/desktop/sample_ann.png"/>" alt=""/>
    </c:otherwise>
</c:choose>