<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div id="pagecontentheader"><h2>Zgłoszenia</h2></div>
<div id="pagecontentsubheader"><h3>Zgłaszanie problemu</h3></div>
<form:form commandName="ticket">
    <form:hidden path="ticketstamp"/>
    <div class="contenttop"></div>
    <div class="contentmiddle">
        <table cellspacing="0" id="table1" class="wide">
            <tbody>
            <tr class="top">
                <td id="topcenter">&nbsp;</td>
                <td id="topright">
                    <div>&nbsp;</div>
                </td>
            </tr>
            <tr class="middle">
                <td id="middlecenter">
                    <table id="table2">
                        <tr>
                            <td class="w100 p20l">Zgłaszający:</td>
                            <td><form:input path="notifier" cssClass="w250"/>
                                <font color="red"><form:errors path="notifier"/></font>
                            </td>
                        </tr>
                        <tr>
                            <td class="p20l">Kategoria</td>
                            <td>
                                <form:select path="ticketCategory" items="${categories}"
                                             itemValue="ticketCategoryId"
                                             itemLabel="categoryName" cssClass="w250"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="p20l">Ważność</td>
                            <td>
                                <form:select path="ticketPriority" items="${priorities}" itemValue="priorityId"
                                             itemLabel="priorityName" cssClass="w250"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="p20l">Przyczyna</td>
                            <td>
                                <form:textarea path="subject" rows="6" cols="40"/>
                                <font color="red"><form:errors path="subject"/></font>
                            </td>
                        </tr>
                        <tr>
                            <td class="p20l">Opis zgłoszenia</td>
                            <td>
                                <form:textarea path="description" rows="6" cols="40"/>
                                <font color="red"><form:errors path="description"/></font>
                            </td>
                        </tr>
                        <tr>
                            <td class="p20l">Kroki by powtórzyć</td>
                            <td><form:textarea id="step_by_step" path="stepByStep" rows="6" cols="40"/></td>
                        </tr>
                        <tr>
                            <td class="p20l">Załączniki</td>
                            <td>
                                <script type="text/javascript" src="<c:url value="/js/jquery-1.3.1.min.js"/>"></script>
                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        $("a.group").fancybox({
                                            'hideOnContentClick': false,
                                            'hideOnOverlayClick': false,
                                            'frameWidth' : 320,
                                            'frameHeight' : 150
                                        });
                                    });
                                </script>
                                <script type="text/javascript" src="<c:url value="/js/jquery.easing.1.3.js"/>"></script>
                                <link rel="stylesheet" type="text/css" href="<c:url value="/js/fancybox/fancybox.css"/>"/>
                                <script type="text/javascript"
                                        src="<c:url value="/js/fancybox/fancybox1.js"/>"></script>
                                <a class="group iframe"
                                   href="<c:url value="/tickets/uploadFile.html?ticketstamp=${ticket.ticketstamp}"/>">Dołącz
                                    plik</a>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input class="btn" type="submit" value="Zapisz"/>
                            </td>
                        </tr>
                    </table>


                </td>
                <td id="middleright">&nbsp;</td>
            </tr>
            <tr class="bottom">
                <td id="bottomcenter">&nbsp;</td>
                <td id="bottomright">
                    <div>&nbsp;</div>
                </td>
            </tr>
            </tbody>
        </table>
        
    </div>
</form:form>
<div class="contentbottom"></div>