<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="de.berlios.jhelpdesk.model.TicketComment" %>
<%@ page import="de.berlios.jhelpdesk.model.User" %>

<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<%
    User loggedUser = (User) session.getAttribute("loggedUser");
%>

<table width="100%" cellspacing="12" cellpadding="4">
    <tr>
        <td>
            <c:if test="${not empty comments}">
                <table id="ticketComments" cellspacing="0" class="standardtable" style="margin-bottom: 10px;">
                    <c:forEach var="comment" items="${comments}" varStatus="status">
                    <tr <c:if test="${comment.notForPlainUser}">class="nfp"</c:if>>
                        <%
                            TicketComment c = (TicketComment) pageContext.getAttribute("comment");
                                if (c.isNotForPlainUser() && loggedUser.isPlain()) {
                        %>
                        <td>
                            <span class="entryMeta">
                                ${comment.commentAuthor}, <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                            <span class="entryBlock">
                                ************
                            </span>
                        </td>
                        <% } else { %>
                        <td>
                            <span class="entryMeta">
                                ${comment.commentAuthor}, <fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                            <span class="entryBlock">
                                <c:out value="${comment.commentText}" escapeXml="true"/>
                            </span>
                        </td>
                        <% } %>
                    </tr>
                    </c:forEach>
                </table>
                <c:if test="${commentsPages > 1}">
                <ul class="panelPager">
                    <c:if test="${currentCommentsPage > 1}">
                        <li><a href="javascript:remoteLoad('panel_comments', '<c:url value="/tickets/${ticketId}/comments.html?page=${currentCommentsPage-1}"/>');">&laquo; &lsaquo;</a></li>
                    </c:if>
                    <%
                        int commentsPages = (Integer) request.getAttribute("commentsPages");
                        for (int cPage = 1; cPage <= commentsPages; ++cPage) {
                    %>
                        <li><a href="javascript:remoteLoad('panel_comments', '<c:url value="/tickets/${ticketId}/comments.html?page="/><%=cPage%>');"><%=cPage%></a></li>
                    <% } %>
                    <c:if test="${currentCommentsPage < commentsPages}">
                        <li><a href="javascript:remoteLoad('panel_comments', '<c:url value="/tickets/${ticketId}/comments.html?page=${currentCommentsPage+1}"/>');">&rsaquo; &raquo;</a></li>
                    </c:if>
                </ul>
                </c:if>
            </c:if>
            <a href="<c:url value="/tickets/${ticketId}/comments/new.html"/>"
               class="btn lightview" title=":: :: closeButton: false, width: 500, height: 495, keyboard: true">Dodaj komentarz</a>
        </td>
    </tr>
</table>
