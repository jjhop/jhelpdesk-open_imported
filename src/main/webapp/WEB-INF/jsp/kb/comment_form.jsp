<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<c:url value="/help/base/articles/${articleId}/comments/new.html" var="formURL"/>
<form:form action="${formURL}" commandName="comment" id="commentForm">
    <table cellspacing="0" class="standardtable">
        <tr>
            <td class="lastcol">
                <h3>Dodaj komentarz</h3>
                <ul class="formContainer">
                    <li>
                        <form:label path="title">
                            Tytuł
                            <span class="lblTip">(tytuł komentarza jest wymagany, ale ograniczony do 255 znaków)</span>
                        </form:label>
                        <form:input path="title" cssClass="w99p" size="50"/>
                        <form:errors path="title" cssClass="cError"/>
                    </li>
                    <li>
                        <form:label path="body">
                            Komentarz
                            <span class="lblTip">(komentarz jest wymagany, ale ograniczony do 4096 znaków)</span>
                        </form:label>
                        <form:textarea rows="5" cols="40" cssClass="w99p" path="body"/>
                        <form:errors path="body" cssClass="cError"/>
                    </li>
                </ul>
            </td>
        </tr>
    </table>
    <input type="submit" class="btn btnMarginTop floatLeft" value="Dodaj komentarz"/>
    <a href="javascript:window.parent.eval('Lightview.hide()');">Anuluj</a>
</form:form>