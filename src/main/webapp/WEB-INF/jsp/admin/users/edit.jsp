<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="showuser" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Edycja danych użytkownika</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/manage/users/save.html" var="formUrl"/>
                        <form:form action="${formUrl}" commandName="user" >
                            <c:if test="${user.userId != null}">
                                <form:hidden path="userId"/>
                            </c:if>
                            <table cellspacing="0" class="standardtable">
                                <spring:hasBindErrors name="user">
                                    <tr>
                                        <td colspan="2" style="color: red" class="lastcol">
                                            <form:errors path="*" />
                                        </td>
                                    </tr>
                                </spring:hasBindErrors>
                                <tr>
                                    <td class="lastcol">
                                        <ul class="formContainer">
                                            <li class="floatLeft w45p">
                                                <label>Imię</label>
                                                <form:input cssClass="w95p" path="firstName"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Nazwisko</label>
                                                <form:input cssClass="w95p" path="lastName"/>
                                            </li>
                                            <li class="clearFloat">
                                                <label>Login</label>
                                                <form:input cssClass="w98p" path="login"/>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Hasło</label>
                                                <form:password cssClass="w95p" path="password"/>
                                            </li>

                                            <li class="floatRight w45p">
                                                <label>Powtórz</label>
                                                <input type="text" class="w95p" name="" />
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Email</label>
                                                <form:input cssClass="w95p" path="email"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Telefon</label>
                                                <form:input cssClass="w95p" path="phone"/>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Rola</label>
                                                <form:select  cssClass="w95p" id="userRole" path="userRole" items="${roles}" itemValue="roleCode" itemLabel="roleName"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Mobile</label>
                                                <form:input cssClass="w95p" path="mobile"/>
                                            </li>
                                            <li class="clearFloat w45p">
                                                <form:checkbox id="active1" cssClass="chk floatLeft" path="active"/><label>Aktywny</label>
                                            </li>
                                            <li class="clearFloat">
                                                <label>Avatar</label>
                                                <input type="file"/>
                                                <ul class="legend">
                                                    <li>96x96px, lub wytniemy ze środka obrazka</li>
                                                    <li>jeśli nie dodasz awataru, spróbujemy skorzystać z Gravatara</li>
                                                    <li>możesz także <a>usunąć</a> awatar</li>
                                                </ul>
                                            </li>
                                            <li>
                                                <input type="submit" value="zapisz" class="btn floatRight" />
                                            </li>
                                        </ul>

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