<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editsection" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table class="w100p" cellspacing="0">
        <tr>
            <td class="">
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
                                    <td class="w125">Tytuł</td>
                                    <td class="lastcol">
                                        <form:input path="title"/>
                                        <form:errors path="title"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Wstęp</td>
                                    <td class="lastcol">
                                        <form:textarea path="lead"/>
                                        <form:errors path="lead"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Treść główna</td>
                                    <td class="lastcol">
                                        <form:textarea path="body"/>
                                        <form:errors path="body"/>
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
