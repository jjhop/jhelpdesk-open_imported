<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="personaldata" class="management">
    <div id="pagecontentheader"><h2>Preferencje</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Ustawienia danych osobowych</h3></div>
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
                                        <a href="<c:url value="/preferences/personalData/password/change.html"/>" rel="iframe" title=":: :: topclose: false, width: 320, height: 390" class="lightview">Yahoo</a>
                                        <ul class="formContainer">
                                            <li>
                                                <label>Imie</label>
                                                <form:input cssClass="w98p" cssErrorClass="w98p fieldError" onkeyup="this.value = this.value.charCount('nameCounter', 35)" path="firstName"/>
                                                <form:errors cssClass="formError errorBottom" path="firstName" />
                                                <span id="nameCounter" style="display:none" class="counter"></span>
                                            </li>
                                            <li>
                                                <label>Nazwisko</label>
                                                <form:input cssClass="w98p" cssErrorClass="w98p fieldError" path="lastName"/>
                                                <form:errors cssClass="formError errorBottom" path="lastName" />
                                            </li>
                                            <li>
                                                <label>Email</label>
                                                <form:input cssClass="w98p" cssErrorClass="w98p fieldError" path="email"/>
                                                <form:errors cssClass="formError errorBottom" path="email" />
                                            </li>
                                            <li>
                                                <label>Telefon</label>
                                                <form:input cssClass="w98p" cssErrorClass="w98p fieldError" path="phone"/>
                                                <form:errors cssClass="formError errorBottom" path="phone" />
                                            </li>
                                            <li>
                                                <label>Mobile</label>
                                                <form:input cssClass="w98p" cssErrorClass="w98p fieldError" path="mobile"/>
                                                <form:errors cssClass="formError errorBottom" path="mobile" />
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zmień dane" class="btn btnMarginTop floatLeft" />
                            <div class="clearFloat"></div>
                        </form:form>
                    </div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">
                
            </td>
        </tr>
    </table>
</div>