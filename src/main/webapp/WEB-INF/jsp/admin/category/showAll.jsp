<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallcategories" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Kategorie zgłoszeń</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0">
                            <tr>
                                <td><a class="btn" href="<c:url value="/manage/category/new.html"/>">Dodaj kategorię</a></td>
                            </tr>
                        </table>
                        <br/>
                        <display:table id="c" name="categories" class="standardtable"
                                       pagesize="${listSize}" size="categoriesListSize" sort="external" partialList="true"
                                       requestURI="${requestURI}" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${c_rowNum + offset}"/>
                            </display:column>
                            <display:column property="categoryName" title="Nazwa kategorii"/>
                            <display:column property="ticketsCount" title="Ilość"/>
                            <display:column title="Aktywna">
                                <c:if test="${not c.active}">NIE</c:if>
                                <c:if test="${c.active}">TAK</c:if>
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
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
