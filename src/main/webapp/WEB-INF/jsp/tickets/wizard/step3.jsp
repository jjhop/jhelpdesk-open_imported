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
                            <div><button><h3 class="firstStep"><span>Osoba zgłaszająca</span></h3></button></div>
                            <div><button><h3><span>Opis zgłoszenia</span></h3></button></div>
                            <div class="active"><button><h3><span>Krok po kroku...</span></h3></button></div>
                            <div><button><h3><span>Dodatkowe pliki</span></h3></button></div>
                            <div><button><h3 class="lastStep"><span>Podsumowanie</span></h3></button></div>
                        </div>
                    </td>
                    <td id="middlecenter">
                        <form action="<c:url value="${formURL}"/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="currentPage" value="3"/>
                            <ul class="formContainer">
                                <li>
                                    <label>Kroki by powtórzyć</label>
                                        <spring:bind path="hdticket.stepByStep">
                                            <textarea class="w99p mceEditor" name="<c:out value="${status.expression}"/>" rows="15" cols="40"><c:out value="${status.value}" /></textarea>
                                        </spring:bind>
                                </li>
                                <li>
                                    <hr class="separator" />
                                    <input class="btn floatLeft" type="submit" name="_target1" value="&laquo; Cofnij"/> <input class="btn floatRight" type="submit" name="_target3" value="Dalej &raquo;"/>
                                </li>
                            </ul>

                        </form>
                    </td>
                    <td id="middleright">
                        <h2 class="wizardTip">Krok po kroku</h2>
                        <p class="wizardTip">
                            Jeśli zgłaszany problem ma charakter powtarzalny i potrafisz opisać,
                            w jakich warunkach da się to zrobić, to opisz te warunki oraz kolejne
                            kroki, które należy wykonac, aby go wywołać. Masz na to wiele miejsca
                            (maksymalnie 16384 znaków - 16kb). Możesz używac znaczników 
                            <strong>Markdown</strong>.
                        </p>
                        <h2 class="wizardTip">Znaczki Markdown</h2>
                        <p class="wizardTip">
                            Poniższa lista opisuje tylko kilka znaczników, które możesz wykorzystać
                            w swoim tekście. Więcej znajdziesz w <a href="">Pomocy</a>.
                        </p>
                        <dl class="wizardTip">
                            <dt>paragraf</dt>
                            <dd>paragrafy zaznaczamy linią odstępu pomiędzy wierszami</dd>
                            <dt>emfaza</dt>
                            <dd>*tekst do oznaczenia*</dd>
                            <dt>podwójna emfaza</dt>
                            <dd>**tekst do oznaczenia**</dd>
                            <dt>lista numerowana</dt>
                            <dd>listę numerowaną tworzymy dodając na początku wiersza liczbę</dd>
                            <dt>lista nienumerowana</dt>
                            <dd>listę numerowaną tworzymy dodając na początku wiersza znak * i odstęp po niej</dd>
                        </dl>
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
