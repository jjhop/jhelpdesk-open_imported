<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="alltickets" class="ticketslist">
    <div id="pagecontentheader" class="tickets"><h2>Zgłoszenia</h2></div>
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
                            <div><button><h3><span>Opis zgłoszenia</span></h3></button></div>
                            <div><button><h3><span>Krok po kroku...</span></h3></button></div>
                            <div class="active"><button><h3><span>Dodatkowe pliki</span></h3></button></div>
                            <div><button><h3 class="lastStep"><span>Podsumowanie</span></h3></button></div>
                        </div>
                    </td>
                    <td id="middlecenter">
                        <ul class="formContainer">
                            <li>
                                <label class="dark rndCrn5px">
                                    Załączniki
                            <a href="<c:url value="/tickets/uploadFile.html?ticketstamp=${hdticket.ticketstamp}"/>"
                               rel="iframe" title=":: :: closeButton: false, width: 380, height: 390"
                               class="lightview floatRight">Załącz plik(i)</a>
                                </label>
                            </li>
                        </ul>
                        <form action="<c:url value="${formURL}"/>" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="currentPage" value="4"/>
                            <table id="tableWizard" cellspacing="0">
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <li class="single">
                                                <ol class="attachList" id="attachList">
                                                    <c:forEach items="${currentFiles}" var="f" varStatus="i">
                                                    <li id="attachment_id_${i.index}">
                                                        <a class="attachDel" href="#"
                                                            onclick="new Ajax.Request('<c:url value="/tickets/attachments/remove.html?t=${hdticket.ticketstamp}&amp;a=${f.filename}&amp;e=attachment_id_${i.index}"/>', {
                                                                            asynchronous:true, evalScripts:true}); return false;">Usuń</a>
                                                        <span class="attachName"><c:out value="${f.filename}"/> <span class="attachSize">(<c:out value="${f.filesize}"/>)</span></span>
                                                    </li>
                                                    </c:forEach>
                                                </ol>
                                                <script type="text/javascript">
                                                    function refreshFiles() {
                                                        new Ajax.Updater('attachList','<c:url value="/tickets/attachments/refresh.html"/>', {
                                                          parameters: { ticketstamp: '${hdticket.ticketstamp}'}
                                                        });
                                                    }
                                                </script>
                                            </li>
                                            <li>
                                                <hr class="separator" />
                                                <input class="btn floatLeft" type="submit" name="_target2" value="&laquo; Cofnij"/>
                                                <input class="btn floatRight" type="submit" name="_target4" value="Dalej &raquo;"/>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                    <td id="middleright">
                        help
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
