<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Załaczniki do zgłoszenia</h3>
</div>

<div class="contentmiddle">
    <c:if test="${ticket != null && not empty ticket.addFilesList}">
    <h3>Załączniki aktualne</h3>
    <ol class="attachList">
        <c:forEach items="${ticket.addFilesList}" var="a">
        <li>
            <span class="attachName">${a.originalFileName} 
                <span class="attachSize">(${a.humanReadableFileSize})</span></span>
            <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
        </li>
        <li>
            <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
            <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
        </li>
        </c:forEach>
    </ol>
    </c:if>
    <h3>Nowe załączniki</h3>
    <ol class="attachList">
        <c:forEach items="${currentFiles}" var="f" varStatus="i">
        <li id="attachment_id_${i.index}">
            <a class="attachDel" href="#"
                onclick="new Ajax.Request('/tickets/attachments/remove.html?a=${f.filename}&amp;e=attachment_id_${i.index}', {
                                asynchronous:true, evalScripts:true}); return false;">Usuń</a>
            <span class="attachName"><c:out value="${f.filename}"/> <span class="attachSize">(<c:out value="${f.filesize}"/>)</span></span>
        </li>
        </c:forEach>
    </ol>
    <form:form commandName="fileBean" enctype="multipart/form-data">
        <spring:bind path="fileBean.file">
            <input type="file" name="file"/>
        </spring:bind>
        <input type="submit" value="Dodaj"/>
    </form:form>
    <c:if test="${uploaded}">
        <script type="text/javascript">
            // window.parent.eval('Lightview.hide()');
        </script>
    </c:if>
    <br/>
    <a href="javascript:window.parent.eval('Lightview.hide()');" class="">zamknij</a>
</div>
