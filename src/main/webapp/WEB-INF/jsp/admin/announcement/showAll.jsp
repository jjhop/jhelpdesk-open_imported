<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showannouncements" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3 id="headAdminAnnoucement">Wiadomości</h3>
                    <a class="btn" href="<c:url value="/announcements/new.html"/>">Dodaj...</a>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <display:table id="announcementsIterator" name="announcements" class="standardtable"
                                       pagesize="${listSize}" size="announcementsListSize" sort="external" partialList="true"
                                       requestURI="" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${announcementsIterator_rowNum + offset}"/>
                            </display:column>
                            <display:column title="Tytuł">
                                <a href="<c:url value="/announcements/${announcementsIterator.id}/show.html"/>"><c:out value="${announcementsIterator.title}"/></a>
                            </display:column>
                            <display:column title="Data utworzenia" style="width: 100px;">
                                <fmt:formatDate value="${announcementsIterator.createDate}" pattern="dd/MM/yyyy"/>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionView" href="<c:url value="/announcements/${announcementsIterator.id}/show.html"/>">V</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionEdit" href="<c:url value="/announcements/${announcementsIterator.id}/edit.html"/>">E</a>
                            </display:column>
                            <display:column class="lastcol ticketEdit" headerClass="lastcol">
                                <a href="<c:url value="/announcements/${announcementsIterator.id}/remove.html"/>" class="actionDel">R</a>
                            </display:column>

                            <display:setProperty name="paging.banner.no_items_found">
                                <fmt:message key="announcements.list.paging.banner.no_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.one_item_found">
                                <fmt:message key="announcements.list.paging.banner.one_item_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.all_items_found">
                                <fmt:message key="announcements.list.paging.banner.all_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.some_items_found">
                                <fmt:message key="announcements.list.paging.banner.some_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.full">
                                <fmt:message key="announcements.list.paging.banner.full"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.first">
                                <fmt:message key="announcements.list.paging.banner.first"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.last">
                                <fmt:message key="announcements.list.paging.banner.last"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.onepage">
                                <fmt:message key="announcements.list.paging.banner.onepage"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                            <display:setProperty name="paging.banner.placement" value="top" />
                            <display:setProperty name="basic.msg.empty_list">
                                <fmt:message key="announcements.list.basic.msg.empty_list"/>
                            </display:setProperty>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
