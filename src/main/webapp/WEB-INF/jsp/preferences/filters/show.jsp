<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader">
                    <h3>Zarządzanie filtrami
                    </h3>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td>
                                    <ul class="formContainer detailsView">
                                        <li class="w45p">
                                            <label>Nazwa</label>
                                            ${filter.name}
                                        </li>
                                        <c:if test="${not empty filter.description}">
                                        <li>
                                            <label>Opis</label>
                                            ${filter.description}
                                        </li>
                                        </c:if>
                                        <li class="clearFloat floatLeft w45p">
                                            <label>Od <span class="date">${filter.beginDate}</span></label>
                                        </li>
                                        <li class="floatRight w45p">
                                            <label>Do<span class="date">${filter.endDate}</span></label>
                                        </li>
                                        <li class="clearFloat floatLeft w45p">
                                            <label>Status</label>
                                            <c:choose>
                                                <c:when test="${not empty filter.ticketStatuses}">
                                                    <ul class="nested">
                                                    <c:forEach items="${filter.ticketStatuses}" var="s">
                                                        <li>${s.statusName}</li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    Nie dotyczy...
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <li class="floatRight w45p">
                                            <label>Ważność</label>
                                            <c:choose>
                                                <c:when test="${not empty filter.ticketPriorities}">
                                                    <ul class="nested">
                                                    <c:forEach items="${filter.ticketPriorities}" var="p">
                                                        <li>${p.priorityName}</li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    Nie dotyczy...
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <li class="clearFloat floatLeft w45p">
                                            <label>Rozwiązujący</label>
                                            <c:choose>
                                                <c:when test="${not empty filter.saviours}">
                                                    <ul class="nested">
                                                    <c:forEach items="${filter.saviours}" var="user">
                                                        <li>${user}</li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    Nie dotyczy...
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <li class="floatRight w45p">
                                            <label>Zgłaszający</label>
                                            <c:choose>
                                                <c:when test="${not empty filter.notifiers}">
                                                    <ul class="nested">
                                                    <c:forEach items="${filter.notifiers}" var="user">
                                                        <li>${user}</li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    Nie dotyczy...
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                        <li class="clearFloat">
                                            <label>Kategoria zgłoszenia</label>
                                            <c:choose>
                                                <c:when test="${not empty filter.ticketCategories}">
                                                    <ul class="nested">
                                                    <c:forEach items="${filter.ticketCategories}" var="c">
                                                        <li>${c.categoryName}</li>
                                                    </c:forEach>
                                                    </ul>
                                                </c:when>
                                                <c:otherwise>
                                                    Nie dotyczy...
                                                </c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </td>
                            </tr>
                        </table>
                        <a href="<c:url value="/preferences/filters/list.html"/>" class="btnPlain floatLeft">powrót do listy</a>
                        <div class="clearFloat"></div>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>