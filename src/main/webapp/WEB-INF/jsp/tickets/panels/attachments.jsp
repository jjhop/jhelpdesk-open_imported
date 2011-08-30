<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:choose>
<c:when test="${not empty attachments}">
    <table cellspacing="0" class="standardtable marginBot10p">
        <tr>
            <th>Nazwa</th>
            <th class="w75 right lastcol">Rozmiar</th>
        </tr>
        <c:forEach var="file" items="${attachments}" varStatus="status">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${file.contentTypeClass eq 'IMAGE'}">
                            <a class="fileType ft<c:out value="${file.contentTypeClass}"/> lightview"
                               href="<c:url value="/tickets/${ticketId}/attachments/${file.fileId}/show.html"/>"
                               rel="gallery['attachments']" title=" :: :: autosize: true">${file.originalFileName}</a>
                        </c:when>
                        <c:otherwise>
                            <a class="fileType ft<c:out value="${file.contentTypeClass}"/>"
                               href="<c:url value="/tickets/${ticketId}/attachments/${file.fileId}/get.html"/>">
                                    ${file.originalFileName}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="right lastcol"><c:out value="${file.humanReadableFileSize}"/></td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${attachmentsPages > 1}">
    <ul class="panelPager">
        <c:if test="${currentAttachmentsPage > 1}">
            <li><a href="javascript:remoteLoad('ticketPanelFiles', '<c:url value="/tickets/${ticketId}/attachments.html?page=${currentAttachmentsPage-1}"/>');">&laquo; &lsaquo;</a></li>
        </c:if>
        <%
            int attachmentsPages= (Integer) request.getAttribute("attachmentsPages");
            for (int cPage = 1; cPage <= attachmentsPages; ++cPage) {
        %>
            <li><a href="javascript:remoteLoad('ticketPanelFiles', '<c:url value="/tickets/${ticketId}/attachments.html?page="/><%=cPage%>');"><%=cPage%></a></li>
        <% } %>
        <c:if test="${currentAttachmentsPage < attachmentsPages}">
            <li><a href="javascript:remoteLoad('ticketPanelFiles', '<c:url value="/tickets/${ticketId}/attachments.html?page=${currentAttachmentsPage+1}"/>');">&rsaquo; &raquo;</a></li>
        </c:if>
    </ul>
    </c:if>
</c:when>
<c:otherwise>
    <p class="noFiles">
        Możesz załączyć pierwszy plik...
    </p>
</c:otherwise>
</c:choose>
<div class="clearFloat"></div>