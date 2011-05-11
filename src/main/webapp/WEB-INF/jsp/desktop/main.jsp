<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="desktop">
    <div id="pagecontentheader">
        <table cellspacing="0">
            <tr>
                <td id="pagecontentheaderleft"><h2><fmt:message key="desktop.title"/></h2></td>
                <td id="pagecontentheaderright">
                    <a href="<c:url value="/tickets/new.html"/>"><img src="<c:url value="/themes/blue/i/icons/48/evolution.png"/>" alt="s1" width="48" height="48"/></a>
                    <a href="<c:url value="/help/kb/index.html"/>"><img src="<c:url value="/themes/blue/i/icons/48/gnome-help.png"/>" alt="s5" width="48" height="48"/></a>
                </td>
            </tr>
        </table>
    </div>
    <div id="desktoppanels">
        <table id="desktoppanelstable" cellspacing="0">
            <tr class="desktoppanelstableheader">
                <td class="leftcells lastEvents">
                    <div class="pagecontentsubheader">
                        <h3>Ostatnie zdarzenia <a id="lastEventsBtn" href="javascript:updateDiv('lastEventsBtn','<c:url value="/desktop/lastEvents.html"/>');"><img src="<c:url value="/themes/blue/i/btn_refresh.png"/>" class="refresh" alt="" /></a></h3>
                    </div>
                </td>
                <td class="rightcells lastTickets">
                    <div class="pagecontentsubheader">
                        <h3>Ostatnie nieprzypisane zgłoszenia <a id="lastTicketsBtn" href="javascript:updateDiv('lastTicketsBtn', '<c:url value="/desktop/lastTickets.html"/>');"><img src="<c:url value="/themes/blue/i/btn_refresh.png"/>" class="refresh" alt="" /></a></h3>
                    </div>
                </td>
            </tr>
            <tr class="desktoppanelstabledata">
                <td class="leftcells lastEvents">
                    <div class="contenttop"></div>
                    <div id="lastEvents" class="contentmiddle">
                        <tiles:insertDefinition name="/desktop/lastEvents" flush="true"/>
                    </div>
                </td>
                <td class="rightcells lastTickets">
                    <div class="contenttop"></div>
                    <div id="lastTickets" class="contentmiddle">
                        <tiles:insertDefinition name="/desktop/lastTickets" flush="true"/>
                    </div>
                </td>
            </tr>
            <tr class="desktoppanelstableheader">
                <td class="leftcells lastArticles">
                    <div class="pagecontentsubheader">
                        <h3>Ostatnie artykuły <a id="lastArticlesBtn" href="javascript:updateDiv('lastArticlesBtn', '<c:url value="/desktop/lastArticles.html"/>');"><img src="<c:url value="/themes/blue/i/btn_refresh.png"/>" class="refresh" alt="" /></a></h3>
                    </div>
                </td>
                <td class="rightcells lastInfo">
                    <div class="pagecontentsubheader">
                        <h3>Ostatnie informacje <a id="lastAnnouncementsBtn" href="javascript:updateDiv('lastAnnouncementsBtn', '<c:url value="/desktop/lastAnnouncements.html"/>');"><img src="<c:url value="/themes/blue/i/btn_refresh.png"/>" class="refresh" alt="" /></a>
                        </h3>
                    </div>
                </td>
            </tr>
            <tr class="desktoppanelstabledata">
                <td class="leftcells lastArticles">
                    <div class="contenttop"></div>
                    <div id="lastArticles" class="contentmiddle">
                        <tiles:insertDefinition name="/desktop/lastArticles" flush="true"/>
                    </div>
                </td>
                <td class="rightcells lastInfo">
                    <div class="contenttop"></div>
                    <div id="lastAnnouncements" class="contentmiddle">
                        <tiles:insertDefinition name="/desktop/lastAnnouncements" flush="true"/>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>