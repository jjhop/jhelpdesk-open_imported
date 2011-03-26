<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editsection" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="" cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Edycja artykułu</h3></div>
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
                                                <label>Tytuł</label>
                                                <form:input cssClass="w99p" cssErrorClass="fieldError w99p" path="title"/>
                                                <form:errors cssClass="formError errorBottom" path="title"/>
                                            </li>
                                            <li>
                                                <label>Wstęp</label>
                                                <form:textarea cssClass="w99p" cssErrorClass="fieldError w99p" rows="3" path="lead"/>
                                                <form:errors cssClass="formError errorBottom" path="lead"/>
                                            </li>
                                            <li>
                                                <label>Treść główna</label>
                                                <form:textarea cssClass="w99p" cssErrorClass="fieldError w99p" rows="7" path="body"/>
                                                <form:errors cssClass="formError errorBottom" path="body"/>
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
