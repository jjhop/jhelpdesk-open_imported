<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editsection" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table class="" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headAdminKbArt">Edycja artykułu</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url var="url" value="/manage/kb/articles/save.html"/>
                        <form:form commandName="article" action="${url}">
                            <c:if test="${article.id != null}">
                                <form:hidden path="id"/>
                            </c:if>
                            <form:hidden path="category"/>
                            <form:hidden path="author"/>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td>
                                        <ul class="formContainer">
                                            <li>
                                                <form:label path="title">
                                                    Tytuł artykułu
                                                    <span class="lblTip">(tytuł jest wymagany, ale ograniczony do 255 znaków)</span>
                                                </form:label>
                                                <form:input onkeyup="this.value.charCount('titleCounter', 255)" onblur="$('titleCounter').hide()" cssClass="w99p" cssErrorClass="fieldError w99p" path="title" maxlength="255"/>
                                                <span id="titleCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="title"/>
                                            </li>
                                            <li>
                                                <form:label path="lead">
                                                    Wstęp
                                                    <span class="lblTip">(wstęp jest wymagany, max. 4096 znaków)</span>
                                                </form:label>
                                                <form:textarea onkeyup="this.value.charCount('leadCounter', 4096)" onblur="$('leadCounter').hide()" cssClass="w99p" cssErrorClass="fieldError w99p" rows="3" path="lead"/>
                                                <span id="leadCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="lead"/>
                                            </li>
                                            <li>
                                                <form:label path="body">
                                                    Treść główna
                                                    <span class="lblTip">(treść jest wymagana, max. 16384 znaków)</span>
                                                </form:label>
                                                <form:textarea onkeyup="charTextCount(this.form.body, 'bodyCounter', 16384)" onblur="$('bodyCounter').hide()" cssClass="w99p" cssErrorClass="fieldError w99p" rows="7" path="body"/>
                                                <span id="bodyCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="body"/>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop" />
                            <a href="<c:url value="/manage/kb/category/${article.category.id}/articles.html"/>" class="btnPlain btnMarginTop">powrót do listy</a>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
