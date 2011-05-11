<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>


<div id="tableofcontent" class="management">
    <div id="pagecontentheader"><h2>Pomoc</h2></div>
    <table cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>Spis treści</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">

                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <td class="lastcol">

                                    <dl id="faqList">

                                        <dt class="accordion_toggle"><a href="javascript:;">Co aplikacja potrafi a czego nie?</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Jak korzystać z mozliwości filtrowania danych?</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Szybki podglad zgłoszenia o znanym identyfikatorze.</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Dodawanie zgłoszenia, walidacja danych.</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Dodawnia komentarza do zgłoszenia.</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Zmiany danych zgłoszenia.</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">Przypisywania do siebie wolnych zgłoszeń.</a></dt>
                                        <dd class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                        <dt class="accordion_toggle"><a href="javascript:">"Zrzucanie" zgłoszeń niemożliwych do obslużenia.</a></dt>
                                        <dd id="last" class="accordion_content">Quisque commodo hendrerit lorem quis egestas. Maecenas quis tortor arcu. Vivamus rutrum nunc non neque consectetur.</dd>

                                    </dl>

                                </td>
                            </tr>
                        </table>
                                    <script type="text/javascript">


                                        Event.observe(window,'load',init,false);
                                        function init() {
                                            accordion = new Accordion('faqList', 'accordion_toggle a');
                                        }

                                    </script>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
        </tr>
    </table>
</div>
