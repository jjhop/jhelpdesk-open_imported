<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/tickets/${ticketId}/comments/save.html" var="formURL"/>
<form:form commandName="comment" action="${formURL}" method="post">
    <ul class="formContainer">
        <li>
            <form:textarea id="addComm" path="commentText"
                   cssClass="addComment" cssErrorClass="addComment fieldError"
                   rows="3" cols="40"/>
            <form:errors cssClass="formError errorBottom" path="commentText"/>
        </li>
        <li>
            <form:checkbox path="notForPlainUser" cssClass="notForPlainUser floatLeft" />
            <form:label path="notForPlainUser" cssClass="floatLeft">tylko dla pracowników helpdesku</form:label>
        </li>
        <li class="modalButtons">
            <input type="submit" value="dodaj komentarz" class="btn floatRight" />
            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain btnPlainBox floatRight">anuluj</a>
        </li>


    </ul>
</form:form>