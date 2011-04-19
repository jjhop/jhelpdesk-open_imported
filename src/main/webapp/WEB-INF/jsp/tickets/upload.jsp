<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <body>
        <h1>Zarządzanie załacznikami do zgłoszenia</h1>
        <c:if test="${not empty attachments}">
            <h2>Załączniki aktualne</h2>
            <ol>
                <li>Nazwa pliku - 8kb
                    <span>(dodany: 20.10.2010 przez: Rafał Kotusiewicz)</span>
                </li>
                <li>Nazwa pliku - 12kb
                    <span>(dodany: 21.10.2010 przez: Rafał Kotusiewicz)</span>
                </li>
            </ol>
        </c:if>
        <h2>Nowe załączniki</h2>
        <ol>
            <li>Nazwa pliku - 8kb
                <a href="#">Usuń plik</a>
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
    </body>
</html>