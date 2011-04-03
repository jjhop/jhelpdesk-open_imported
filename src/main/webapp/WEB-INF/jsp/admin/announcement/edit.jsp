<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div id="editannouncement" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Edycja wiadomości</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/announcements/save.html" var="formUrl"/>
                        <form:form commandName="announcement" action="${formUrl}" method="post">
                            <c:if test="${announcement.id != null}">
                                <form:hidden path="id"/>
                            </c:if>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td class="lastcol">
                                        <ul class="formContainer">
                                            <li>
                                                <form:label path="title">Tytuł</form:label>
                                                <form:input path="title" maxlength="255"
                                                            onblur="$('titleCounter').hide()"
                                                            onkeyup="this.value.charCount('titleCounter', 255)"
                                                            cssErrorClass="w98p fieldError" cssClass="w98p"/>
                                                <form:errors path="title" cssClass="formError errorBottom"/>
                                                <span id="titleCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <form:label path="lead">Skrót</form:label>
                                                <form:textarea path="lead"
                                                               onblur="$('shortCounter').hide()"
                                                               onkeyup="this.value = this.value.charTextCount('shortCounter', 45)"
                                                               cssErrorClass="w98p fieldError" cssClass="w98p" />
                                                <form:errors cssClass="formError errorBottom" path="lead"/>
                                                <span id="shortCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <form:label path="body">Treść główna</form:label>
                                                <form:textarea cssClass="w98p" onblur="$('bodyCounter').hide()" onkeyup="this.value = this.value.charTextCount('bodyCounter', 16384)" rows="8" path="body"/>
                                                <form:errors cssClass="formError errorBottom" path="body"/>
                                                <span id="bodyCounter" class="counter"></span>
                                            </li>

                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop floatLeft" />
                            <a href="<c:url value="/announcements/list.html"/>" class="btnPlain floatLeft">anuluj</a>
                            <div class="clearFloat"></div>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
