<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallusers" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0" class="w100p">
        <tr>
            <td class="">
                <div class="pagecontentsubheader"><h3>Użytkownicy</h3><a class="btn" href="<c:url value="/manage/users/new.html"/>">Dodaj użytkownika</a></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/manage/users/list.html" var="requestURI"/>
                        <display:table id="user" name="users" class="standardtable" cellspacing="0" export="false"
                                       partialList="true"
                                       pagesize="${listSize}" size="usersListSize" requestURI="${requestURI}">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${user_rowNum + offset}" />
                            </display:column>
                            <display:column title="Imię i nazwisko" style="width: 200px;">
                                <span <c:if test="${user.active == false}">class="inactive"</c:if>>${user.fullName}</span>
                            </display:column>
                            <display:column title="Email">
                                <span <c:if test="${user.active == false}">class="inactive"</c:if>>${user.email}</span>
                            </display:column>
                            <display:column title="" media="html" class="ticketEdit" headerClass="ticketView">
                                <a class="actionView" href="<c:url value="/manage/users/${user.userId}/show.html"/>">View</a>
                            </display:column>
                            <display:column title="" media="html" class="ticketEdit" headerClass="ticketEdit">
                                <a class="actionEdit" href="<c:url value="/manage/users/${user.userId}/edit.html"/>">Edit</a>
                            </display:column>
                            <display:column title="" media="html" class="lastcol ticketEdit" headerClass="lastcol ticketDrop">
                                <a  class="actionDel" href="<c:url value="/manage/users/${user.userId}/remove.html"/>">Remove</a>
                            </display:column>

                            <display:setProperty name="paging.banner.no_items_found">
                                <fmt:message key="user.list.paging.banner.no_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.one_item_found">
                                <fmt:message key="user.list.paging.banner.one_item_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.all_items_found">
                                <fmt:message key="user.list.paging.banner.all_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.some_items_found">
                                <fmt:message key="user.list.paging.banner.some_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.full">
                                <fmt:message key="user.list.paging.banner.full"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.first">
                                <fmt:message key="user.list.paging.banner.first"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.last">
                                <fmt:message key="user.list.paging.banner.last"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.onepage">
                                <fmt:message key="user.list.paging.banner.onepage"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                            <display:setProperty name="paging.banner.placement" value="top" />
                            <display:setProperty name="basic.msg.empty_list">
                                <fmt:message key="user.list.basic.msg.empty_list"/>
                            </display:setProperty>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
