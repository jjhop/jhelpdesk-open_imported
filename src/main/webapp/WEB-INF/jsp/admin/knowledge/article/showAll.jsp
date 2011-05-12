<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showallarticles" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="">
                <div class="pagecontentsubheader"><h3>Baza wiedzy - artykuły</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0">
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
                                <c:if test="${a.order > 1}">
                                    <a class="actionUp" title="Move up" href="<c:url value="/manage/kb/category/${categoryId}/articles/${a.id}/up.html"/>">U</a>
                                </c:if>
                            </display:column>
                            <display:column class="ticketEdit">
                                <c:if test="${a.order < fn:length(articles)}">
                                    <a class="actionDown" title="Move down" href="<c:url value="/manage/kb/category/${categoryId}/articles/${a.id}/down.html"/>">D</a>
                                </c:if>
                            </display:column>

                            <display:setProperty name="paging.banner.no_items_found">
                                <fmt:message key="kb.articles.list.paging.banner.no_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.one_item_found">
                                <fmt:message key="kb.articles.list.paging.banner.one_item_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.all_items_found">
                                <fmt:message key="kb.articles.list.paging.banner.all_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.some_items_found">
                                <fmt:message key="kb.articles.list.paging.banner.some_items_found"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.full">
                                <fmt:message key="kb.articles.list.paging.banner.full"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.first">
                                <fmt:message key="kb.articles.list.paging.banner.first"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.last">
                                <fmt:message key="kb.articles.list.paging.banner.last"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.onepage">
                                <fmt:message key="kb.articles.list.paging.banner.onepage"/>
                            </display:setProperty>
                            <display:setProperty name="paging.banner.page.separator" value=" &nbsp;" />
                            <display:setProperty name="paging.banner.placement" value="top" />
                            <display:setProperty name="basic.msg.empty_list">
                                <fmt:message key="kb.articles.list.basic.msg.empty_list"/>
                            </display:setProperty>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
