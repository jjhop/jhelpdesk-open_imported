<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showannouncements" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Wiadomości</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="spacing">
                            <tr>
                                <td class="right">
                                    <a class="btn" href="<c:url value="/announcements/new.html"/>">Dodaj wiadomość</a>
                                </td>
                            </tr>
                        </table>
                        <display:table id="announcementsIterator" name="announcements" class="standardtable"
                                       pagesize="${listSize}" size="announcementsListSize" sort="external" partialList="true"
                                       requestURI="" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${announcementsIterator_rowNum + offset}"/>
                            </display:column>
                            <display:column title="Tytuł">
                                <a href="<c:url value="/announcements/${announcementsIterator.id}/show.html"/>"><c:out value="${announcementsIterator.title}"/></a>
                            </display:column>
                            <display:column title="Data utworzenia" style="width: 100px;">
                                <fmt:formatDate value="${announcementsIterator.createDate}" pattern="dd/MM/yyyy"/>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionView" href="<c:url value="/announcements/${announcementsIterator.id}/show.html"/>">V</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionEdit" href="<c:url value="/announcements/${announcementsIterator.id}/edit.html"/>">E</a>
                            </display:column>
                            <display:column class="lastcol ticketEdit" headerClass="lastcol">
                                <a href="<c:url value="/announcements/${announcementsIterator.id}/remove.html"/>" class="actionDel">R</a>
                            </display:column>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
