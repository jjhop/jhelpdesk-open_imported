<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div id="editcategory" class="management">
    <div id="pagecontentheader"><h2>Zarządzanie</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader">
                    <h3>Zarządzanie filtrami
                        <a href="#filtersHelp"
                           class="lightview" title=":: :: width: 400, height: 300, keyboard: true"><img src="<c:url value="/themes/blue/i/btn_help.png"/>" class="refresh" alt="" /></a>
                    </h3>
                </div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <c:url value="/preferences/filters/save.html" var="formUrl"/>
                        <form:form action="${formUrl}" commandName="filter" method="post">
                            <form:hidden path="id"/>
                            <form:hidden path="tfStamp"/>
                            <form:hidden path="owner.userId"/>
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <td>
                                        <c:if test="${not empty message}">
                                            <p id="msg2Hide">${message}</p>
                                            <script type="text/javascript">
                                                hideMe('msg2Hide');
                                            </script>
                                        </c:if>
                                        <ul class="formContainer">
                                            <li class="w45p">
                                                <label>Nazwa</label>
                                                <form:input path="name" onblur="$('nameCounter').hide()" onkeyup="this.value.charCount('nameCounter', 32)" cssClass="w95p" cssErrorClass="fieldError w95p" maxlength="32"/>
                                                <form:errors cssClass="formError errorBottom" path="name"/>
                                                <span id="nameCounter" class="counter"></span>
                                            </li>
                                            <li>
                                                <label>Opis</label>
                                                <form:textarea path="description" onblur="$('descCounter').hide()" onkeyup="this.value = this.value.charTextCount('descCounter', 512)" cssClass="w98p" />
                                                <span id="descCounter" class="counter"></span>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Od</label>
                                                <form:input id="f_date_start" path="beginDate" cssClass="w85p"/>
                                                <img id="f_trigger_c" src="<c:url value="/themes/blue/i/cal.gif"/>" alt="" style="cursor: pointer; border: 0px;"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "f_date_start", ifFormat: "%Y-%m-%d", button: "f_trigger_c", align: "BR", singleClick: true
                                                    });
                                                </script>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Do</label>
                                                <form:input id="f_date_end" path="endDate" cssClass="w85p"/>
                                                <img id="f_trigger_d" src="<c:url value="/themes/blue/i/cal.gif"/>" alt="" style="cursor: pointer; border: 0px;"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField: "f_date_end", ifFormat: "%Y-%m-%d", button: "f_trigger_d", align: "BR", singleClick: true
                                                    });
                                                </script>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Status</label>
                                                <select id="ticketStatuses" class="w99p" size="5" name="ticketStatuses" multiple="multiple">
                                                    <c:forEach items="${ticketStatuses}" var="ts">
                                                        <option value="${ts}"
                                                                <c:forEach items="${filter.ticketStatuses}" var="fts">
                                                                    <c:if test="${ts eq fts}">selected="selected"</c:if>
                                                                </c:forEach>
                                                                >${ts.statusName}</option>
                                                    </c:forEach>
                                                </select>
                                                <input id="_ticketStatuses" type="hidden" name="_ticketStatuses" value="1"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Ważność</label>
                                                <select id="ticketPriorities" class="w99p" size="5" name="ticketPriorities" multiple="multiple">
                                                    <c:forEach items="${ticketPriorities}" var="tp">
                                                        <option value="${tp}"
                                                                <c:forEach items="${filter.ticketPriorities}" var="ftp">
                                                                    <c:if test="${tp eq ftp}">selected="selected"</c:if>
                                                                </c:forEach>
                                                                >${tp.priorityName}</option>
                                                    </c:forEach>
                                                </select>
                                                <input id="_ticketPriorities" type="hidden" name="_ticketPriorities" value="1"/>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>Saviours</label>
                                                <select id="saviours" class="w99p" size="5" name="saviours" multiple="multiple">
                                                    <c:forEach items="${saviours}" var="s">
                                                        <option value="${s.email}"
                                                                <c:forEach items="${filter.saviours}" var="fs">
                                                                    <c:if test="${fs.userId == s.userId}">selected="selected"</c:if>
                                                                </c:forEach>
                                                                >${s.fullName}</option>
                                                    </c:forEach>
                                                </select>
                                                <input id="_saviours" type="hidden" name="_saviours" value="1"/>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>Notifiers</label>
                                                <select id="notifiers" class="w99p" size="5" name="notifiers" multiple="multiple">
                                                    <c:forEach items="${notifiers}" var="n">
                                                        <option value="${n.email}"
                                                                <c:forEach items="${filter.notifiers}" var="fs">
                                                                    <c:if test="${fs.userId == n.userId}">selected="selected"</c:if>
                                                                </c:forEach>
                                                                >${n.fullName}</option>
                                                    </c:forEach>
                                                </select>
                                                <input id="_notifiers" type="hidden" name="_notifiers" value="1"/>
                                            </li>
                                            <li class="clearFloat">
                                                <label>Kategoria</label>
                                                <select id="ticketCategories" class="w995p" size="5" name="ticketCategories" multiple="multiple">
                                                    <c:forEach items="${ticketCategories}" var="tc">
                                                        <option value="${tc.id}"
                                                                <c:forEach items="${filter.ticketCategories}" var="ftc">
                                                                    <c:if test="${tc eq ftc}">selected="selected"</c:if>
                                                                </c:forEach>
                                                                >${tc.categoryName}</option>
                                                    </c:forEach>
                                                </select>
                                                <input id="_ticketCategories" type="hidden" name="_ticketCategories" value="1"/>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
                            <input type="submit" value="zapisz" class="btn btnMarginTop floatLeft"/>
                            <a href="<c:url value="/preferences/filters/list.html"/>" class="btnPlain floatLeft">powrót do listy</a>
                            <div class="clearFloat"></div>
                        </form:form>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
<div id="filtersHelp" style="display: none">
    <h2>Pomoc do formularza edycji filtrów</h2>
    <p>
        <strong>Nazwa filtru</strong> jest tą samą nazwą, która wyświetla się w menu "Zgłoszenia" (została
        ograniczona do 32 znaków). Warto dla filtra wybrać nazwę, która ma jakieś znacznie 
        w kontekście zgłoszeń, które pojawią się po jego zastosowaniu
        (np. Moje zgłoszenia, Zgłoszenia pilne nierozwiązane).
    </p>
    <p>
        Pole <strong>Od</strong> oraz <strong>Do</strong> wyznaczają dolną i górną granicę czasową
        <em>zarejestrowania</em> zgłoszenia w systemie. Jeśli w tych polach nie będzie żadnej
        wartości to data zarejestrowania zgłoszenia nie będzie brana pod uwagę podczas wyszukiwania.
        Jeśli pojawi się jedna z dat to zostanie ona potraktowana jako granic (dolna lub górna
        w zależności od tego, która z dat zostanie podana).
    </p>
    <p>
        W przypadku list niewybranie żadnej wartości jest jednoznaczne z usunięciem tego pola z
        kryteriów wyszukiwania. Jeśli zaznaczone zostaną wszystkie wartości to nowe - te, które
        pojawią się po zbudowaniu filtra - nie będą brane pod uwagę (nowe wartości mogą pojawić
        się tylko w listach <strong>Zgłaszający</strong>, <strong>Rozwiązujący</strong>,
        <strong>Kategoria zgłoszenia</strong>).
    </p>
</div>