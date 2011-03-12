<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="ticketdetails">
    <div id="pagecontentheader"><h2>Podgląd zgłoszenia</h2></div>
    <div id="desktoppanels">
        <table id="desktoppanelstable" cellspacing="0">
            <tr class="desktoppanelstableheader">
                <td class="rightcells lastTickets">
                    <div id="pagecontentsubheader"><h3>Opis problemu</h3></div>
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <th colspan="3" style="width: 258px;">Identyfikator</th>
                                <th colspan="3" class="lastcol">Data</th>
                            </tr>
                            <tr>
                                <td colspan="3" style="width: 258px; font-weight: bold;"><c:out value="${ticket.ticketId}"/></td>
                                <td colspan="3" class="lastcol" style="font-weight: bold;"><fmt:formatDate value="${ticket.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                            </tr>
                            <tr>
                                <th colspan="6" class="lastcol">Przyczyna</th>
                            </tr>
                            <tr>
                                <td colspan="6" class="lastcol"><c:out value="${ticket.subject}" /></td>
                            </tr>
                            <tr>
                                <th colspan="2">Status</th>
                                <th colspan="2">Kategoria</th>
                                <th colspan="2" class="lastcol">Ważność</th>
                            </tr>
                            <tr>
                                <td colspan="2" style="width: 170px;">
                                    ${ticket.ticketStatus.statusName}
                                    <!--<select size="1">
                                        <c:forEach var="status" items="${ticketStatuses}">
                                            <option value="${status.statusId}" <c:if test="${status.statusId == ticket.ticketStatus.statusId}">selected="selected"</c:if>>
                                                <c:out value="${status}" />
                                            </option>
                                        </c:forEach>
                                    </select>-->
                                </td>
                                <td colspan="2" style="width: 170px;">
                                    ${ticket.ticketCategory}
                                    <!--<select size="1">
                                        <c:forEach var="category" items="${ticketCategories}">
                                            <option value="${category.id}" <c:if test="${category.id == ticket.ticketCategory.id}">selected="selected"</c:if>>
                                                <c:out value="${category}" />
                                            </option>
                                        </c:forEach>
                                    </select>-->
                                </td>
                                <td colspan="2" class="lastcol">
                                    ${ticket.ticketPriority.priorityName}
                                    <!--<select size="1">
                                        <c:forEach var="priority" items="${ticketPriorities}">
                                            <option value="${priority.priorityId}" <c:if test="${priority == ticket.ticketPriority}">selected="selected"</c:if>>
                                                <c:out value="${priority}" />
                                            </option>
                                        </c:forEach>
                                    </select>-->
                                </td>
                            </tr>
                            <tr>
                                <th colspan="6" class="lastcol">Opis</th>
                            </tr>
                            <tr>
                                <td colspan="6" class="lastcol"><c:out value="${ticket.description}" escapeXml="false" /></td>
                            </tr>
                            <c:if test="${not empty ticket.stepByStep}">
                                <tr>
                                    <th colspan="6" class="lastcol">Krok po kroku</th>
                                </tr>
                                <tr>
                                    <td colspan="6" class="lastcol"><c:out value="${ticket.stepByStep}" escapeXml="false"/></td>
                                </tr>
                            </c:if>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                    <c:if test="${not empty ticket.addFilesList}">
                        <div id="pagecontentsubheader"><h3>Pliki</h3></div>
                        <div class="contenttop"></div>
                        <div class="contentmiddle">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th>Nazwa</th>
                                    <th class="lastcol">Rozmiar</th>
                                </tr>
                                <c:forEach var="file" items="${ticket.addFilesList}" varStatus="status">
                                    <tr>
                                        <td><c:out value="${file.originalFileName}"/></td>
                                        <td class="lastcol"><c:out value="${file.humanReadableFileSize}"/></td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                        <div class="contentbottom"></div>
                    </c:if>
                    <div id="pagecontentsubheader"><h3>Ostatnie zdarzenia</h3></div>
                    <div class="chartcontainer">
                        <div class="chartbox">
                            <div class="TabView" id="currentWeekTabView">
                                <div class="Tabs">
                                    <a href="#first" id="tab_first" class="tab"><span>Lista komentarzy</span></a>
                                    <a href="#second" id="tab_second" class="tab"><span>Historia zgłoszenia</span></a>
                                </div>
                                <div class="contenttop"></div>
                                <div class="Pages">
                                    <div id="panel_first" class="Page">
                                        <table width="100%" cellspacing="12" cellpadding="4">
                                            <tr>
                                                <td>
                                                    <c:if test="${not empty ticket.comments}">
                                                        <table cellspacing="0" class="standardtable" style="margin-bottom: 10px;">
                                                            <tr>
                                                                <th>Autor</th>
                                                                <th>Data</th>
                                                                <th class="lastcol">Treść</th>
                                                            </tr>
                                                            <c:forEach var="comment" items="${ticket.comments}" varStatus="status">
                                                                <tr>
                                                                    <td class="tit"><c:out value="${comment.commentAuthor}"/></td>
                                                                    <td><fmt:formatDate value="${comment.commentDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                                    <td class="bod"><c:out value="${comment.commentText}" escapeXml="false"/></td>
                                                                </tr>
                                                            </c:forEach>
                                                        </table>
                                                        <ul class="panelPager">
                                                            <li><a href="#">&laquo; poprzednia</a></li>
                                                            <li><a href="#">1</a></li>
                                                            <li><a href="#">2</a></li>
                                                            <li><a href="#">następna &raquo;</a></li>
                                                        </ul>
                                                    </c:if>
                                                    <form action="<c:url value="/tickets/${ticket.ticketId}/details.html"/>" method="post">
                                                        <textarea id="addComm" name="addComm" rows="3" cols="40" class="addcomment" style="height: 120px;"></textarea>
                                                        <br/>
                                                        <input type="checkbox" name="notForPlainUser" value="true"/> - tylko dla pracowników helpdesku
                                                        <br/><br/>
                                                        <input type="submit" value="dodaj komentarz" class="btn" />
                                                    </form>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                    <div id="panel_second" class="Page">
                                        <table width="100%" cellspacing="12" cellpadding="4">
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" class="standardtable">
                                                        <tr>
                                                            <th>Lp.</th>
                                                            <th>Zdarzenie</th>
                                                            <th>Autor</th>
                                                            <th class="lastcol">Data</th>
                                                        </tr>
                                                        <c:forEach var="event" items="${ticket.events}" varStatus="status">
                                                            <tr>
                                                                <td class="scount"><c:out value="${status.count}"/></td>
                                                                <td><c:out value="${event.evtSubject}"/></td>
                                                                <td><c:out value="${event.evtAuthor}"/></td>
                                                                <td class="lastcol"><fmt:formatDate value="${event.evtDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                                            </tr>
                                                        </c:forEach>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript">
                        //<![CDATA[
                        Event.observe(window, 'load', loadTabs, false);
                        function loadTabs() {
                            var tabs = new tabset('currentWeekTabView', {
                                classNames: {
                                    tab:        'tab',    // class name used to identify the tabs
                                    panel:      'Page',   // class name used to identify the tab content
                                    tabActive:  'Active'  // class name added to the active tab
                                },
                                ids: {
                                    tab:        'tab_',   // what to strip off the tab id to get the tab name
                                    panel:      'panel_'  // what to strip off the tab content id to get the tab name
                                },
                                onEvent:        'click',    // perhaps you want to activate on mouseover? not recommended
                                effects:        true        // set this to false if you do not want to include effects.js
                            }); // name of div to crawl for tabs and panels
                            tabs.autoActivate($('tab_first')); // name of tab to auto-select if none exists in the url
                        }
                        //]]>
                    </script>
                </td>
                <td class="leftcells">
                    <div id="pagecontentsubheader"><h3>Wprowadził <img src="${ticket.inputer.avatarURL}" alt="avatar" class="avatar" /></h3></div>
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="tabtitle">Użytkownik:</td>
                                <td colspan="3" class="lastcol"><c:out value="${ticket.inputer.fullName}"/></td>
                            </tr>
                            <tr>
                                <td class="tabtitle">Email:</td>
                                <td colspan="3" class="lastcol"><c:out value="${ticket.inputer.email}"/></td>
                            </tr>
                            <tr>
                                <td class="tabtitle">Tel:</td>
                                <td style="width: 110px;"><c:out value="${ticket.inputer.phone}"/></td>
                                <td class="tabtitle">Kom:</td>
                                <td class="lastcol" style="width: 110px;"><c:out value="${ticket.inputer.mobile}"/></td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                    <div id="pagecontentsubheader"><h3>Zgłosił <img src="${ticket.notifier.avatarURL}" alt="avatar" class="avatar" /></h3></div>
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="tabtitle">Użytkownik:</td>
                                <td colspan="3" class="lastcol"><c:out value="${ticket.notifier.fullName}"/></td>
                            </tr>
                            <tr>
                                <td class="tabtitle">Email:</td>
                                <td colspan="3" class="lastcol"><c:out value="${ticket.notifier.email}"/></td>
                            </tr>
                            <tr>
                                <td class="tabtitle">Tel:</td>
                                <td style="width: 110px;"><c:out value="${ticket.notifier.phone}"/></td>
                                <td class="tabtitle">Kom:</td>
                                <td class="lastcol" style="width: 110px;"><c:out value="${ticket.notifier.mobile}"/></td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                    <div id="pagecontentsubheader">
                        <h3>Rozwiązuje 
                            <c:if test="${ticket.saviour != null}">
                                <img src="${ticket.saviour.avatarURL}" alt="avatar" class="avatar" />
                            </c:if>
                        </h3>
                    </div>
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:if test="${ticket.saviour != null}">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td class="tabtitle">Użytkownik:</td>
                                    <td colspan="3" class="lastcol"><c:out value="${ticket.saviour.fullName}"/></td>
                                </tr>
                                <tr>
                                    <td class="tabtitle">Email:</td>
                                    <td colspan="3" class="lastcol"><c:out value="${ticket.saviour.email}"/></td>
                                </tr>
                                <tr>
                                    <td class="tabtitle">Tel:</td>
                                    <td style="width: 110px;"><c:out value="${ticket.saviour.phone}"/></td>
                                    <td class="tabtitle">Kom:</td>
                                    <td class="lastcol" style="width: 110px;"><c:out value="${ticket.saviour.mobile}"/></td>
                                </tr>
                            </table>
                        </c:if>
                        <c:if test="${not user.plain}">
                            <%-- przypisywanie nie dla zwykłych użytkowników --%>
                            <a href="<c:url value="/tickets/${ticket.ticketId}/assign.html?uId=${user.userId}"/>">Przypisz do mnie</a><br/>
                        </c:if>
                        <c:if test="${user.manager}">
                            <%-- formularz tylko dla managera --%>
                            <form action="<c:url value="/tickets/${ticket.ticketId}/assign.html"/>">
                                <select name="uId">
                                    <c:forEach items="${saviours}" var="u">
                                        <option value="${u.userId}">${u.fullName}</option>
                                    </c:forEach>
                                </select>
                                <input type="submit" value="Przypisz"/>
                            </form>
                        </c:if>
                    </div>
                    <div class="contentbottom"></div>
                </td>
            </tr>
        </table>
    </div>
</div>
