<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="de.berlios.jhelpdesk.model.User" %>
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
                        <img src="${loggedUser.avatarURL}" alt="${loggedUser.fullName}" />
                        <span class="userInfo userName">${loggedUser.fullName}</span>
                        <span class="userInfo userRole"><%
                            User u = (User) session.getAttribute("loggedUser");
                            out.print(u.getUserRole().getRoleName(u.getPreferredLocale()));
                        %></span>
                        <span class="userInfo">${loggedUser.email}</span>
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
