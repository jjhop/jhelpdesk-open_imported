<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3 id="headKBCommentAnd">Dodaj komentarz</h3>
</div>

<div class="contentmiddle h350">
<c:url value="/help/base/articles/${articleId}/comments/new.html" var="formURL"/>
<form:form action="${formURL}" commandName="comment" id="commentForm">
    <table cellspacing="0" class="standardtable">
        <tr>
            <td class="lastcol">

                <ul class="formContainer">
                    <li>
                        <form:label path="title">
                            Tytuł
                            <span class="lblTip">(tytuł komentarza jest wymagany, ale ograniczony do 255 znaków)</span>
                        </form:label>
                        <form:input path="title" cssClass="w99p" size="50"/>
                        <form:errors path="title" cssClass="formError errorBottom"/>
                    </li>
                    <li>
                        <form:label path="body">
                            Komentarz
                            <span class="lblTip">(komentarz jest wymagany, ale ograniczony do 4096 znaków)</span>
                        </form:label>
                        <form:textarea rows="5" cols="40" cssClass="w99p" path="body"/>
                        <form:errors path="body" cssClass="formError errorBottom"/>
                    </li>
                </ul>
            </td>
        </tr>
    </table>
    <div class="bottomButtons">
        <input type="submit" class="btn" value="Dodaj komentarz"/>
        <a class="btnPlain" href="javascript:window.parent.eval('Lightview.hide()');">Anuluj</a>
    </div>
</form:form>
</div>
