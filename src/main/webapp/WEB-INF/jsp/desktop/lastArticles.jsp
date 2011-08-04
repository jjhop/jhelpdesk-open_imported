<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastArticles}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="article" items="${lastArticles}">
            <tr>
                <td class="lastcol">
                    <span class="entryMeta">${article.author}, <fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                    <a class="desktopAnchor" href="<c:url value="/help/base/articles/${article.id}/show.html"/>"><c:out value="${article.title}"/></a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>