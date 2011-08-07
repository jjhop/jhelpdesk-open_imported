<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Powiąż zgłoszenie z artykułem</h3>
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
    <div id="selectedItem" style="display: none">
        <table id="" class="standardtable marginTop10p" cellpadding="0" cellspacing="0">
            <tr>
                <td class="lastcol">
                    <div id="selectedItemInfo"></div>
                </td>
            </tr>
        </table>
    </div>
    <div id="initialInfo">
        <p>
        Skorzystaj z powyższego formularza, aby wyszukać zgłoszenie, które chcesz powiązać
        z bieżacym artykułem. Jeśli:
        </p>
        <ul>
            <li>
                zaczniesz od znaku <strong>#</strong> wszystko co wpiszesz za nim
        potraktujemy jako identyfikator zgłoszenia i spróbujemy je odnaleźć (powinnien to być ciąg cyfr).
            </li>
            <li>
                wpiszesz cokolwiek, co nie zaczyna się od znaku <strong>#</strong>, będziemy tego szukać w polu
        <strong>Przyczyna zgłoszenia</strong>.
            </li>
        </ul>
        <p>
        W obu wypadkach zaczynamy szukać dopiero, gdy wpiszesz drugi znak. Informacja o wynikach
        będzie uaktualniana wraz z każdym wpisanym znakiem.
        </p>
    </div>
    <p id="isAssigned" style="display: none;">
        Wybrane zgłoszenie jest już powiązane
    </p>
    <div class="bottomButtons">
        <form method="post" action="<c:url value="/help/base/articles/${articleId}/tickets/new.html"/>">
            <input type="hidden" id="tId" name="tId"/>
            <input id="btnAssignTicket" type="submit" value="Powiąż" class="btn"/>
            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain">anuluj</a>
        </form>
    </div>
</div>

<script type="text/javascript">
    new Ajax.Autocompleter("autocomplete", "autocomplete_choices", "<c:url value="/help/base/articles/${articleId}/searchTickets.html"/>", {
        minChars: 2,
        afterUpdateElement: getTicket
    });

    function getTicket(text, li) {

        var ticketID = li.id.substr(3);
        $("tId").value = ticketID;

        var selected;
        var ticketCat = li.getElementsByClassName('entryCategory')[0].innerHTML;
        var ticketText = li.getElementsByClassName('entryFullText')[0].innerHTML;
        var ticketMeta = li.getElementsByClassName('entryMeta')[0].innerHTML;
        selected = '<span class="entryID">Zgłoszenie #' + ticketID + '</span>';
        selected += '<span class="entryCategory">Kategoria<span class="name">' + ticketCat + '</span></span>';
        selected += '<span class="entryText">' + ticketText + '</span>';
        selected += '<span class="entryMeta">' + ticketMeta + '</span>';

        if (li.hasClassName("connected")) {
            $("btnAssignTicket").writeAttribute('disabled', 'disabled').addClassName('btnDisabled');
            $("isAssigned").show();
        }
        $("selectedItemInfo").innerHTML = selected;
        $("selectedItem").show();
        $("initialInfo").hide();
        $("autocomplete").value = "";
    }
</script>
