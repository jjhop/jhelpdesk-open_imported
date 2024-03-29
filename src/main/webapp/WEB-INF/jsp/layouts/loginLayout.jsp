<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title><tiles:getAsString name="title"/> - (${pageContext.response.locale})</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/style.css"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/login.css"/>" />
    </head>
    <body>
        <div id="loginpage">
            <c:if test="${badLogin}">
                <div class="infobox1">
                    <div class="infobox2">
                        <p class="error"><fmt:message key="prompt.error"/></p>
                    </div>
                </div>
            </c:if>
            <div class="infobox1">
                <div class="infobox2">
                    <h2><fmt:message key="prompt.title"/></h2>
                </div>
            </div>
            <div class="infobox1">
                <div class="infobox2">
                    <form name="loginForm" action="<c:url value="/login.html"/>" method="post">
                        <table id="loginForm" cellspacing="0">
                            <tr>
                                <td class="inputs">
                                    <label><fmt:message key="prompt.login"/></label>
                                    <spring:bind path="user.email">
                                        <input type="text" name="<c:out value="${status.expression}"/>" value="" size="23"/>
                                    </spring:bind>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label><fmt:message key="prompt.passw"/></label>
                                    <spring:bind path="user.password">
                                        <input type="password" name="<c:out value="${status.expression}"/>" size="23"/>
                                    </spring:bind>
                                </td>
                            </tr>
                            <tr>
                                <td class="right"><input type="submit" class="btn" value="<fmt:message key="prompt.logon"/>"/></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
        <tiles:insertDefinition name="javascripts" flush="true"/>
    </body>
</html>
