<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:if test="${not empty lastArticles}">
    <table cellspacing="0" class="standardtable">
        <c:forEach var="article" items="${lastArticles}">
            <tr>
                <td class="lastcol">
                    <fmt:formatDate value="${article.createDate}" pattern="dd/MM/yyyy HH:mm"/><br/>
                    <a href="<c:url value="/help/base/articles/${article.articleId}/show.html"/>"><c:out value="${article.title}"/></a>
                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>