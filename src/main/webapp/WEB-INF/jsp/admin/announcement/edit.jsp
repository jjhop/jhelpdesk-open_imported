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
                        <form action="<c:url value="/announcements/save.html"/>" method="post">
                            <c:if test="${announcement.id != null}">
                                <spring:bind path="announcement.id">
                                    <input type="hidden" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"/>
                                </spring:bind>
                            </c:if>

                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td class="lastcol">

                                        <ul class="formContainer">
                                            <li>
                                                <label>Tytul</label>
                                                <spring:bind path="announcement.title">
                                                    <input class="w98p" type="text" name="<c:out value="${status.expression}"/>" value="<c:out value="${status.value}"/>"
                                                           <c:if test="${not empty status.errorMessage}">class="hintanchor"
                                                               onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                           </c:if>/>
                                                </spring:bind>
                                                <form:errors cssClass="formError errorBottom" path="announcement.title"/>
                                            </li>
                                            <li>
                                                <label>Skrót</label>
                                                <spring:bind path="announcement.lead">
                                                    <textarea  class="w98p"
                                                        name="<c:out value="${status.expression}"/>" rows="4" cols="30"
                                                        <c:if test="${not empty status.errorMessage}">class="hintanchor"
                                                            onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                        </c:if>><c:out value="${status.value}"/></textarea>
                                                </spring:bind>
                                                <form:errors cssClass="formError errorBottom" path="announcement.lead"/>
                                            </li>
                                            <li>
                                                <label>Treść główna</label>
                                                <spring:bind path="announcement.body">
                                                    <textarea class="w98p"
                                                        name="<c:out value="${status.expression}"/>" rows="6" cols="30"
                                                        <c:if test="${not empty status.errorMessage}">class="hintanchor"
                                                            onMouseover="showhint('<c:out value="${status.errorMessage}"/>', this, event, '150px')"
                                                        </c:if>><c:out value="${status.value}"/></textarea>
                                                </spring:bind>
                                            </li>
                                            <li>
                                                <input type="submit" value="zapisz" class="btn" />
                                            </li>
                                        </ul>

                                    </td>
                                </tr>
     
                            </table>
 
                        </form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
