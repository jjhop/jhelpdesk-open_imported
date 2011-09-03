<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headAdminCat">Dodawanie/edycja kategorii zgłoszeń</h3></div>
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
                                    <td>
                                        <ul class="formContainer">
                                            <li>
                                                <form:label path="categoryName">
                                                    Nazwa kategorii
                                                    <span class="lblTip">(nazwa jest wymagana, max. 64 znaki)</span>
                                                </form:label>
                                                <form:input cssErrorClass="fieldError w98p" maxlength="64" onblur="$('categoryCounter').hide()" onkeyup="this.value.charCount('categoryCounter', 64)" cssClass="w98p" path="categoryName"/>
                                                <form:errors cssClass="formError errorBottom" path="categoryName"/>
                                                <span id="categoryCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <form:label path="categoryDesc">
                                                    Opis
                                                    <span class="lblTip">(opis kategorii wymagany, do wykorzystania w przyszłości, maksymalnie 255 znaków)</span>
                                                </form:label>
                                                <form:textarea cssErrorClass="fieldError w98p" cssClass="w98p" onblur="$('descCounter').hide()" onkeyup="charTextCount(this.form.categoryDesc, 'descCounter', 255)" path="categoryDesc"/>
                                                <form:errors cssClass="formError errorBottom" path="categoryDesc"/>
                                                <span id="descCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <form:checkbox cssClass="floatLeft chk" path="default"/>
                                                <form:label path="default">Domyślna kategoria</form:label>
                                            </li>
                                            <li>
                                                <form:checkbox cssClass="floatLeft chk" path="active"/>
                                                <form:label path="active">Aktywna</form:label>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop" />
                            <a href="<c:url value="/manage/category/list.html"/>" class="btnPlain btnMarginTop">powrót do listy</a>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
