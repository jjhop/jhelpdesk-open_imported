<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="pagecontentheader" class="kb"><h2>Baza wiedzy</h2></div>

<div class="pagecontentsubheader"><h3 id="headKBList">Wyniki wyszukiwania</h3></div>

<c:forEach var="a" items="${result}">
    <div class="kbSearchItem">
        <h2><a href="<c:url value="/help/base/articles/${a.id}/show.html"/>"><c:out value="${a.title}"/></a></h2>
        <div class="kbSearchItemLead">
            <c:out value="${a.lead}"/>
        </div>
        <p class="kbSearchItemMeta">
            <c:out value="${a.author}"/>, Dodano: <fmt:formatDate value="${a.createdAt}" pattern="yyyy-MM-dd HH:mm" />
        </p>
    </div>
</c:forEach>
