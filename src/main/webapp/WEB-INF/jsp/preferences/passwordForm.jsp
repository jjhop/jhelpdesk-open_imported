<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="pagecontentsubheader"><h3>Zmiana hasła</h3></div>
<div class="contentmiddle">
    <form:form commandName="passwordForm" action="../password/change.html" method="post">
        <table cellspacing="0" class="standardtable">
            <tr><th colspan="2" class="lastcol">Zmiana hasła</th></tr>
            <tr>
                <td>
                    <div>
                        Zbiorcze komunikaty o błędach...
                    </div>
                    <ul class="formContainer">
                        <li>
                            <form:label path="currentPassword">Aktualne hasło</form:label>
                            <form:password path="currentPassword" maxlength="128" cssClass="w98p" cssErrorClass=""/>
                        </li>
                        <li>
                            <form:label path="newPasswordRepeated">Hasło</form:label>
                            <form:password path="newPasswordRepeated" maxlength="128" cssClass="w98p"/>
                        </li>
                        <li>
                            <form:label path="newPasswordRepeated">Powtórz hasło</form:label>
                            <form:password path="newPasswordRepeated" maxlength="128" cssClass="w98p"/>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
        <input type="submit" value="zmień hasło" class="btn btnMarginTop floatLeft" />
        <div class="clearFloat"></div>
    </form:form>
</div>