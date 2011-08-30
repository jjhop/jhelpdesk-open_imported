<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="management">
    <div id="pagecontentheader" class="preferences"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3>Filtry zgłoszeń</h3>
                    <a href="<c:url value="/preferences/filters/new.html"/>" class="btn">Dodaj...</a>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <display:table id="filtersIterator" name="filters" class="standardtable"
                                       pagesize="${listSize}" size="filtersListSize" sort="external" partialList="true"
                                       requestURI="" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${filtersIterator_rowNum + offset}"/>
                            </display:column>
                            <display:column title="Tytuł">${filtersIterator.name}</display:column>
                            <display:column title="Data utworzenia" style="width: 120px;">
                                <fmt:formatDate value="${filtersIterator.createdAt}" pattern="dd/MM/yyyy hh:mm"/>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionEdit" href="<c:url value="/preferences/filters/${filtersIterator.id}/edit.html"/>">E</a>
                            </display:column>
                            <display:column class="lastcol ticketEdit" headerClass="lastcol">
                                <a href="<c:url value="/preferences/filters/${filtersIterator.id}/delete.html"/>" class="actionDel">R</a>
                            </display:column>

                            <display:setProperty name="paging.banner.no_items_found">
                                <fmt:message key="filter.list.paging.banner.no_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.one_item_found">
                                <fmt:message key="filter.list.paging.banner.one_item_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.all_items_found">
                                <fmt:message key="filter.list.paging.banner.all_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.some_items_found">
                                <fmt:message key="filter.list.paging.banner.some_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.full">
                                <fmt:message key="filter.list.paging.banner.full"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.first">
                                <fmt:message key="filter.list.paging.banner.first"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.last">
                                <fmt:message key="filter.list.paging.banner.last"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.onepage">
                                <fmt:message key="filter.list.paging.banner.onepage"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                            <display:setProperty name="paging.banner.placement" value="top" />
                            <display:setProperty name="basic.msg.empty_list">
                                <fmt:message key="filter.list.basic.msg.empty_list"/>
                            </display:setProperty>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
