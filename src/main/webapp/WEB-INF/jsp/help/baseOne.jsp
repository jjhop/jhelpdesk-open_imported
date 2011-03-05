<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
                <div id="pagecontentsubheader">
                    <h3>Komentarze</h3>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:if test="${fn:length(article.comments) > 0}">
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
                        </c:if>
                        <br>
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="lastcol">
                                    <h3>Dodaj komentarz</h3>
                                    <c:url var="formURL" value="/help/base/articles/${article.id}/show.html#commentForm"/>
                                    <form:form action="${formURL}" commandName="comment" id="commentForm">
                                        <ul class="formContainer">
                                            <li>
                                                <label for="title">Tytuł</label>
                                                <form:input path="title" cssClass="w99p" size="50"/>
                                                <form:errors path="title" cssClass="cError"/>
                                            </li>
                                            <li>
                                                <label for="comment">Komentarz</label>
                                                <form:textarea rows="5" cols="40" cssClass="w99p" path="body"/>
                                                <form:errors path="body" cssClass="cError"/>
                                            </li>
                                            <li class="right">
                                                <input type="submit" class="btn" value="Dodaj komentarz"/>
                                            </li>
                                        </ul>
                                    </form:form>
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
