<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="alltickets" class="ticketslist">
    <div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
    <div id="pagecontentsubheader"><h3>Zgłaszanie problemu</h3></div>
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
                                    <label>Przyczyna zgłoszenia (max. 255 znaków)</label>
                                    <form:textarea id="treasonarea" cssErrorClass="w99p fieldError" cssClass="w99p" rows="2" path="subject"/>
                                    <form:errors path="subject" cssClass="formError errorBottom" />
                                </li>
                                <li class="floatLeft">
                                    <label>Kategoria</label>
                                    <form:select id="kategoria" cssClass="w275" path="ticketCategory" items="${categories}" itemValue="id" itemLabel="categoryName"/>
                                </li>
                                <li class="floatRight">
                                    <label>Ważność</label>
                                    <form:select id="waznosc" path="ticketPriority" items="${priorities}" itemValue="priorityId" itemLabel="priorityName"/>
                                </li>
                                <li class="clearFloat">
                                    <label>Opis zgłoszenia</label>
                                    <form:textarea id="tdescarea" cssErrorClass="w99p fieldError" cssClass="mceEditor w99p" rows="10" path="description"/>
                                    <form:errors path="description" cssClass="formError errorBottom" />
                                </li>
                                <li>
                                    <input class="btn floatLeft" type="submit" name="_target0" value="&laquo; Cofnij"/> <input class="btn floatRight" type="submit" name="_target2" value="Dalej &raquo;"/>
                                </li>
                            </ul>
                        </form:form>
                    </td>
                    <td id="middleright">&nbsp;</td>
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
