<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader"><h2>Baza wiedzy</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader">
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
                                            ${article.body}
                                            
                                            <hr/>
                                            <h4>Dodaj komentarz</h4>
                                            <form action="" method="post">
                                                <input type="hidden" name="articleId" value="${article.articleId}">
                                                <textarea rows="4" cols="40"></textarea><br/>
                                                <input type="submit" class="btn" value="Dodaj komentarz"/>
                                            </form>
                                        </c:when>
                                        <c:otherwise>${message}</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
                <div id="pagecontentsubheader">
                    <h3>Komentarze</h3>
                    <dl>
                    <c:forEach items="${article.comments}" var="comment">
                        <dt><c:out value="${comment.title}"/></dt>
                        <dd><c:out value="${comment.body}"/></dd>
                    </c:forEach>
                    </dl>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="lastcol">
                                    a to?
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">
                <div id="pagecontentsubheader"><h3>Powiązane zgłoszenia</h3></div>
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
