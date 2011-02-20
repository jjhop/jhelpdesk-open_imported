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
                                            <form action="<c:url value="/help/base/comment.html"/>" method="post">
                                                <input type="hidden" name="articleId" value="${article.articleId}">
                                                <input type="text" name="title" size="50"/><br/>
                                                <textarea rows="4" cols="40" name="comment"></textarea><br/>
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
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="lastcol">
                                    
                                    <dl class="kbComments">
                                    <c:forEach items="${article.comments}" var="comment">
                                        <dt><c:out value="${comment.title}"/></dt>
                                        <dd><c:out value="${comment.body}"/></dd>
                                    </c:forEach>
                                        <dt>lorem ipsum er dolor sit maet</dt>
                                        <dd>Nulla at nulla justo, eget luctus tortor. Nulla facilisi. Duis aliquet egestas purus in blandit. Curabitur vulputate, ligula lacinia scelerisque tempor, lacus lacus ornare ante, ac egestas est urna sit amet arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed molestie augue sit amet leo consequat posuere. Vestibulum ante ipsum primis.</dd>
                                        <dt>lorem ipsum er dolor sit maet</dt>
                                        <dd>Nulla at nulla justo, eget luctus tortor. Nulla facilisi. Duis aliquet egestas purus in blandit. Curabitur vulputate, ligula lacinia scelerisque tempor, lacus lacus ornare ante, ac egestas est urna sit amet arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed molestie augue sit amet leo consequat posuere. Vestibulum ante ipsum primis.</dd>
                                    </dl>

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
