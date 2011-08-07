<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="de.berlios.jhelpdesk.model.User" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketPriority" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<%
    User currentUser = (User) session.getAttribute("loggedUser");
%>

<div id="editcategory" class="management">
    <div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader">
                    <h3>Zgłaszanie problemu
                        <a href="#help"
                           class="lightview" title=":: :: width: 400, height: 300, keyboard: true"><img src="<c:url value="/themes/blue/i/btn_help.png"/>" class="refresh" alt="" /></a>
                    </h3>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <form:form commandName="ticket">
                            <form:hidden path="ticketstamp"/>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <% if (!currentUser.isPlain()) { %>
                                            <li class="w75p">
                                            <label>Zgłaszający
                                                    <span class="lblTip">(wprowadź email, aby sprawdzić czy użytkownik istnieje)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('notifierCounter', 128)" onblur="$('notifierCounter').hide()" path="notifier" cssErrorClass="w90p fieldError" cssClass="w90p" maxlength="128"/>
                                                <input type="image" align="top" style="border: 0" src="<c:url value="/themes/blue/i/btn_find.png"/>" value="true" alt="Znajdź" name="_checkLogin">
                                                <form:errors path="notifier" cssClass="formError errorBottom" />
                                                <span id="notifierCounter" class="counter"></span>
                                            </li>
                                            <% } else { %>
                                            <form:hidden path="notifier"/>
                                            <% } %>
                                            <li class="floatLeft w75p">
                                                <label>Kategoria</label>
                                                <form:select cssClass="w98p" path="ticketCategory" items="${categories}"
                                                             itemValue="id" itemLabel="categoryName" />
                                            </li>
                                            <li class="floatRight">
                                                <label>Ważność</label>
                                                <select id="ticketPriority" name="ticketPriority" class="w20">
                                                <c:forEach var="priority" items="${priorities}">
                                                    <option value="${priority.priorityId}" <c:if test="${priority == ticket.ticketPriority}">selected="selected"</c:if>>
                                                    <%
                                                        TicketPriority priority = (TicketPriority) pageContext.getAttribute("priority");
                                                        out.print(priority.getPriorityName(currentUser.getPreferredLocale()));
                                                    %>
                                                    </option>
                                                </c:forEach>
                                                </select>
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
                                                    <span class="lblTip">(opisz objawy problemu, podaj istotne szczegóły, zmieść je w 8192 znakach, pole wymagane)</span>
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
                                                   title=":: :: closeButton: false, width: 360, height: 390"
                                                   class="lightview">Dołącz plik</a>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop"/>
                            <a href="#" class="btnPlain">anuluj</a>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
<div id="help" style="display: none;">
Hello world!
</div>