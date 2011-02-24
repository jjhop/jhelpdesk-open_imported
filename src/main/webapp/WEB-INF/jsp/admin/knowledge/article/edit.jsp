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
                        <c:url var="url" value="/manage/kb/articles/${formAction}.html"/>
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
                                        <spring:bind path="article.title">
                                            <input class="w99p" type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
                                                   <c:if test="${not empty status.errorMessage}">class="hintanchor"
                                                       onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                   </c:if>/>
                                        </spring:bind>
                                        <form:errors path="title"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Wstęp</td>
                                    <td class="lastcol">
                                        <spring:bind path="article.lead">
                                            <textarea class="hintanchor w99p"
                                                name="<c:out value="${status.expression}"/>" rows="4" cols="30"
                                                <c:if test="${not empty status.errorMessage}">
                                                    onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                </c:if>><c:out value="${status.value}"/></textarea>
                                        </spring:bind>
                                        <form:errors path="lead"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Treść główna</td>
                                    <td class="lastcol">
                                        <spring:bind path="article.body">
                                            <textarea class="hintanchor w99p"
                                                name="<c:out value="${status.expression}"/>" rows="8" cols="30"
                                                <c:if test="${not empty status.errorMessage}">
                                                    onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                </c:if>><c:out value="${status.value}"/></textarea>
                                        </spring:bind>
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
