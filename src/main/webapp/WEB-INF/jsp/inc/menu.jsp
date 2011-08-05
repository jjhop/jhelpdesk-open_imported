<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp"%>

<ul class="level1">
    <li class="submenu first"><a href="<c:url value="/desktop/main.html"/>"><span><fmt:message key="main.menu.desktop"/></span></a>
    <li class="submenu first"><a href="javascript:none()"><span><fmt:message key="main.menu.tickets"/></span></a>
        <ul class="level2">
            <li class="first"><a href="<c:url value="/tickets/new.html"/>"><span><fmt:message key="main.menu.tickets.new"/></span></a></li>
            <li class="first border"><a href="<c:url value="/tickets/wizzard.html"/>"><span><fmt:message key="main.menu.tickets.wizzard"/></span></a></li>
            <c:if test="${not empty sessionScope.currentUser.filters}">
                <c:forEach var="f" items="${sessionScope.currentUser.filters}" varStatus="i">
                    <li <c:if test="${i.last}">class="border"</c:if>><a href="<c:url value="/tickets/byFilter/${f.id}/list.html"/>"><span><c:out value="${f.name}"/></span></a></li>
                </c:forEach>
            </c:if>
            <li class="last"><a href="<c:url value="/preferences/filters/list.html"/>"><span><fmt:message key="main.menu.tickets.menu.manage"/></span></a></li>
        </ul>
    </li>
    <li class="submenu"><a href="javascript:none();"><span><fmt:message key="main.menu.settings"/></span></a>
        <ul class="level2">
            <li><a href="<c:url value="/preferences/lookAndFeel.html"/>"><span><fmt:message key="main.menu.settings.laf_lang"/></span></a></li>
            <li><a href="<c:url value="/preferences/personalData.html"/>"><span><fmt:message key="main.menu.settings.personal_data"/></span></a></li>
            <li><a href="<c:url value="/preferences/filters/list.html"/>"><span><fmt:message key="main.menu.settings.filters"/></span></a></li>
        </ul>
    </li>
    <auth:check requiredRole="10">
        <li class="submenu"><a href="javascript:none();"><span><fmt:message key="main.menu.management"/></span></a>
            <ul class="level2">
                <li class="first"><a href="<c:url value="/announcements/list.html"/>"><span><fmt:message key="main.menu.management.announcements"/></span></a></li>
                <li class="last"><a href="<c:url value="/manage/users/list.html"/>"><span><fmt:message key="main.menu.management.users"/></span></a></li>
                <li><a href="<c:url value="/manage/category/list.html"/>"><span><fmt:message key="main.menu.management.ticket.categories"/></span></a></li>
                <li class="last"><a href="<c:url value="/manage/kb/categories/list.html"/>"><span><fmt:message key="main.menu.management.kb.categories"/></span></a></li>
            </ul>
        </li>
    </auth:check>
    <li class="submenu"><a href="javascript:none();"><span><fmt:message key="main.menu.help"/></span></a>
        <ul class="level2">
            <%--<li class="first"><a href="<c:url value="/help/index.html"/>"><span><fmt:message key="main.menu.help.toc"/></span></a></li>--%>
            <li><a href="<c:url value="/help/kb/index.html"/>"><span><fmt:message key="main.menu.help.kb"/></span></a></li>
            <li class="last"><a href="<c:url value="/help/about.html"/>"><span><fmt:message key="main.menu.help.about"/></span></a></li>
        </ul>
    </li>
    <li class="submenu last logout"><a href="<c:url value="/logout.html"/>"><span><fmt:message key="main.menu.logout"/></span></a></li>
</ul>
