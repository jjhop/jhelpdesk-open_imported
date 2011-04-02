<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-type" content="text/html; charset=utf-8"/>
        <tiles:insertDefinition name="javascripts" flush="true"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/themes/blue/css/hd-base.css"/>"/>
    </head>
    <body>
        <tiles:insertAttribute name="content" />
    </body>
</html>
