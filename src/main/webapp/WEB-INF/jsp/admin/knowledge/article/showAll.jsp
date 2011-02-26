<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallarticles" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="">
                <div id="pagecontentsubheader"><h3>Baza wiedzy - artykuły</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="spacing">
                            <tr>
                                <td class="right">
                                    <a href="<c:url value="/manage/kb/category/${categoryId}/articles/new.html"/>"
                                       class="btn">Dodaj nowy artykuł</a>
                                </td>
                            </tr>
                        </table>
                        <c:if test="${not empty articles}">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th>Lp.</th>
                                    <th>Tytuł</th>
                                    <th>Autor</th>
                                    <th>Data</th>
                                    <th colspan="4" class="lastcol">Akcje</th>
                                </tr>
                                <c:forEach var="article" items="${articles}">
                                    <tr>
                                        <td width="22">1</td>
                                        <td><c:out value="${article.title}"/></td>
                                        <td width="150"><c:out value="${article.author}"/></td>
                                        <td width="110"><fmt:formatDate value="${article.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                                        <td class="ticketEdit">
                                            <a class="actionEdit" title="Edit" href="<c:url value="/manage/kb/category/${categoryId}/articles/${article.id}/edit.html"/>">E</a>
                                        </td>
                                        <td class="ticketEdit">
                                            <a class="actionDel" title="Remove" href="<c:url value="/manage/kb/category/${categoryId}/articles/${article.id}/remove.html"/>">R</a>
                                        </td>
                                        <td class="ticketEdit">
                                            <a class="actionUp" title="Move up" href="<c:url value="/manage/kb/article/up.html?articleId=${article.id}"/>">U</a>
                                        </td>
                                        <td class="lastcol ticketEdit">
                                            <a class="actionDown" title="Move down" href="<c:url value="/manage/kb/article/down.html?articleId=${article.id}"/>">D</a>
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
