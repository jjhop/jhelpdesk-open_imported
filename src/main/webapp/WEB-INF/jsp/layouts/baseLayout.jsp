<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
    <head>
        <title><tiles:getAsString name="title"/></title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <tiles:insertDefinition name="javascripts" flush="true"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/hd-base.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/calendar-hd.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/nav.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/tabview.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/css/lightview.css"/>"/>
    </head>
    <body>
        <div id="pagecontainer">
            <div id="pageheader"><a href="<c:url value="/"/>"><img src="<c:url value="/themes/blue/i/logo_jhd_beta.png"/>" alt="jHelpDesk (beta)" /></a>
                <ul id="loggedUser">
                    <li>
                        <b>${user.fullName}</b>
                        <ul id="loggedUserInfo">
                            <li>
                                <img src="http://www.gravatar.com/avatar/2cead66852e686d84eb4b1e7d4a9d416?d=mm&s=30" alt="${user.fullName}" />
                                <span class="userInfo">Rola: administrator</span>
                                <span class="userInfo">E-mail: ${user.email}</span>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div id="pagemenu"><tiles:insertAttribute name="menuPanel" /></div>
            <div id="pagecontent"><tiles:insertAttribute name="content" /></div>
            <div id="pagefooter"><tiles:insertAttribute name="footer" /></div>
        </div>
        <div id="filterbox" style="display:none;"><tiles:insertAttribute name="filterForm" ignore="true"/></div>
    </body>
</html>
