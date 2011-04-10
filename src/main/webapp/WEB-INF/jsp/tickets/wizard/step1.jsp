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
                                <tr>
                                    <td class="wizardLabel">Użytkownik: </td>
                                    <td class="wizardContent">
                                        <c:if test="${ not empty hdticket.notifier }">
                                            <c:out value="${hdticket.notifier.firstName}" />
                                        </c:if>
                                        <c:if test="${ not empty hdticket.notifier }">
                                            <c:out value="${hdticket.notifier.lastName}" />
                                        </c:if>
                                    </td>
                                    <td class="wizardAvatar" rowspan="3">
                                        <img class="avatar" alt="avatar" src="http://www.gravatar.com/avatar/2cead66852e686d84eb4b1e7d4a9d416?d=mm&amp;s=96">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wizardLabel">Telefon:</td>
                                    <td class="wizardContent">
                                        <c:if test="${ not empty hdticket.notifier}">
                                            <c:out value="${hdticket.notifier.phone}"/>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="wizardLabel">Telefon kom.:</td>
                                    <td class="wizardContent">
                                        <c:if test="${ not empty hdticket.notifier}">
                                            <c:out value="${hdticket.notifier.mobile}"/>
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2"><input class="btn" type="submit" name="_target1" value="Dalej &raquo;"/></td>
                                </tr>
                            </table>
                        </form>
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