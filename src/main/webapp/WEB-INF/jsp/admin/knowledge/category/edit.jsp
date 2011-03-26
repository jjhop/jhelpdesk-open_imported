<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editsection" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Edycja sekcji</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/manage/kb/category/save.html" var="formURL"/>
                        <form:form commandName="category" action="${formURL}" method="post">
                            <c:if test="${category.id != null}">
                                <form:hidden path="id"/>
                            </c:if>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <li>
                                                <form:label path="categoryName">Nazwa sekcji</form:label>
                                                <form:input path="categoryName" cssClass="w98p" cssErrorClass="fieldError w98p" maxlength="128"/>
                                                <form:errors path="categoryName" cssClass="formError errorBottom"/>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop floatRight" />
                            <div class="clearFloat"></div>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
