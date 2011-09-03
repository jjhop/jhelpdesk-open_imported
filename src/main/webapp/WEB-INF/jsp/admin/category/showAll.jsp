<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallcategories" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3 id="headAdminCat">Kategorie zgłoszeń</h3>
                    <a class="btn" href="<c:url value="/manage/category/new.html"/>">Dodaj...</a>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <display:table id="c" name="categories" class="standardtable"
                                       pagesize="${listSize}" size="categoriesListSize" sort="external" partialList="true"
                                       requestURI="${requestURI}" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${c_rowNum + offset}"/>
                            </display:column>
                            <display:column title="Nazwa kategorii">
                                <c:if test="${not c.active}"><span class="inactive"></c:if>
                                <c:if test="${c.default}"><span class="default"></c:if>
                                    ${c.categoryName} (${c.ticketsCount} zgłoszeń)
                                <c:if test="${not c.active}"></span></c:if>
                                <c:if test="${c.default}"></span></c:if>
                            </display:column>
                            <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                <a href="<c:url value="/manage/category/${c.id}/show.html"/>" class="actionView">V</a>
                            </display:column>
                            <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                <a href="<c:url value="/manage/category/${c.id}/edit.html"/>" class="actionEdit">E</a>
                            </display:column>
                            <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                <a href="<c:url value="/manage/category/${c.id}/remove.html"/>" class="actionDel">R</a>
                            </display:column>
                            <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                <c:if test="${c.order > 1}">
                                    <a href="<c:url value="/manage/category/${c.id}/up.html"/>" class="actionUp">U</a>
                                </c:if>
                            </display:column>
                            <display:column class="lastcol ticketEdit" headerClass="lastcol ticketEdit">
                                <c:if test="${c.order < categoriesListSize}">
                                    <a href="<c:url value="/manage/category/${c.id}/down.html"/>" class="actionDown">E</a>
                                </c:if>
                            </display:column>
                            <display:setProperty name="paging.banner.no_items_found">
                                <fmt:message key="ticket.category.list.paging.banner.no_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.one_item_found">
                                <fmt:message key="ticket.category.list.paging.banner.one_item_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.all_items_found">
                                <fmt:message key="ticket.category.list.paging.banner.all_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.some_items_found">
                                <fmt:message key="ticket.category.list.paging.banner.some_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.full">
                                <fmt:message key="ticket.category.list.paging.banner.full"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.first">
                                <fmt:message key="ticket.category.list.paging.banner.first"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.last">
                                <fmt:message key="ticket.category.list.paging.banner.last"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.onepage">
                                <fmt:message key="ticket.category.list.paging.banner.onepage"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                            <display:setProperty name="paging.banner.placement" value="top" />
                            <display:setProperty name="basic.msg.empty_list">
                                <fmt:message key="ticket.category.list.basic.msg.empty_list"/>
                            </display:setProperty>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
