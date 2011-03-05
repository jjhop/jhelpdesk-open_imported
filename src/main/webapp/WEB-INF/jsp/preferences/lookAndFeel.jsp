<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="lookandfeel" class="preferences">
    <div id="pagecontentheader"><h2>Preferencje</h2></div>
    <form:form modelAttribute="preferences">
        <form:hidden path="id"/>
        <table cellspacing="0">
            <tr>
                <td class="rightcells">
                    <div id="pagecontentsubheader"><h3>Wygląd, język, strona startowa</h3></div>
                    <div id="content">
                        <div class="contenttop"></div>
                        <div class="contentmiddle">
                            <table cellspacing="0" class="standardtable">
                                <tr><th colspan="5" class="lastcol">Strona startowa</th></tr>
                                <tr class="options">
                                    <td style="width: 111px;">
                                        <form:radiobutton id="v1" path="welcomePage" value="desktop"/>
                                        <label for="v1">biurko</label></td>
                                    <td style="width: 111px;">
                                        <form:radiobutton id="v2" path="welcomePage" value="tickets"/>
                                        <label for="v2">zgłoszenia</label><br/>
                                        <form:select items="${sessionScope.user.filters}" path="filterId" itemValue="id" itemLabel="name"/>
                                    </td>
                                    <td style="width: 111px;">
                                        <form:radiobutton id="v3" path="welcomePage" value="newTicket"/>
                                        <label for="v3">nowe zgłoszenie</label><br/>

                                        <form:radiobutton id="nz1" path="newTicketFormView" value="form"/>
                                        <label for="nz1">Formularz zgłoszenia</label><br/>

                                        <form:radiobutton id="nz2" path="newTicketFormView" value="wizzard"/>
                                        <label for="nz2">Kreator zgłoszenia</label>
                                    </td>
                                    <td class="lastcol" style="width: 112px;">
                                        <form:radiobutton id="v4" path="welcomePage" value="kBase"/>
                                        <label for="v4">baza wiedzy</label></td>
                                </tr>
                            </table>
                            <br />
                            <table cellspacing="0" class="standardtable">
                                <tr><th colspan="4" class="lastcol">Wybór języka interfejsu</th></tr>
                                <tr class="options">
                                    <td style="width: 140px;">
                                        <form:radiobutton id="l1" path="preferredLocale" value="pl"/>
                                        <label for="l1">polski</label></td>
                                    <td style="width: 140px;">
                                        <form:radiobutton id="l2" path="preferredLocale" value="en"/>
                                        <label for="l2">angielski</label></td>
                                    <td style="width: 140px;">
                                        <form:radiobutton id="l3" path="preferredLocale" value="es"/>
                                        <label for="l3">hiszpański</label></td>
                                    <td class="lastcol" style="width: 140px;">
                                        <form:radiobutton id="l4" path="preferredLocale" value="pt" disabled="true"/>
                                        <label for="l4">portugalski</label></td>
                                </tr>
                            </table>
                            <br />
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th>Lista/ilość zgłoszeń</th>
                                    <th>10</th>
                                    <th>25</th>
                                    <th>50</th>
                                    <th class="lastcol">100</th>
                                </tr>
                                <tr>
                                    <td class="blank">Listy zgłoszeń</td>
                                    <td><form:radiobutton path="ticketsListSize" value="10"/></td>
                                    <td><form:radiobutton path="ticketsListSize" value="25"/></td>
                                    <td><form:radiobutton path="ticketsListSize" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="ticketsListSize" value="100"/></td>
                                </tr>
                                <tr>
                                    <td class="blank">Lista wiadomości</td>
                                    <td><form:radiobutton path="announcementsListSize" value="10"/></td>
                                    <td><form:radiobutton path="announcementsListSize" value="25"/></td>
                                    <td><form:radiobutton path="announcementsListSize" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="announcementsListSize" value="100"/></td>
                                </tr>
                                <tr>
                                    <td class="blank">Lista użytkowników</td>
                                    <td><form:radiobutton path="usersListSize" value="10"/></td>
                                    <td><form:radiobutton path="usersListSize" value="25"/></td>
                                    <td><form:radiobutton path="usersListSize" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="usersListSize" value="100"/></td>
                                </tr>
                                <tr>
                                    <td class="blank">Lista filtrów</td>
                                    <td><form:radiobutton path="filtersListSize" value="10"/></td>
                                    <td><form:radiobutton path="filtersListSize" value="25"/></td>
                                    <td><form:radiobutton path="filtersListSize" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="filtersListSize" value="100"/></td>
                                </tr>
                                <tr>
                                    <td class="blank">Lista artykułów (baza wiedzy)</td>
                                    <td><form:radiobutton path="articlesListSize" value="10"/></td>
                                    <td><form:radiobutton path="articlesListSize" value="25"/></td>
                                    <td><form:radiobutton path="articlesListSize" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="articlesListSize" value="100"/></td>
                                </tr>
                                <tr>
                                    <td class="blank">Maksymalna rozmiar wyników wyszukiwania</td>
                                    <td><form:radiobutton path="searchResultLimit" value="10"/></td>
                                    <td><form:radiobutton path="searchResultLimit" value="25"/></td>
                                    <td><form:radiobutton path="searchResultLimit" value="50"/></td>
                                    <td class="lastcol"><form:radiobutton path="searchResultLimit" value="100"/></td>
                                </tr>
                            </table>
                            <br/>
                            <table cellspacing="0">
                                <tr>
                                    <td colspan="2">
                                        <input name="_cancel" type="submit" value="anuluj" class="btn" />
                                        <input type="submit" value="zapisz" class="btn" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="contentbottom"></div>
                    </div>
                </td>
            </tr>
        </table>
    </form:form>
</div>