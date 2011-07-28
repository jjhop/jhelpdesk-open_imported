<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<form action="" method="get">
    <input type="text" name="aId"/>
    <input type="submit">
</form>
<hr/>
<c:if test="${article != null}">
    ArticleTitle: ${article.title}<br/>
    ArticleCreatedAt: ${article.createdAt}<br/>
    ArticleAuthor: ${article.author}<br/>
    ArticleCategory: ${article.category}
    ArticleLead ${article.lead}

    <hr/>
    <form action="" method="post">
        <input type="hidden" name="aId" value="${article.id}"/>
        <input type="submit" value="Powiąż">
    </form>
</c:if>
<c:if test="${message != null}">
    ${message}
</c:if>
