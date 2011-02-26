<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:forEach var="a" items="${result}">
    <%-- itemy to obiekty Article --%>
    <c:out value="${a.id}"/><br/>
    <c:out value="${a.author}"/><br/>
    <c:out value="${a.title}"/><br/>
    <c:out value="${a.lead}"/><br/>
    <c:out value="${a.createdAt}"/><br/>
    <a href="<c:url value="/help/base/articles/${a.id}/show.html"/>">Cały tekst</a>
</c:forEach>
