<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
    <head>
        <title><tiles:getAsString name="title"/></title>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <tiles:insertDefinition name="javascripts" flush="true"/>
        <spring:theme code="base.css" var="baseCss"/>
        <spring:theme code="calendar.css" var="calendarCss"/>
        <spring:theme code="nav.css" var="navCss"/>
        <spring:theme code="tabview.css" var="tabviewCss"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="${baseCss}"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="${calendarCss}"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="${navCss}"/>" />
        <link rel="stylesheet" type="text/css" href="<c:url value="${tabviewCss}"/>" />
    </head>
    <body>
        <div id="pagecontainer">
            <div id="pageheader"><a href="<c:url value="/"/>">jHelpDesk</a></div>
            <div id="pagemenu"><tiles:insertAttribute name="menuPanel" /></div>
            <div id="pagecontent"><tiles:insertAttribute name="content" /></div>
            <div id="pagefooter"><tiles:insertAttribute name="footer" /></div>
        </div>
        <div id="filterbox" style="display:none;"><tiles:insertAttribute name="filterForm" ignore="true"/></div>
    </body>
</html>
