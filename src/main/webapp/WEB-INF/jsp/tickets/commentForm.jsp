<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/tickets/${ticketId}/comments/save.html" var="formURL"/>
<form:form commandName="comment" action="${formURL}" method="post">
    <form:textarea id="addComm" path="commentText"
                   cssClass="addComment" cssStyle="height: 120px"
                   rows="3" cols="40"/>
    <form:errors path="commentText"/>
    <form:checkbox path="notForPlainUser"/>
    <form:label path="notForPlainUser">tylko dla pracowników helpdesku</form:label>
    <input type="submit" value="dodaj komentarz" class="btn"/>
    <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain floatLeft">anuluj</a>
</form:form>