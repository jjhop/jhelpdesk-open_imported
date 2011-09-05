<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="pagecontentheader" class="kb"><h2>Baza wiedzy</h2></div>

<div class="pagecontentsubheader"><h3 id="headKBArtCatList">Artykuły w kategorii: <strong>${category.categoryName}</strong></h3></div>

<c:if test="${fn:length(articles) > 0}">
    <c:forEach var="article" items="${articles}" varStatus="idx">
        <div class="kbSearchItem">
            <h2><a href="<c:url value="/help/base/articles/${article.id}/show.html"/>">${idx.count + offset}. <c:out value="${article.title}"/></a></h2>
            <div class="kbSearchItemLead">
                <c:out value="${article.lead}"/>
            </div>
            <p class="kbSearchItemMeta">
                <c:out value="${article.author}"/>, Dodano: <fmt:formatDate value="${article.createdAt}" pattern="yyyy-MM-dd HH:mm" />
            </p>
        </div>
    </c:forEach>
    <c:if test="${pages > 1}">
        <div class="outerPanelPager">
            <ul class="panelPager">
                <c:if test="${currentPage > 1}">
                <li><a href="?p=${currentPage-1}">&laquo; poprzednia</a></li>
                </c:if>
                <%
                    int pages = (Integer) request.getAttribute("pages");
                    for (int cPage = 1; cPage <= pages; ++cPage) {
                %>
                <li><a href="<c:url value="/help/base/category/${category.id}/show.html?p="/><%=cPage%>"><%=cPage%></a></li>
                <%  }  %>
                <c:if test="${currentPage < pages}">
                <li><a href="?p=${currentPage+1}">następna &raquo;</a></li>
                </c:if>
            </ul>
        </div>
    </c:if>
</c:if>
