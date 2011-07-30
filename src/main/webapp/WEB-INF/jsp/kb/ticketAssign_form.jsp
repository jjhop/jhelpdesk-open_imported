<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Komentarz do zlecenia</h3>
</div>
<div class="contentmiddle h335">
    <table class="standardtable" cellpadding="0" cellspacing="0">
        <tr>
            <td class="lastcol">
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
    <div id="selectedTicket">
        <table id="" class="standardtable marginTop10p" cellpadding="0" cellspacing="0">
            <tr>
                <td class="lastcol">
                    <div id="selectedTicketInfo"></div>
                </td>
            </tr>
        </table>

        <form method="post" action="/">
            <input type="hidden" id="tid" name="tid"/>
            <input id="btnAssignTicket" type="submit" value="Powiąż" class="btn floatLeft marginTop10p" />
            <a class="btnPlain floatLeft" href="#">anuluj</a>
        </form>

    </div>
    <script type="text/javascript">
        $('selectedTicket').hide();
    </script>
</div>

<script type="text/javascript">
    new Ajax.Autocompleter("autocomplete", "autocomplete_choices", "<c:url value="/help/base/articles/${articleId}/searchTickets.html"/>", {
        minChars: 2,
        afterUpdateElement: getTicket
    });

    function getTicket(text, li) {
        var ticketID = li.id;
        var ticketText = li.innerHTML;

        $("tid").value = ticketID.substr(3);

        if(li.hasClassName("connected"))
        {
            $("btnAssignTicket").writeAttribute('disabled', 'disabled');
            ticketText += '<span class="entryAssigned">Wybrane zgłoszenie jest już powiązane</span>';
        }
        $("selectedTicketInfo").innerHTML = ticketText;
        $("selectedTicket").show();
        $("autocomplete").value = "";

    }
</script>

