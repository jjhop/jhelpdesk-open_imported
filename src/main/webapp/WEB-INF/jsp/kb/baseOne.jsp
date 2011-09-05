<%@ page import="de.berlios.jhelpdesk.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader" class="kb"><h2>Baza wiedzy</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3 id="headKBArticle">
                        <c:choose>
                            <c:when test="${article != null}">
                                ${article.title}
                            </c:when>
                            <c:otherwise>${message}</c:otherwise>
                        </c:choose>
                    </h3>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="lastcol">
                                    <c:choose>
                                        <c:when test="${article != null}">
                                            ${article.lead}
                                            <br/>
                                            ${article.htmlBody}
                                        </c:when>
                                        <c:otherwise>${message}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
                <div class="pagecontentsubheader">
                    <h3 id="headCommentList">Komentarze</h3>
                    <a href="<c:url value="/help/base/articles/${article.id}/comments/new.html"/>"
                       class="lightview btn"
                       title=":: :: closeButton: false, width: 500, height: 415, keyboard: true">Dodaj...</a>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                            <table cellspacing="0" class="standardtable marginBot10p">
                                <tr>
                                    <td class="lastcol noSpacing">
                                        <c:choose>
                                        <c:when test="${fn:length(article.comments) > 0}">
                                            <dl class="kbComments">
                                                <c:forEach items="${article.comments}" var="comment">
                                                    <dt id="c${comment.id}">
                                                        <span class="kbCommentsMeta">Autor: ${article.author}; Dodano: ${article.createdAt}</span>
                                                        <c:out value="${comment.title}"/>
                                                    </dt>
                                                    <dd><c:out value="${comment.body}"/></dd>
                                                </c:forEach>
                                            </dl>
                                        </c:when>
                                        <c:otherwise>
                                            <p>Nic tu jeszcze nie ma...</p>
                                        </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </table>
                        <div class="clearFloat"></div>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">
                <div class="pagecontentsubheader">
                    <h3 id="headTicketArticles">Powiązane zgłoszenia</h3>
                    <auth:check requiredRole="10">
                    <a href="<c:url value="/help/base/articles/${article.id}/tickets/new.html"/>"
                       class="lightview btn rndCrn5px"
                       title=":: :: closeButton: false, width: 500, height: 400, keyboard: true">Dodaj...</a>
                    </auth:check>
                </div>
                <div class="contenttop"></div>
                <div class="contentmiddle">
                    <ul class="kbList">
                        <c:choose>
                            <c:when test="${article.associatedTickets != null && fn:length(article.associatedTickets) > 0}">
                                <c:forEach items="${article.associatedTickets}" var="ticket">
                                    <li>
                                        <a href="<c:url value="/tickets/${ticket.ticketId}/details.html"/>"><c:out value="${ticket.subject}"/></a>
                                        <span class="eventInfo">${ticket.createdAt} / ${ticket.notifier}</span>
                                    </li>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <li>Brak powiązanych zdarzeń.</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                    <div class="clearFloat"></div>
                </div>
                <div class="contentbottom"></div>
            </td>
        </tr>
    </table>
</div>
