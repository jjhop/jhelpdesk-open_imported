<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="leftcells">
                <div id="pagecontentsubheader"><h3>Edycja/dodanie kategorii</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/manage/category/save.html" var="formURL"/>
                        <form:form commandName="category" action="${formURL}">
                            <table cellspacing="0" class="standardtable">
                                <c:if test="${category.id != null}">
                                    <form:hidden path="id"/>
                                </c:if>
                                <tr>
                                    <td>Nazwa</td>
                                    <td class="lastcol">
                                        <form:input path="categoryName"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Opis</td>
                                    <td class="lastcol">
                                        <form:textarea path="categoryDesc"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Aktywna</td>
                                    <td class="lastcol">
                                        <form:checkbox path="active"/>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table cellspacing="0">
                                <tr>
                                    <td colspan="2">
                                        <input type="submit" value="zapisz" class="btn" />
                                    </td>
                                </tr>
                            </table>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
