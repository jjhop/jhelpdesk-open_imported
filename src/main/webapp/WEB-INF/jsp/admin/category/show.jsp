<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="leftcells">
                <div class="pagecontentsubheader"><h3>Szczegóły kategorii</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td>Nazwa</td>
                                <td class="lastcol">
                                    ${category.categoryName}
                                </td>
                            </tr>
                            <tr>
                                <td>Opis</td>
                                <td class="lastcol">
                                    ${category.categoryDesc}
                                </td>
                            </tr>
                            <tr>
                                <td>Aktywna</td>
                                <td class="lastcol">
                                    <c:if test="${category.active}">TAK</c:if>
                                    <c:if test="${not category.active}">NIE</c:if>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
