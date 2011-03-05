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
                    <td id="topright"><div>&nbsp;</div></td>
                </tr>
                <tr class="middle">
                    <td id="middlecenter">
                        <ul class="formContainer">
                            <li>
                                <label>Zgłaszający</label>
                                <form:input path="notifier" cssErrorClass="w415 fieldError" cssClass="w415"/>
                                <form:errors path="notifier" cssClass="formError errorBottom" />
                            </li>
                            <li class="floatLeft">
                                <label>Kategoria</label>
                                <form:select cssClass="w425" path="ticketCategory" items="${categories}"
                                             itemValue="id"
                                             itemLabel="categoryName" />
                            </li>
                            <li class="floatRight">
                                <label>Ważność</label>
                                <form:select cssClass="w150" path="ticketPriority" items="${priorities}" itemValue="priorityId"
                                             itemLabel="priorityName" />
                            </li>
                            <li class="clearFloat">
                                <label>Przyczyna</label>
                                <form:input cssClass="w99p" cssErrorClass="w99p fieldError" path="subject"/>
                                <form:errors path="subject" cssClass="formError errorBottom" />
                            </li>
                            <li>
                                <label>Opis zgłoszenia</label>
                                <form:textarea cssClass="w99p" cssErrorClass="w99p fieldError" path="description" rows="6" cols="40"/>
                                <form:errors path="description" cssClass="formError errorBottom" />
                            </li>
                            <li>
                                <label>Kroki by powtórzyć</label>
                                <form:textarea cssClass="w99p" id="step_by_step" path="stepByStep" rows="6" cols="40"/>
                            </li>
                            <li>
                                <label>Załączniki</label>
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
                                <style type="text/css">
                                    @import url(<c:url value="/js/fancybox/fancybox.css"/>);
                                </style>
                                <script type="text/javascript"
                                src="<c:url value="/js/fancybox/fancybox1.js"/>"></script>
                                <a class="group iframe" href="<c:url value="/tickets/uploadFile.html?ticketstamp=${ticket.ticketstamp}"/>">Dołącz plik</a>
                            </li>
                            <li>
                                <input class="btn" type="submit" value="Zapisz"/>
                            </li>
                        </ul>
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