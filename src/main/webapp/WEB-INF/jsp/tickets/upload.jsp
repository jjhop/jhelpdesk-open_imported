<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
    <body>
        <h1>Dawaj plik</h1>
        <form:form commandName="fileBean" enctype="multipart/form-data">
            <spring:bind path="fileBean.file">
                <input type="file" name="file"/>
            </spring:bind>
            <input type="submit"/>
        </form:form>
        <c:if test="${uploaded}">
            <script type="text/javascript">
                window.parent.eval('Lightview.hide()');
            </script>
        </c:if>
        <a href="javascript:window.parent.eval('Lightview.hide()');" class="">anuluj</a>
    </body>
</html>