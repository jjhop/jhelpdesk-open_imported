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
                                <td><a class="btn" href="<c:url value="/manage/kb/category/edit.html"/>">Dodaj nową sekcję</a></td>
                            </tr>
                            <c:if test="${message != null}">
                                <tr><td style="color: #dc143c;"><c:out value="message"/>${message}</td></tr>
                            </c:if>
                        </table>
                        <c:if test="${not empty categories}">
                            <br />
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th class="rowNumber">Lp.</th>
                                    <th>Nazwa sekcji</th>
                                    <th class="artnumber">Ilość art.</th>
                                    <th colspan="5" class="lastcol">Akcje</th>
                                </tr>
                                <c:forEach var="c" items="${categories}">
                                    <tr>
                                        <td class="rowNumber">.</td>
                                        <td><c:out value="${c.categoryName}"/></td>
                                        <td class="artnumber"><c:out value="${c.articlesCount}"/></td>
                                        <td class="ticketEdit">
                                            <a class="actionNew" href="<c:url value="/manage/kb/category/${c.id}/articles.html"/>">Art</a>
                                        </td>
                                        <td class="ticketEdit">
                                            <a class="actionEdit" href="<c:url value="/manage/kb/category/${c.id}/edit.html"/>">E</a>
                                        </td>
                                        <td class="ticketEdit">
                                            <a class="actionDel" href="<c:url value="/manage/kb/category/${c.id}/remove.html"/>">R</a>
                                        </td>
                                        <td class="ticketEdit">
                                            <a class="actionUp" href="<c:url value="/manage/kb/category/${c.id}/up.html"/>">U</a>
                                        </td>
                                        <td class="lastcol ticketEdit">
                                            <a class="actionDown" href="<c:url value="/manage/kb/category/${c.id}/down.html"/>">D</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
