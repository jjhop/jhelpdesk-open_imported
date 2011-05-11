<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url value="/tickets/${ticketId}/comments/save.html" var="formURL"/>
<div class="contentmiddle">
    <form:form commandName="comment" action="${formURL}" method="post">
        <table class="standardtable" cellspacing="0">
            <tr>
                <td>
                    <ul class="formContainer">
                        <li>
                            <label>Komentarz
                                <span class="lblTip">(wprowadź email, aby sprawdzić czy użytkownik istnieje)</span>
                            </label>
                            <form:textarea id="addComm" path="commentText"
                                   cssClass="addComment" cssErrorClass="addComment fieldError"
                                   onkeyup="charTextCount(this.form.addComm, 'commentCounter', 4096)" onblur="$('commentCounter').hide()"
                                   rows="3" cols="40"/>
                            <form:errors cssClass="formError errorBottom" path="commentText"/>
                            <span id="commentCounter" class="counter"></span>
                        </li>
                        <li class="chk">
                            <form:checkbox path="notForPlainUser" cssClass="notForPlainUser floatLeft" />
                            <form:label path="notForPlainUser" cssClass="floatLeft">tylko dla pracowników helpdesku</form:label>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
                            <input type="submit" value="dodaj komentarz" class="btn btnMarginTop floatLeft" />
                            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain btnMarginTop floatLeft">anuluj</a>
        <div class="clearFloat"></div>
    </form:form>
</div>