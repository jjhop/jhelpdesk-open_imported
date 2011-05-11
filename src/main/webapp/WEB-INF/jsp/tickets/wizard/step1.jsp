<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

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
                            <div class="active"><button><h3 class="firstStep"><span>Osoba zgłaszająca</span></h3></button></div>
                            <div><button><h3><span>Opis zgłoszenia</span></h3></button></div>
                            <div><button><h3><span>Krok po kroku...</span></h3></button></div>
                            <div><button><h3><span>Dodatkowe pliki</span></h3></button></div>
                            <div><button><h3 class="lastStep"><span>Podsumowanie</span></h3></button></div>
                        </div>
                    </td>
                    <td id="middlecenter">
                        <form action="<c:url value="${formURL}"/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="currentPage" value="1"/>
                            <table id="tableWizard" cellspacing="0">
                                <tr>
                                    <td colspan="3">
                                        <ul class="formContainer">
                                            <li>
                                                <label>E-mail:</label>
                                                <spring:bind path="hdticket.notifier">
                                                    <c:choose>
                                                        <c:when test="${readOnly}">
                                                            <c:out value="${status.expression}"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <input class="wizardEmail" type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
                                                                   <c:if test="${not empty status.errorMessage}"> class="hintanchor"</c:if> />
                                                            <input type="image" name="_checkLogin" alt="Znajdź" value="true" src="<c:url value="/themes/blue/i/btn_find.png"/>" style="border: 0" align="top" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </spring:bind>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                                <c:if test="${hdticket.notifier != null}">
                                <tr>
                                    <td class="wizardAvatar" rowspan="4">
                                        <img src="${hdticket.notifier.avatarURL}" alt="avatar" class="avatar" />
                                    </td>
                                    <td class="wizardUser" colspan="2">
                                        <c:if test="${ not empty hdticket.notifier }">
                                            <c:out value="${hdticket.notifier.firstName}" />
                                        </c:if>
                                        <c:if test="${ not empty hdticket.notifier }">
                                            <c:out value="${hdticket.notifier.lastName}" />
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wizardLabel"><img src="<c:url value="/themes/blue/i/ico_phone.png"/>" alt="Telefon" /></td>
                                    <td class="wizardContent">
                                        <c:if test="${ not empty hdticket.notifier}">
                                            <c:out value="${hdticket.notifier.phone}"/>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wizardLabel"><img src="<c:url value="/themes/blue/i/ico_mobile.png"/>" alt="Telefon komórkowy" /></td>
                                    <td class="wizardContent">
                                        <c:if test="${ not empty hdticket.notifier}">
                                            <c:out value="${hdticket.notifier.mobile}"/>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wizardLabel">
                                    </td>
                                    <td class="wizardContent">
                                    </td>
                                </tr>
                                </c:if>
                                <tr>
                                    <td colspan="3" style="padding: 10px">
                                        <hr class="separator" />
                                        <input class="btn" type="submit" name="_target1" value="Dalej &raquo;"/>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                    <td id="middleright">
                        <p class="wizardTip">
                        Aby sprawdzić użytkownika, wprowadź jego emaila do pola i kliknij <b>lupkę</b>.<br />
                        Jeśli jest zarejestrowany w systemie to poniżej pola pojawią się jego dodatkowe
                        dane. Jeśli jednak nie zostatnie odnaleziony - pojawi się stosowny komunikat.<br/>
                        Jeśli jesteś pewien, że użytkownik istnieje i wprowadzony email jest prawidłowy,
                        możesz po prostu kliknąć przycisk <b>Dalej</b>, aby przejść do kolejnego kroku
                        formularza zgłoszenia.
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