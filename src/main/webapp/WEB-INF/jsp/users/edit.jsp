<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="de.berlios.jhelpdesk.model.User"%>
<%@ page import="de.berlios.jhelpdesk.model.Role"%>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="showuser" class="management">
    <div id="pagecontentheader" class="settings"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headAdminUser">Edycja danych użytkownika</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                            <form:form action="" commandName="userForm">
                            <c:if test="${userForm.userId != null}">
                                <form:hidden path="userId"/>
                            </c:if>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td class="lastcol">
                                        <ul class="formContainer">
                                            <li class="">
                                                <label>
                                                    Email
                                                    <span class="lblTip">(email jest wymagany, prawidłowy format np. <i>jan.kowalski@example.com</i>, max. 128 znaków)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('mailCounter', 128)" onblur="$('mailCounter').hide()" cssClass="w98p" cssErrorClass="fieldError w98p" path="email" maxlength="128"/>
                                                <span id="mailCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="email"/>
                                            </li>
                                            <li class="clearFloat floatLeft w45p">
                                                <label>
                                                    Imię
                                                    <span class="lblTip">(imię jest wymagane, max. 64 znaki)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('firstNameCounter', 64)" onblur="$('firstNameCounter').hide()" cssClass="w95p" cssErrorClass="fieldError w95p" path="firstName" maxlength="64"/>
                                                <span id="firstNameCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="firstName"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>
                                                    Nazwisko
                                                    <span class="lblTip">(nazwisko jest wymagane, max. 128 znaków)</span>
                                                </label>
                                                <form:input onkeyup="this.value.charCount('lastNameCounter', 128)" onblur="$('lastNameCounter').hide()" cssClass="w95p" cssErrorClass="fieldError w95p" path="lastName" maxlength="128"/>
                                                <span id="lastNameCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="lastName"/>
                                            </li>
                                            <li class="clearFloat floatLeft w45p">
                                                <label>
                                                    Hasło
                                                    <span class="lblTip">(min. 6 znaków, w tym min. jedna cyfra)</span>
                                                </label>
                                                <form:password onkeyup="this.value.charCount('pwd1Counter', 64)" onblur="$('pwd1Counter').hide()" cssClass="w95p" path="password" maxlength="64"/>
                                                <span id="pwd1Counter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="password"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>
                                                    Powtórz hasło
                                                    <span class="lblTip">Powtórz wpisane hasło</span>
                                                </label>
                                                <input type="text" class="w95p" name="" maxlength="64"/>
                                                <span id="pwd2Counter" class="counter"></span>
                                            </li>
                                            <li class="clearFloat floatLeft w45p">
                                                <label>Telefon</label>
                                                <form:input onkeyup="this.value.charCount('phoneCounter', 20)" onblur="$('phoneCounter').hide()" cssClass="w95p" cssErrorClass="fieldError w95p" path="phone" maxlength="20"/>
                                                <span id="phoneCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="phone"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Mobile</label>
                                                <form:input onkeyup="this.value.charCount('mobileCounter', 20)" onblur="$('mobileCounter').hide()" cssClass="w95p" cssErrorClass="fieldError w95p" path="mobile" maxlength="20"/>
                                                <span id="mobileCounter" class="counter"></span>
                                                <form:errors cssClass="formError errorBottom" path="mobile"/>
                                            </li>
                                            <li class="clearFloat floatLeft w45p">
                                                <label>Rola</label>
                                                <select id="userRole" name="userRole" class="w95p">
                                                <% User u = (User)request.getAttribute("userForm"); %>
                                                <c:forEach items="${roles}" var="role">
                                                    <% Role r = (Role)pageContext.getAttribute("role"); %>
                                                    <option value="<c:out value="${role.roleCode}"/>"
                                                        <% if (r.equals(u.getUserRole())) {%>selected="selected"<%}%>>
                                                        <%= r.getRoleName(((User)session.getAttribute("loggedUser")).getPreferredLocale()) %>
                                                    </option>
                                                </c:forEach>
                                                </select>
                                            </li>
                                            <li class="floatRight w45p chk">
                                                <form:checkbox id="active1" cssClass="chk floatLeft" path="active"/><label>Aktywny</label>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop" />
                            <a href="<c:url value="/manage/users/list.html"/>" class="btnPlain btnMarginTop">anuluj</a>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>