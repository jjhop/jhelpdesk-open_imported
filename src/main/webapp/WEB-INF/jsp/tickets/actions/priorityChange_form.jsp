<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="de.berlios.jhelpdesk.model.User" %>
<%@ page import="de.berlios.jhelpdesk.model.TicketPriority" %>

<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
%>

<div class="pagecontentsubheader">
    <h3 id="headTicketConfirm">Zmiana priorytetu zgłoszenia</h3>
</div>
<div class="contentmiddle h425">
    <c:url value="/tickets/${ticketId}/priorityChange.html" var="formURL"/>
    <form:form commandName="form" action="${formURL}" method="post">
        <table class="standardtable" cellspacing="0">
            <tr>
                <td>
                    <ul class="formContainer">
                        <li class="plain">
                            <label>Bieżący priorytet:</label>
                            <span class="ticketPriority tpLOW">
                                <%
                                    TicketPriority currentPriority = (TicketPriority)request.getAttribute("currentPriority");
                                    out.print(currentPriority.getPriorityName(currentUser.getPreferredLocale()));
                                %>
                            </span>
                        </li>
                        <li>
                            <label>
                                Nowy priorytet
                                <span class="lblTip">(wybierz nowy priorytet z poniższej listy)</span>
                            </label>
                            <select id="ddlUser" name="priority" class="w20">
                            <c:forEach var="priority" items="${priorities}">
                                <option value="${priority.priorityId}" <c:if test="${priority == form.priority}">selected="selected"</c:if>>
                                <%
                                    TicketPriority priority = (TicketPriority) pageContext.getAttribute("priority");
                                    out.print(priority.getPriorityName(currentUser.getPreferredLocale()));
                                %>
                                </option>
                            </c:forEach>
                            </select>
                        </li>
                        <li>
                            <label>Komentarz
                                <span class="lblTip">(komentarz jest wymagany, jego maksymalna długość do 4096 znaków)</span>
                            </label>
                            <form:textarea id="comment" path="commentText"
                                           cssClass="addComment" cssErrorClass="addComment fieldError"
                                           onkeyup="charTextCount(this.form.comment, 'commentCounter', 4096)"
                                           onblur="$('commentCounter').hide()"
                                           rows="3" cols="40"/>
                            <form:errors cssClass="formError errorBottom" path="commentText"/>
                            <span id="commentCounter" class="counter"></span>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
        <div class="bottomButtons">
            <input type="submit" value="Zmień" class="btn"/>
            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain">anuluj</a>
        </div>
    </form:form>
</div>