<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallsections" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="">
                <div id="pagecontentsubheader"><h3>Baza wiedzy - sekcje</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0">
                            <tr>
                                <td><a class="btn" href="<c:url value="/manage/kb/category/new.html"/>">Dodaj nową sekcję</a></td>
                            </tr>
                            <c:if test="${message != null}">
                                <tr><td style="color: #dc143c;"><c:out value="message"/>${message}</td></tr>
                            </c:if>
                        </table>
                        <c:if test="${not empty categories}">
                            <br/>
                            <display:table id="c" name="categories" class="standardtable"
                                           pagesize="${listSize}" size="categoriesListSize" sort="external" partialList="true"
                                           requestURI="${requestURI}" excludedParams="*" cellspacing="0">
                                <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                    <c:out value="${c_rowNum + offset}"/>
                                </display:column>
                                <display:column property="categoryName" title="Nazwa kategorii"/>
                                <display:column property="articlesCount" title="Ilość art." class="artnumber"/>
                                <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                    <a href="<c:url value="/manage/kb/category/${c.id}/articles.html"/>" class="actionNew">Art</a>
                                </display:column>
                                <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                    <a class="actionEdit" href="<c:url value="/manage/kb/category/${c.id}/edit.html"/>">E</a>
                                </display:column>
                                <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                    <a class="actionDel" href="<c:url value="/manage/kb/category/${c.id}/remove.html"/>">R</a>
                                </display:column>
                                <display:column class="ticketEdit" headerClass="lastcol ticketEdit">
                                    <c:if test="${c.order > 1}">
                                        <a class="actionUp" href="<c:url value="/manage/kb/category/${c.id}/up.html"/>">U</a>
                                    </c:if>
                                </display:column>
                                <display:column class="lastcol ticketEdit" headerClass="lastcol ticketEdit">
                                    <c:if test="${c.order < categoriesListSize}">
                                        <a class="actionDown" href="<c:url value="/manage/kb/category/${c.id}/down.html"/>">D</a>
                                    </c:if>
                                </display:column>
                            </display:table>
                        </c:if>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
