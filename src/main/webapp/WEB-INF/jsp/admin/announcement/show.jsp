<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader"><h2>Ogłoszenia</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader">
                    <h3><c:out value="${announcement.title}"/></h3>
                </div>
                <div class="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td>
                                    <p class="itemMeta"><c:out value="${announcement.createDate}"/></p>
                                    <div class="entryLead">
                                        <c:out value="${announcement.lead}"/>
                                    </div>
                                    <c:out value="${announcement.body}"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">&nbsp;</td>
        </tr>
    </table>
</div>
