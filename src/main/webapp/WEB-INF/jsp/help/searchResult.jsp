<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:forEach var="a" items="${result}">
    <%-- itemy to obiekty Article --%>

    <div class="kbSearchItem">
        <h2><a href="<c:url value="/help/base/articles/${a.id}/show.html"/>"><c:out value="${a.title}"/></a></h2>
        <div class="kbSearchItemLead">
            <c:out value="${a.lead}"/>
        </div>
        <p class="kbSearchItemMeta">
            <c:out value="${a.author}"/>, Dodano: <c:out value="${a.createdAt}"/> <a href="<c:url value="/help/base/articles/${a.id}/show.html"/>">Cały tekst</a>
        </p>
    </div>

</c:forEach>
