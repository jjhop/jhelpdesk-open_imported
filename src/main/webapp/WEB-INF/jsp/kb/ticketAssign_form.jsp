<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Komentarz do zlecenia</h3>
</div>
<div class="contentmiddle">
    <form action="" method="get">
        <table class="standardtable" cellpadding="0" cellspacing="0">
            <tr>
                <td class="lastcol">
                    <input type="hidden" id="tid" name="tid"/>
                    <ul class="formContainer">
                        <li class="single">
                            <label>Podaj przyczynę lub numer poprzedzony "#"</label>
                            <input class="w98p floatLeft" type="text" id="autocomplete" name="q"/>
                        </li>
                    </ul>
                    <div id="autocompleteContainer">
                        <div id="autocomplete_choices" class="autocomplete"></div>
                    </div>
                </td>
            </tr>
        </table>
        <div id="selectedTicket"></div>
    </form>
</div>

<script type="text/javascript">
    new Ajax.Autocompleter("autocomplete", "autocomplete_choices", "<c:url value="/help/base/articles/${articleId}/searchTickets.html"/>", {
        minChars: 2,
        afterUpdateElement: getSelectionId
    });

    function getSelectionId(text, li) {
        var ticket = li.id;
        $("tid").value = ticket.substr(3);
        $("selectedTicket").innerHTML = li.innerHTML;
        $("autocomplete").value = "";
    }
</script>

