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
                        <c:url value="/manage/kb/category/${categoryId}/articles.html" var="requestURI"/>
                        <display:table id="a" name="articles" class="standardtable"
                                       pagesize="${listSize}" size="articlesListSize" sort="external" partialList="true"
                                       requestURI="${requestURI}" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${a_rowNum + offset}"/>
                            </display:column>
                            <display:column property="title" title="Tytuł"/>
                            <display:column property="author" title="Autor"/>
                            <display:column title="Date">
                                <fmt:formatDate value="${a.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionEdit" title="Edit" href="<c:url value="/manage/kb/category/${categoryId}/articles/${a.id}/edit.html"/>">E</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionDel" title="Remove" href="<c:url value="/manage/kb/category/${categoryId}/articles/${a.id}/remove.html"/>">R</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionUp" title="Move up" href="<c:url value="/manage/kb/article/up.html?articleId=${a.id}"/>">U</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <c:if test="${a.order < fn:length(articles)}">
                                    <a class="actionDown" title="Move down" href="<c:url value="/manage/kb/article/down.html?articleId=${a.id}"/>">D</a>
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
