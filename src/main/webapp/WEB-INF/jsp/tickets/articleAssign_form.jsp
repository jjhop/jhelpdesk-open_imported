<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="de.berlios.jhelpdesk.model.Article" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<form action="" method="get">
    <input type="text" name="aId"/>
    <input type="submit">
</form>
<hr/>
<c:if test="${article != null}">
    <%
        Article article = (Article) request.getAttribute("article");
        Long ticketId = (Long) request.getAttribute("ticketId");
        boolean alreadyAssociated = article.isAssociatedWithTicket(ticketId);
    %>
    ArticleTitle: ${article.title}<br/>
    ArticleCreatedAt: ${article.createdAt}<br/>
    ArticleAuthor: ${article.author}<br/>
    ArticleCategory: ${article.category.categoryName}
    ArticleLead ${article.lead}
    <hr/>
    <% if (alreadyAssociated) { %>
    <span>Zgłoszenie już jest powiązane z tym artykułem.</span>
    <% } else { %>
    <form action="" method="post">
        <input type="hidden" name="aId" value="${article.id}"/>
        <input type="submit" value="Powiąż">
    </form>
    <% } %>
</c:if>
<c:if test="${message != null}">
    ${message}
</c:if>
