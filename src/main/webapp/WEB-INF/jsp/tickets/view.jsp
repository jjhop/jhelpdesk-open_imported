<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="de.berlios.jhelpdesk.model.EventType" %>
<%@ page import="de.berlios.jhelpdesk.model.Ticket" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketEvent" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketPriority" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketStatus" %>
<%@ page import="de.berlios.jhelpdesk.model.User" %>
<%@ page import="de.berlios.jhelpdesk.utils.DateUtil" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    Ticket ticket = (Ticket) request.getAttribute("ticket");
%>

<div id="ticketdetails">
    <div id="pagecontentheader" class="tickets"><h2>Podgląd zgłoszenia</h2></div>

    <% if (ticket.getTicketStatus().equals(TicketStatus.NOTIFIED)) { %>
    <div id="ticketAttention" class="contentmiddle contentAttention">
        <p>UWAGA: to zgłoszenie nie jest aktualnie rozwiązywane.</p>
        <% if (!currentUser.isPlain()) { %>
        <div id="ticketAttentionAssign">
        <% if (currentUser.isTicketKiller()) { %>
            <a class="lightview btnTicketAction btnTicketResolve rndCrn5px"
               href="<c:url value="/tickets/${ticket.ticketId}/assignToMe.html"/>"
               title=":: :: closeButton: false, width: 500, height: 165">Przypisz do mnie</a>
        <% } else if (currentUser.isManager()) { %>
            <a class="lightview btnTicketAction btnTicketResolve rndCrn5px"
               href="<c:url value="/tickets/${ticket.ticketId}/assignTo.html"/>"
               title=":: :: closeButton: false, width: 500, height: 495">Zleć</a>
            <span class="btnSeparator">lub</span>
            <a class="lightview btnTicketAction btnTicketResolve rndCrn5px"
               href="<c:url value="/tickets/${ticket.ticketId}/assignToMe.html"/>"
               title=":: :: closeButton: false, width: 500, height: 165">Przypisz do mnie</a>
        <% } %>
        </div>
        <% } %>
    </div>
    <% } %>
        <table id="desktoppanelstable" cellspacing="0">
            <tr class="desktoppanelstableheader">
                <td class="rightcells lastTickets">
                    <div class="pagecontentsubheader"><h3 id="headTicketDesc">Opis problemu #<c:out value="${ticket.ticketId}"/></h3></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <th colspan="2">Data zgłoszenia</th>
                                <th colspan="2">Ważność</th>
                                <th colspan="2" class="lastcol">Status</th>
                            </tr>
                            <tr>
                                <td colspan="2" style="height: 20px;"><fmt:formatDate value="${ticket.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <%
                                    boolean userCanChangePriority = (currentUser.isManager() && !ticket.isAssigned())
                                            || (currentUser.equals(ticket.getNotifier()))
                                            || (ticket.isAssigned() && currentUser.equals(ticket.getSaviour()));
                                %>
                                <td id="tdTicketPriority" colspan="2" style="font-weight: bold;"
                                    <% if (userCanChangePriority) { %>
                                    class="highlight"
                                    onmouseover="$('btnChangePr').show();" onmouseout="$('btnChangePr').hide()"<%}%>>
                                    <span class="ticketPriority tp${ticket.ticketPriority}">
                                    <%
                                        TicketPriority priority = ticket.getTicketPriority();
                                        out.print(priority.getPriorityName(currentUser.getPreferredLocale()));
                                    %>
                                    <% if (userCanChangePriority) { %>
                                    <a id="btnChangePr" class="lightview btn btnChange"
                                       href="<c:url value="/tickets/${ticket.ticketId}/priorityChange.html"/>"
                                       title=":: :: closeButton: false, width: 500, height: 495">zmień</a><%}%>
                                    </span>
                                </td>
                                <td colspan="2" class="lastcol" style="font-weight: bold;">
                                    <span class="ticketStatus ts${ticket.ticketStatus}">
                                    <%
                                        TicketStatus status = ticket.getTicketStatus();
                                        out.print(status.getStatusName(currentUser.getPreferredLocale()));
                                    %>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="6" class="lastcol">Kategoria</th>
                            </tr>
                            <tr>
                                <td colspan="6"
                                    <%if ((ticket.getSaviour() == null && currentUser.isManager())
                                            || currentUser.equals(ticket.getSaviour())) {%>
                                    class="highlight"
                                    onmouseover="$('btnChangeCat').show();"
                                    onmouseout="$('btnChangeCat').hide()" <%}%>>
                                    <span class="ticketCategoryChange">
                                        ${ticket.ticketCategory}
                                        <%if ((ticket.getSaviour() == null && currentUser.isManager())
                                                || currentUser.equals(ticket.getSaviour())) {%>
                                        <a id="btnChangeCat" class="lightview btn btnChange"
                                           href="<c:url value="/tickets/${ticket.ticketId}/categoryChange.html"/>"
                                           title=":: :: closeButton: false, width: 500, height: 495, autosize: true">zmień</a>
                                        <%}%>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th colspan="6" class="lastcol">Przyczyna</th>
                            </tr>
                            <tr>
                                <td colspan="6" class="lastcol"><c:out value="${ticket.subject}" /></td>
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
                    <%
                        boolean showPanels =
                                currentUser.getUserRole().toInt() > 1 || currentUser.equals(ticket.getNotifier());
                        pageContext.setAttribute("showPanels", showPanels);
                    %>
                    <c:if test="${not empty kbArticles or showPanels}">
                    <div class="pagecontentsubheader">
                        <h3 id="headTicketArticles">Powiązane artykuły w bazie wiedzy</h3>
                        <auth:check requiredRole="10">
                        <a href="<c:url value="/tickets/${ticketId}/articles/new.html"/>"
                           class="btn lightview"
                           title=":: :: closeButton: false, width: 500, height: 495, keyboard: true">Dodaj...</a>
                        </auth:check>
                    </div>
                    <div id="panel_articles" class="contentmiddle hAuto">
                        <tiles:insertDefinition name="panelAssignedArticles"/>
                    </div>
                    </c:if>
                    
                    <c:if test="${not empty attachments or showPanels}">
                    <div class="pagecontentsubheader">
                        <h3 id="headTicketFiles">Pliki</h3>
                        <a href="<c:url value="/tickets/${ticketId}/uploadFile.html"/>"
                           title=":: :: closeButton: false, width: 500, height: 397"
                           class="btn lightview">Dodaj...</a>
                    </div>
                    <div id="ticketPanelFiles" class="contentmiddle">
                        <tiles:insertDefinition name="panelAttachments"/>
                    </div>
                    </c:if>

                    <div class="chartcontainer">
                        <div class="chartbox">
                            <div class="TabView" id="currentWeekTabView">
                                <div class="Tabs">
                                    <a href="#comments" id="tab_comments" class="tab"><span>Lista komentarzy</span></a>
                                    <a href="#events" id="tab_events" class="tab"><span>Historia zgłoszenia</span></a>
                                </div>

                                <div class="Pages">
                                    <div id="panel_comments" class="Page">
                                        <tiles:insertDefinition name="panelComments"/>
                                    </div>
                                    <div id="panel_events" class="Page">
                                        <tiles:insertDefinition name="panelEvents"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td class="leftcells">
                    <%
                        boolean ASSIGNED_TO_CURRENT_USER =
                            status == TicketStatus.ASSIGNED && ticket.getSaviour().equals(currentUser);
                        boolean RESOLVED_AND_NOTIFIED_BY_CURRENT_USER =
                            status == TicketStatus.RESOLVED && ticket.getNotifier().equals(currentUser);
                        boolean isOlderThanWeek = false;
                        endFor: for (TicketEvent e : ticket.getEvents()) {
                            if(EventType.RESOLVE.equals(e.getEventType())
                                    || EventType.REJECT.equals(e.getEventType())) {
                                isOlderThanWeek = DateUtil.isOlderThankWeek(e.getEvtDate());
                                break endFor;
                            }
                        }
                        boolean RESOLEVED_AND_OLDER_THAN_7_DAYS_AND_CURRENT_USER_IS_MANAGER =
                            (status == TicketStatus.RESOLVED || status == TicketStatus.REJECTED)
                                    && isOlderThanWeek && currentUser.isManager();
                    %>
                    <% if (ASSIGNED_TO_CURRENT_USER || RESOLVED_AND_NOTIFIED_BY_CURRENT_USER) { %>
                    <div id="headTicketActions" class="pagecontentsubheader"><h3 id="headTicketActions">Dostępne akcje</h3></div>
                    <div id="pnlTicketActions" class="contentmiddle">
                        <% if (ASSIGNED_TO_CURRENT_USER) { %>
                            <a href="<c:url value="/tickets/${ticketId}/resolve.html"/>"
                               class="lightview btnTicketAction btnTicketResolve rndCrn5px"
                               title=":: :: closeButton: false, width: 500, height: 495, keyboard: true">Rozwiąż</a>

                            <a href="<c:url value="/tickets/${ticketId}/reject.html"/>"
                               class="lightview btnTicketAction btnTicketReject rndCrn5px"
                               title=":: :: closeButton: false, width: 500, height: 495, keyboard: true">Odrzuć</a>
                        <% } %>
                        <% if (RESOLVED_AND_NOTIFIED_BY_CURRENT_USER) { %>
                            <a href="<c:url value="/tickets/${ticketId}/reopen.html"/>"
                               class="lightview btnTicketAction btnTicketReopen rndCrn5px"
                               title=":: :: closeButton: false, width: 500, height: 495, keyboard: true">Otwórz ponownie</a>
                        <% } %>

                        <% if (RESOLVED_AND_NOTIFIED_BY_CURRENT_USER
                                || RESOLEVED_AND_OLDER_THAN_7_DAYS_AND_CURRENT_USER_IS_MANAGER) { %>
                            <a href="<c:url value="/tickets/${ticketId}/close.html"/>"
                               class="lightview btnTicketAction btnTicketClose rndCrn5px"
                               title=":: :: closeButton: false, width: 500, height: 165, keyboard: true">Zamknij</a>
                        <% } %>
                    </div>
                    <% } %>
                    <div class="pagecontentsubheader"><h3 id="headTicketAddedBy">Wprowadził <img src="${ticket.inputer.avatarURL}" alt="avatar" class="avatar" /></h3></div>
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
                    <div class="pagecontentsubheader"><h3 id="headTicketRaisedBy">Zgłosił <img src="${ticket.notifier.avatarURL}" alt="avatar" class="avatar" /></h3></div>
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
                    <c:if test="${ticket.assigned}">
                    <div class="pagecontentsubheader">
                        <h3 id="headTicketSolvedBy">Rozwiązuje
                            <c:if test="${ticket.saviour != null}">
                                <img src="${ticket.saviour.avatarURL}" alt="avatar" class="avatar" />
                            </c:if>
                        </h3>
                    </div>
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
                        <% boolean ASSIGNABLE = status == TicketStatus.NOTIFIED || status == TicketStatus.ASSIGNED; %>
                        <% if (currentUser.isManager() &&  ASSIGNABLE) { %>
                            <a id="btnAssignActions" class="rndCrn5px" href="#"
                               onclick="Effect.toggle('assignActions', 'appear', { duration: 0.5 }); textToggle('Zmień', 'Anuluj'); return false;">Zmień</a>
                            <div id="assignActions">
                                <% if (!ticket.getSaviour().equals(currentUser)) { %>
                                <a class="lightview btnTicketAction btnTicketResolve rndCrn5px"
                                   href="<c:url value="/tickets/${ticket.ticketId}/assignToMe.html"/>"
                                   title=":: :: closeButton: false, width: 500, height: 165">Przypisz do mnie</a>
                                <% } %>
                                <a class="lightview btnTicketAction btnTicketResolve rndCrn5px"
                                   href="<c:url value="/tickets/${ticket.ticketId}/assignTo.html"/>"
                                   title=":: :: closeButton: false, width: 500, height: 495">Zleć</a>
                            </div>
                            <script type="text/javascript">
                                $('assignActions').hide();
                            </script>
                        <% } %>
                    </div>
                    </c:if>
                </td>
            </tr>
        </table>
</div>
<script type="text/javascript" src="<c:url value="/js/ticket.js"/>"></script>
