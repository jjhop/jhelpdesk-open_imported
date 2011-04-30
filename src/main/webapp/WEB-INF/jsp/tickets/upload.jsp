<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="pagecontentsubheader">
    <h3>Zarządzanie załacznikami do zgłoszenia</h3>
</div>

<div class="contentmiddle">

    <c:if test="${not empty attachments}">
        <h3>Załączniki aktualne</h3>
        <ol class="attachList">
            <li>
                <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
                <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
            </li>
            <li>
                <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
                <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
            </li>
        </ol>
    </c:if>

        <h3>Załączniki aktualne</h3>
        <ol class="attachList">
            <li>
                <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
                <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
            </li>
            <li>
                <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
                <span class="attachMeta">(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
            </li>
        </ol>

    <h3>Nowe załączniki</h3>
    <ol class="attachList">
        <li>
            <a class="attachDel" href="#">Usuń plik</a>
            <span class="attachName">Nazwa pliku <span class="attachSize">(8kb)</span></span>
        </li>
    </ol>

    <form:form commandName="fileBean" enctype="multipart/form-data">
        <spring:bind path="fileBean.file">
            <input type="file" name="file"/>
        </spring:bind>
        <input type="submit" value="Dodaj"/>
    </form:form>
    <c:if test="${uploaded}">
        <script type="text/javascript">
            window.parent.eval('Lightview.hide()');
        </script>
    </c:if>
    <a href="javascript:window.parent.eval('Lightview.hide()');" class="">anuluj</a>

</div>


