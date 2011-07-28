<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<table width="100%" cellspacing="12" cellpadding="4">
    <tr>
        <td>
            <c:if test="${not empty kbArticles}">
                <table cellspacing="0" class="standardtable" style="margin-bottom: 10px;">
                    <c:forEach var="article" items="${kbArticles}" varStatus="status">
                    <tr>
                        <td>
                            <span class="entryMeta">
                                <c:out value="${article.author}"/>, <fmt:formatDate value="${article.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                            <span class="entryBlock">
                                <a href="<c:url value="/help/base/articles/${article.id}/show.html"/>">
                                <c:out value="${article.title}" escapeXml="false"/></a>
                            </span>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
                <c:if test="${kbArticlesPages > 1}">
                <ul class="panelPager">
                    <c:if test="${currentKBArticlesPage > 1}">
                        <li><a href="javascript:remoteLoad('panel_articles', '<c:url value="/tickets/${ticketId}/articles.html?page=${kbArticlesPages-1}"/>');">&laquo; &lsaquo;</a></li>
                    </c:if>
                    <%
                        int kbArticlesPages = (Integer) request.getAttribute("kbArticlesPages");
                        for (int cPage = 1; cPage <= kbArticlesPages; ++cPage) {
                    %>
                        <li><a href="javascript:remoteLoad('panel_articles', '<c:url value="/tickets/${ticketId}/articles.html?page="/><%=cPage%>');"><%=cPage%></a></li>
                    <% } %>
                    <c:if test="${currentKBArticlesPage < kbArticlesPages}">
                        <li><a href="javascript:remoteLoad('panel_articles', '<c:url value="/tickets/${ticketId}/articles.html?page=${kbArticlesPages+1}"/>');">&rsaquo; &raquo;</a></li>
                    </c:if>
                </ul>
                </c:if>
            </c:if>
            <a href="<c:url value="/tickets/${ticketId}/articles/new.html"/>"
               class="btn lightview" title=":: :: closeButton: false, width: 500, height: 350, keyboard: true">Powiąż z artykułem</a>
        </td>
    </tr>
</table>
