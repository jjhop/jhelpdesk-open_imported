<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${not empty message}">
    <c:out value="${message}"/>
</c:if>

<div id="alltickets" class="ticketslist">
    <div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
    <div class="pagecontentsubheader">
        <fmt:message key="tickets.list.custom" var="custom"/>
        <h3><c:out value="${filter.name}" default="${custom}"/></h3>
        <a id="filterbutton" class="btn" href="javascript:toggleForm();">Filtr</a>
    </div>
    <div id="content">
        <div class="contenttop"></div>
        <div class="contentmiddle">
            <display:table
                id="ticketsIterator" name="tickets"
                pagesize="${listSize}" size="ticketsListSize" sort="external" partialList="true"
                requestURI="${requestURI}" excludedParams="*" cellspacing="0">
                <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                    <c:out value="${ticketsIterator_rowNum + offset}"/>
                </display:column>
                <display:column title="Przyczyna zgłoszenia" class="ticketsDetail" headerClass="ticketsDetail">
                    <span class="ticketCategory">
                        <em>Kategoria: </em><c:out value="${ticketsIterator.ticketCategory}"/>
                    </span>
                    <a href="<c:url value="/tickets/${ticketsIterator.ticketId}/details.html"/>">
                        <c:out value="${ticketsIterator.subject}"/>
                    </a>
                </display:column>
                <display:column title="Data" class="createDate" headerClass="createDate">
                    <fmt:formatDate value="${ticketsIterator.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                </display:column>
                <display:column title="Status" class="status" headerClass="status">
                    <span class="ticketStatus ts<c:out value="${ticketsIterator.ticketStatus}" />" title="<c:out value="${ticketsIterator.ticketStatus.statusName}" />">
                    </span>
                </display:column>
                <display:column title="Ważność" class="priority" headerClass="priority">
                    <span class="ticketPriority tp<c:out value="${ticketsIterator.ticketPriority}" />" title="<c:out value="${ticketsIterator.ticketPriority.priorityName}" />">
                    </span>
                </display:column>
                <display:column property="notifier" title="Zgłaszający" class="notifier" headerClass="notifier ticketView" />

                <display:setProperty name="paging.banner.no_items_found">
                    <fmt:message key="ticket.list.paging.banner.no_items_found"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.one_item_found">
                    <fmt:message key="ticket.list.paging.banner.one_item_found"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.all_items_found">
                    <fmt:message key="ticket.list.paging.banner.all_items_found"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.some_items_found">
                    <fmt:message key="ticket.list.paging.banner.some_items_found"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.full">
                    <fmt:message key="ticket.list.paging.banner.full"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.first">
                    <fmt:message key="ticket.list.paging.banner.first"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.last">
                    <fmt:message key="ticket.list.paging.banner.last"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.onepage">
                    <fmt:message key="ticket.list.paging.banner.onepage"/>
                </display:setProperty>
                <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                <display:setProperty name="paging.banner.placement" value="top" />
                <display:setProperty name="basic.msg.empty_list">
                    <fmt:message key="ticket.list.basic.msg.empty_list"/>
                </display:setProperty>
            </display:table>
        </div>
        <div class="contentbottom"></div>
    </div>
</div>
