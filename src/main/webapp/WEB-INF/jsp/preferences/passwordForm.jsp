<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="pagecontentsubheader"><h3 id="headPrefPass">Zmiana hasła</h3></div>
<div class="contentmiddle h335">
    <c:url value="/preferences/personalData/password/change.html" var="formURL"/>
    <form:form commandName="passwordForm" action="${formURL}" method="post">
        <table cellspacing="0" class="standardtable">
            <tr>
                <td>
                    <div class="passwordErrors">
                        <form:errors path="currentPassword"/>
                        <form:errors path="newPassword"/>
                    </div>
                    <ul class="formContainer">
                        <li>
                            <form:label path="currentPassword">Aktualne hasło</form:label>
                            <form:password path="currentPassword" maxlength="64" cssClass="w98p" cssErrorClass=""/>
                        </li>
                        <li>
                            <form:label path="newPassword">Hasło</form:label>
                            <form:password path="newPassword" maxlength="64" cssClass="w98p"/>
                        </li>
                        <li>
                            <form:label path="newPasswordRepeated">Powtórz hasło</form:label>
                            <form:password path="newPasswordRepeated" maxlength="64" cssClass="w98p"/>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
        <div class="bottomButtons">
            <input type="submit" value="zmień hasło" class="btn" />
            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain">anuluj</a>
        </div>
    </form:form>
</div>