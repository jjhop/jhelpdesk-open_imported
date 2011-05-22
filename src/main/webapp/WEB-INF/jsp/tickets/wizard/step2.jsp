<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="de.berlios.jhelpdesk.model.User" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketPriority" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%
    User currentUser = (User) session.getAttribute("user");
%>

<div id="alltickets" class="ticketslist">
    <div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
    <div class="pagecontentsubheader"><h3>Zgłaszanie problemu</h3></div>
    <div id="content">
        <div class="contenttop"></div>
        <div class="contentmiddle">
            <table id="table1" cellspacing="0">
                <tr class="top">
                    <td id="topleft">&nbsp;</td>
                    <td id="topcenter">&nbsp;</td>
                    <td id="topright"><div>&nbsp;</div></td>
                </tr>
                <tr class="middle">
                    <td id="middleleft">
                        <div id="steps">
                            <div><button><h3 class="firstStep"><span>Osoba zgłaszająca</span></h3></button></div>
                            <div class="active"><button><h3><span>Opis zgłoszenia</span></h3></button></div>
                            <div><button><h3><span>Krok po kroku...</span></h3></button></div>
                            <div><button><h3><span>Dodatkowe pliki</span></h3></button></div>
                            <div><button><h3 class="lastStep"><span>Podsumowanie</span></h3></button></div>
                        </div>
                    </td>
                    <td id="middlecenter">
                        <form:form action="${formURL}" commandName="hdticket" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="currentPage" value="2"/>

                            <ul class="formContainer">
                                <li>
                                    <label>
                                        Przyczyna zgłoszenia (max. 255 znaków)
                                        <span class="lblTip">(zasygnalizuj problem, zmieść w 255 znakach, pole wymagane)</span>
                                    </label>
                                    <form:textarea id="treasonarea" cssErrorClass="w99p fieldError" cssClass="w99p" rows="2" path="subject"/>
                                    <form:errors path="subject" cssClass="formError errorBottom" />
                                </li>
                                <li class="floatLeft">
                                    <label>Kategoria</label>
                                    <form:select id="kategoria" cssClass="w300" path="ticketCategory" items="${categories}" itemValue="id" itemLabel="categoryName"/>
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
                                    <label>Opis zgłoszenia
                                        <span class="lblTip">(opisz istotne objawy problemu, zmieść je w 8192 znakach, pole wymagane)</span>
                                    </label>
                                    <form:textarea id="tdescarea" cssErrorClass="w99p fieldError" cssClass="mceEditor w99p" rows="10" path="description"/>
                                    <form:errors path="description" cssClass="formError errorBottom" />
                                </li>
                                <li>
                                    <hr class="separator" />
                                    <input class="btn floatLeft" type="submit" name="_target0" value="&laquo; Cofnij"/> <input class="btn floatRight" type="submit" name="_target2" value="Dalej &raquo;"/>
                                </li>
                            </ul>
                        </form:form>
                    </td>
                    <td id="middleright">
                        <h2 class="wizardTip">Przyczyna zgłoszenia</h2>
                        <p class="wizardTip">
                            Przyczyna zgłoszenia powinna być bardzo zwięzłym (maksymalnie 255 znaków) 
                            oznaczeniem występującego problemu, np. <i>kserokopiarka pozostawia smugi
                            na kopiach</i>.
                        </p>
                        <h2 class="wizardTip">Kategoria problemu</h2>
                        <p class="wizardTip">
                            Koniecznie wybierz najlepszą Twoim zdaniem kategorię, do której należy
                            zgłaszany przez Ciebie problem. Jeśli po analizie w dziale helpdesk okaże
                            się, że trzeba ją zmienić to będzie to możliwe. Zmiana taka zostanie zapisana
                            w historii zgłoszenia.
                        </p>
                        <h2 class="wizardTip">Ważność</h2>
                        <p class="wizardTip">
                            Wybierz możliwe najdokładniej ważność problemu. <strong>Ważność</strong>
                            traktuj jako wypadkową dokuczliwości i pilności rozwiązania.
                        </p>
                        <h2 class="wizardTip">Opis zgłoszenia</h2>
                        <p class="wizardTip">
                            W tym polu należy zwięźle opisać w jakich okolicznościach zachodzą problemy.
                            Opis może być dość długi - maksymalnie 8192 znaki (8kb).
                        </p>
                    </td>
                </tr>
                <tr class="bottom">
                    <td id="bottomleft">&nbsp;</td>
                    <td id="bottomcenter">&nbsp;</td>
                    <td id="bottomright"><div>&nbsp;</div></td>
                </tr>
            </table>
        </div>
        <div class="contentbottom"></div>
    </div>
</div>
