<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader"><h2>Baza wiedzy</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3>
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
                    <h3>Komentarze</h3>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <a href="<c:url value="/help/base/articles/${article.id}/comments/new.html"/>"
                               class="lightview btnTicketAction btnTicketResolve rndCrn5px"
                               title=":: :: closeButton: false, width: 500, height: 350, keyboard: true">Dodaj komentarz</a>
                        <br/>
                        <c:choose>
                        <c:when test="${fn:length(article.comments) > 0}">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td class="lastcol">
                                        <dl class="kbComments">
                                            <c:forEach items="${article.comments}" var="comment">
                                                <dt id="c${comment.id}">
                                                    <span class="kbCommentsMeta">Autor: asdsadasdasd; Dodano: 2011.01.30</span>
                                                    <c:out value="${comment.title}"/>
                                                </dt>
                                                <dd><c:out value="${comment.body}"/></dd>
                                            </c:forEach>
                                        </dl>
                                    </td>
                                </tr>
                            </table>
                        </c:when>
                        <c:otherwise>
                            Nic tu jeszcze nie ma...
                        </c:otherwise>
                        </c:choose>
                        <div class="clearFloat"></div>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">
                <div class="pagecontentsubheader"><h3>Powiązane zgłoszenia</h3></div>
                <div class="contenttop"></div>
                <div class="contentmiddle">
                    <ul class="kbList">
                        <c:forEach items="${article.associatedTickets}" var="ticket">
                            <li>
                                <a href="<c:url value="/ticketDetails.html?ticketId=${ticket.ticketId}"/>"><c:out value="${ticket.subject}"/></a>
                                <span class="eventInfo">2011.01.09 / Lorem ipsum</span>
                            </li>
                        </c:forEach>
                        <li>Brak powiązanych zdarzeń.</li>
                    </ul>
                </div>
                <div class="contentbottom"></div>
            </td>
        </tr>
    </table>
</div>
