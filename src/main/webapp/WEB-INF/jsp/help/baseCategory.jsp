<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

przeglądanie kategorii

<c:if test="${fn:length(articles) > 0}">
    <ul>
        <c:forEach var="article" items="${articles}" varStatus="idx">
            <li>${idx.count + offset} => ${article.title} by ${article.author}</li>
        </c:forEach>
    </ul>
    <hr/>
    <ul>
        <%
            int pages = (Integer) request.getAttribute("pages");
            for (int currentPage = 1; currentPage <= pages; ++currentPage) {
        %>
        <li><a href="<c:url value="/help/base/category/${category}/show.html?p="/><%=currentPage%>"><%=currentPage%></a></li>
        <%
            }
        %>
    </ul>
</c:if>