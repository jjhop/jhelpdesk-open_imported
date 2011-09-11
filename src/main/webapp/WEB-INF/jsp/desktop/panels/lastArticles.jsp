<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.Locale" %>
<%@ page import="de.berlios.jhelpdesk.model.User" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:choose>
    <c:when test="${not empty lastArticles}">
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
    </c:when>
    <c:otherwise>
        <%
            Locale currenUserLocale =
                ((User)session.getAttribute("loggedUser")).getPreferredLocale();
            if (currenUserLocale.equals(new Locale("pl"))) {

        %>
        <img src="<c:url value="/themes/blue/desktop/sample_kb.png"/>" alt=""/>
        <% } else { %>
        <img src="<c:url value="/themes/blue/desktop/sample_kb_en.png"/>" alt=""/>
        <% } %>
    </c:otherwise>
</c:choose>