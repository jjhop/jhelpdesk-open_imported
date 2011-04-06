<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Zgłaszanie problemu <a href="#"><img src="<c:url value="/themes/blue/i/btn_help.png"/>" class="refresh" alt="" /></a></h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <form:form commandName="ticket">
                            <form:hidden path="ticketstamp"/>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <li class="w75p">
                                                <label>Zgłaszający 
                                                    <span class="lblTip">(wprowadź email i sprawdzić czy użytkownik istnieje)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('notifierCounter', 128)" onblur="$('notifierCounter').hide()" path="notifier" cssErrorClass="w90p fieldError" cssClass="w90p" maxlength="128"/>
                                                <input type="image" align="top" style="border: 0" src="<c:url value="/themes/blue/i/find.gif"/>" value="true" alt="Znajdź" name="_checkLogin">
                                                <form:errors path="notifier" cssClass="formError errorBottom" />
                                                <span id="notifierCounter" class="counter"></span>
                                            </li>
                                            <li class="floatLeft w75p">
                                                <label>Kategoria</label>
                                                <form:select cssClass="w98p" path="ticketCategory" items="${categories}"
                                                             itemValue="id" itemLabel="categoryName" />
                                            </li>
                                            <li class="floatRight">
                                                <label>Ważność</label>
                                                <form:select cssClass="w20" path="ticketPriority" items="${priorities}" 
                                                             itemValue="priorityId" itemLabel="priorityName" />
                                            </li>
                                            <li class="clearFloat">
                                                <label>Przyczyna
                                                    <span class="lblTip">(zasygnalizuj problem, zmieść w 255 znakach, pole wymagane)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('subjectCounter', 255)" onblur="$('subjectCounter').hide()" cssClass="w98p" cssErrorClass="w98p fieldError" path="subject" maxlength="255"/>
                                                <form:errors path="subject" cssClass="formError errorBottom" />
                                                <span id="subjectCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <label>Opis zgłoszenia
                                                    <span class="lblTip">(opisz objawy problemu, podaj istatne szczegóły, zmieść w 8192 znakach, pole wymagane)</span>
                                                </label>
                                                <form:textarea onkeyup="charTextCount(this.form.description, 'descriptionCounter', 8192)" onblur="$('descriptionCounter').hide()" cssClass="w98p" cssErrorClass="w98p fieldError" path="description" rows="6" cols="40"/>
                                                <form:errors path="description" cssClass="formError errorBottom" />
                                                <span id="descriptionCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <label>Kroki by powtórzyć
                                                    <span class="lblTip">(jeśli problem jest powtarzalny - napisz jak go wywołać, zmieść w 16384 znakach)</span>
                                                </label>
                                                <form:textarea onkeyup="charTextCount(this.form.stepByStep, 'stepByStepCounter', 16384)" onblur="$('stepByStepCounter').hide()" cssClass="w98p" id="step_by_step" path="stepByStep" rows="6" cols="40"/>
                                                <span id="stepByStepCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <label>Załączniki</label>
                                                <a href="<c:url value="/tickets/uploadFile.html?ticketstamp=${ticket.ticketstamp}"/>"
                                                   rel="iframe"
                                                   title=":: :: closeButton: false, width: 320, height: 390"
                                                   class="lightview">Dołącz plik</a>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop floatLeft"/>
                            <a href="#" class="btnPlain floatLeft">anuluj</a>
                            <div class="clearFloat"></div>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>








