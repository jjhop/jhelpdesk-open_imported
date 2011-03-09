<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="management">
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
                                    <a href="<c:url value="/preferences/filters/new.html"/>" class="btn">Dodaj nowy filtr</a>
                                </td>
                            </tr>
                        </table>
                        <display:table id="filtersIterator" name="filters" class="standardtable"
                                       pagesize="${listSize}" size="filtersListSize" sort="external" partialList="true"
                                       requestURI="" excludedParams="*" cellspacing="0">
                            <display:column title="Lp." class="rowNumber" headerClass="rowNumber">
                                <c:out value="${filtersIterator_rowNum + offset}"/>
                            </display:column>
                            <display:column title="Tytuł">
                                <a href="<c:url value="/preferences/filters/${filtersIterator.id}/details.html"/>"><c:out value="${filtersIterator.name}"/></a>
                            </display:column>
                            <display:column title="Data utworzenia" style="width: 100px;">
                                <fmt:formatDate value="${filtersIterator.createdAt}" pattern="dd/MM/yyyy hh:mm"/>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionView" href="<c:url value="/preferences/filters/${filtersIterator.id}/details.html"/>">V</a>
                            </display:column>
                            <display:column class="ticketEdit">
                                <a class="actionEdit" href="<c:url value="/preferences/filters/${filtersIterator.id}/edit.html"/>">E</a>
                            </display:column>
                            <display:column class="lastcol ticketEdit" headerClass="lastcol">
                                <a href="<c:url value="/preferences/filters/${filtersIterator.id}/delete.html"/>" class="actionDel">R</a>
                            </display:column>
                        </display:table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
