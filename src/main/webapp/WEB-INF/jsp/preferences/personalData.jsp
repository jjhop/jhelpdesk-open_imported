<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="personaldata" class="management">
    <div id="pagecontentheader" class="preferences"><h2>Preferencje</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headPrefData">Ustawienia danych osobowych</h3></div>
                <div id="content">
                    <div class="contentmiddle">
                        <c:url value="/preferences/personalData/change.html" var="formURL"/>
                        <form:form action="${formURL}" modelAttribute="personalData">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th class="lastcol">Zmiana danych</th>
                                </tr>
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <li class="floatLeft w45p">
                                                <label>Imię</label>
                                                <form:input cssClass="w95p" cssErrorClass="w95p fieldError" onkeyup="this.value.charCount('nameCounter', 64)" path="firstName"  maxlength="64"/>
                                                <form:errors cssClass="formError errorBottom" path="firstName" />
                                                <span id="nameCounter" style="display:none" class="counter"></span>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Nazwisko</label>
                                                <form:input cssClass="w95p" cssErrorClass="w95p fieldError" path="lastName" maxlength="128"/>
                                                <form:errors cssClass="formError errorBottom" path="lastName" />
                                            </li>
                                            <li class="clearFloat floatLeft w45p">
                                                <label>Telefon</label>
                                                <form:input cssClass="w95p" cssErrorClass="w95p fieldError" path="phone" maxlength="20"/>
                                                <form:errors cssClass="formError errorBottom" path="phone" />
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Mobile</label>
                                                <form:input cssClass="w95p" cssErrorClass="w95p fieldError" path="mobile" maxlength="20"/>
                                                <form:errors cssClass="formError errorBottom" path="mobile" />
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Email</label>
                                                <form:input cssClass="w95p" cssErrorClass="w95p fieldError" path="email" maxlength="128"/>
                                                <form:errors cssClass="formError errorBottom" path="email" />
                                            </li>
                                            <li class="floatRight w45p">
                                                <a href="<c:url value="/preferences/personalData/password/change.html"/>"
                                                   rel="iframe"
                                                   title=":: :: closeButton: false, width: 320, height: 400"
                                                   class="btn floatRight btnMarginTop25 lightview">zmień hasło</a>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zmień dane" class="btn btnMarginTop" />
                            <a href="#" class="btnPlain btnMarginTop">anuluj</a>

                        </form:form>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>