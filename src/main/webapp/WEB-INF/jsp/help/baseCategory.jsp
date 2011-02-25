<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

przeglądanie kategorii

<c:if test="${fn:length(articles) > 0}">
    <ul>
        <c:forEach var="article" items="${articles}" varStatus="idx">
            <li>${idx.count + offset} => ${article.title}</li>
        </c:forEach>
    </ul>
    <hr/>
    <%
        int articlesInSection = (Integer) request.getAttribute("articlesInSection");
        int pageSize = (Integer) request.getAttribute("pageSize");
        int max = articlesInSection / pageSize + articlesInSection % pageSize;
    %>
    <ul>
    <% for (int i = 0; i < max; ++i) { %>
        <li><a href="<c:url value="/help/base/category/${category}/show.html?p="/><%=i+1%>"><%=i+1%></a></li>
    <% } %>
    </ul>
</c:if>