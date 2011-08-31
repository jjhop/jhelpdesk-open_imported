<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:forEach items="${files}" var="f" varStatus="i">
    <li id="attachment_id_${i.index}">
        <a class="attachDel" href="#"
            onclick="new Ajax.Request('<c:url value="/tickets/attachments/remove.html?t=${ticketstamp}&amp;a=${f.filename}&amp;e=attachment_id_${i.index}"/>', {
                            asynchronous:true, evalScripts:true}); return false;">Usuń</a>
        <span class="attachName"><c:out value="${f.filename}"/> <span class="attachSize">(<c:out value="${f.filesize}"/>)</span></span>
    </li>
</c:forEach>