<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>


${errorMessage}

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
                                        <ul class="formContainer">
                                            <li class="w45p">
                                                <label>
                                                    Nazwa
                                                </label>
                                                ${filter.name}
                                            </li>
                                            <li>
                                                <label>
                                                    Opis
                                                </label>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>
                                                    Od
                                                </label>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>
                                                    Do
                                                </label>
                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>
                                                    Status
                                                </label>

                                            </li>
                                            <li class="floatRight w45p">
                                                <label>
                                                    Ważność
                                                </label>

                                            </li>
                                            <li class="floatLeft w45p">
                                                <label>
                                                    Rozwiązujący
                                                </label>
                                            </li>
                                            <li class="floatRight w45p">
                                                <label>
                                                    Zgłaszający
                                                </label>

                                            </li>
                                            <li class="clearFloat">
                                                <label>
                                                    Kategoria zgłoszenia
                                                </label>
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