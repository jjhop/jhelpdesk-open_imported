<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<a href="<c:url value="/preferences/filters/new.html"/>">Dodaj nowy filtr</a>
<ul>
    <c:forEach items="${filters}" var="f">
        <li>
            <a href="<c:url value="/preferences/filters/${f.id}/details.html"/>"><c:out value="${f.name}"/></a>
            <a href="<c:url value="/preferences/filters/${f.id}/edit.html"/>">Edytuj</a>
            <a href="<c:url value="/preferences/filters/${f.id}/delete.html"/>">Usuń</a>
        </li>
    </c:forEach>
    <hr/>
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
                <li><a href="<c:url value="/preferences/filters/list.html?p="/><%=cPage%>"><%=cPage%></a></li>
                <%  }  %>
                <c:if test="${currentPage < pages}">
                <li><a href="?p=${currentPage+1}">następna &raquo;</a></li>
                </c:if>
            </ul>
        </div>
    </c:if>
</ul>