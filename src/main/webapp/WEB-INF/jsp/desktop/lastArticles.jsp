<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastArticles}">
    <table cellspacing="0" class="standardtable">
        <tr>
            <th>Tytuł</th>
            <th class="lastcol">Data</th>
        </tr>
        <c:forEach var="article" items="${lastArticles}">
            <tr>
                <td><a href="<c:url value="/help/base/showOne.html?id=${article.articleId}"/>"><c:out value="${article.title}"/></a></td>
                <td class="lastcol"><fmt:formatDate value="${article.createDate}" pattern="dd/MM/yyyy HH:mm"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>