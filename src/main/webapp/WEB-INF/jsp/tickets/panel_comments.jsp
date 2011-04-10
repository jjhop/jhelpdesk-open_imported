<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<table width="100%" cellspacing="12" cellpadding="4">
    <tr>
        <td>
            <c:if test="${not empty ticket.comments}">
                    <table cellspacing="0" class="standardtable" style="margin-bottom: 10px;">
                        <tr>
                            <th>Autor</th>
                            <th>Data</th>
                            <th class="lastcol">Treść</th>
                        </tr>
                        <c:forEach var="comment" items="${ticket.comments}" varStatus="status">
                            <tr>
                                <td class="tit"><c:out value="${comment.commentAuthor}"/></td>
                            <td><fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td class="bod"><c:out value="${comment.commentText}" escapeXml="false"/></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <ul class="panelPager">
                        <li><a href="#">&laquo; poprzednia</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">następna &raquo;</a></li>
                    </ul>
                </c:if>
            <a href="<c:url value="/tickets/${ticket.ticketId}/comments/new.html"/>"
               class="lightview" title=":: :: width: 400, height: 300, keyboard: true">Dodaj komentarz</a>
        </td>
    </tr>
</table>