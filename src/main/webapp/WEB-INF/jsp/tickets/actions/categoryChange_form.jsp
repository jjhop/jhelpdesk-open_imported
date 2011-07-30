<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Zmiana kategorii zgłoszenia</h3>
</div>
<div class="contentmiddle">
    <c:url value="/tickets/${ticketId}/categoryChange.html" var="formURL"/>
    <form:form commandName="form" action="${formURL}" method="post">
        <table class="standardtable" cellspacing="0">
            <tr>
                <td>
                    <ul class="formContainer">
                        <li>
                            <label>Bieżąca kategoria:</label>
                            <span>${currentCategory}</span>
                        </li>
                        <li>
                            <label>
                                Nowa kategoria
                                <span class="lblTip">(wybierz nową kategorię z poniższej listy)</span>
                            </label>
                            <form:select id="ddlUser" path="category"
                                         items="${categories}" itemValue="id" itemLabel="categoryName"/>
                        </li>
                        <li>
                            <label>Komentarz
                                <span class="lblTip">(komentarz jest wymagany, jego maksymalna długość do 4096 znaków)</span>
                            </label>
                            <form:textarea id="comment" path="commentText"
                                           cssClass="addComment" cssErrorClass="addComment fieldError"
                                           onkeyup="charTextCount(this.form.comment, 'commentCounter', 4096)"
                                           onblur="$('commentCounter').hide()"
                                           rows="3" cols="40"/>
                            <form:errors cssClass="formError errorBottom" path="commentText"/>
                            <span id="commentCounter" class="counter"></span>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
        <input type="submit" value="Zmień" class="btn btnMarginTop floatLeft"/>
        <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain btnMarginTop floatLeft">anuluj</a>
    </form:form>
    <div class="clearFloat"></div>
</div>