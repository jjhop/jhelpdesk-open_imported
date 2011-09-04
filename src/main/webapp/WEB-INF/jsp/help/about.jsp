<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div id="tableofcontent" class="management">
    <div id="pagecontentheader" class="about"><h2>Pomoc</h2></div>
    <div id="content">
        <div class="contenttop"></div>
        <div class="contentmiddle">
            <table cellspacing="0" id="table1">
                <tbody>
                    <tr class="middle">
                        <td id="middlecenter" class="rndCrn5px">
                            <div id="aboutJHD">
                                <h1>jHelpDesk <span>wersja 1.0.0-OSE.GA</span></h1>
                                <p>
                                    Nullam in dui mauris. Vivamus hendrerit arcu sed erat molestie vehicula. Sed auctor neque eu tellus.
                                </p>
                                <h4>Ważne adresy:</h4>
                                <ul>
                                    <li>
                                        <a href="http://www.jhelpdesk-online.com" target="_blank">jhelpdesk-online.com</a>
                                        - komercyjne wsparcie dla projektu
                                    </li>
                                    <li>
                                        <a href="https://bitbucket.org/buzzlers.com/jhelpdesk" target="_blank">bitbucket.org/buzzlers.com/jhelpdesk</a>
                                        - kod źródłowy, wiki, wsparcie, wersje instalacyjne
                                    </li>
                                </ul>
                                <h4>Licencja:</h4>
                                <p>
                                    Program rozprowadzany jest na podwójnej licencji. Szczegółowe informacje
                                    znajdują się pod adresem: <a href="http://www.jhelpdesk-online.com/licensing" target="_blank">jhelpdesk-online.com/licensing</a>
                                </p>
                                <div class="bottomLogos">
                                    <a id="logoJHD" href="http://www.jhelpdesk-online.com" target="_blank"></a>
                                    <a id="logoBuzz" href="http://www.buzzlers.com" target="_blank"></a>
                                </div>
                            </div>
                        </td>
                        <td id="jhdBanner">
                            <img src="<c:url value="/themes/blue/i/jhd_banner.jpg"/>" alt="O programie" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="contentbottom"></div>
    </div>
</div>
