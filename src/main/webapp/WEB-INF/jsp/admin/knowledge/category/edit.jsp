<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editsection" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table class="" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headAdminKbCatEdit">Edycja sekcji</h3></div>
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
                                                <form:label path="categoryName">
                                                    Nazwa sekcji
                                                    <span class="lblTip">(nazwa jest wymagana, max. 128 znaków)</span>
                                                </form:label>
                                                <form:input path="categoryName" cssClass="w98p" cssErrorClass="fieldError w98p" onblur="$('categoryCounter').hide()" onkeyup="this.value.charCount('categoryCounter', 128)"  maxlength="128"/>
                                                <form:errors path="categoryName" cssClass="formError errorBottom"/>
                                                <span id="categoryCounter" class="counter"></span>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop" />
                            <a href="<c:url value="/manage/kb/categories/list.html"/>" class="btnPlain btnMarginTop">powrót do listy</a>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
