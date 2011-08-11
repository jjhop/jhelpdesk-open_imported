<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Powiąż zgłoszenie z artykułem</h3>
</div>
<div class="contentmiddle h335">
    <table class="standardtable" cellpadding="0" cellspacing="0">
        <tr>
            <td class="lastcol">
                <ul class="formContainer">
                    <li class="single">
                        <label>Podaj tytuł lub numer poprzedzony "#"</label>
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
        Wybrany artykuł jest już powiązane
    </p>
    <div class="bottomButtons">
        <form method="post" action="">
            <input type="hidden" name="aId" id="aId" value="${article.id}"/>
            <input id="btnAssignTicket" type="submit" value="Powiąż" disabled="disabled" class="btn btnDisabled"/>
            <a href="javascript:window.parent.eval('Lightview.hide()');" class="btnPlain">anuluj</a>
        </form>

    </div>
</div>

<script type="text/javascript">
    new Ajax.Autocompleter("autocomplete", "autocomplete_choices", "<c:url value="/tickets/${ticketId}/articles/search.html"/>", {
        minChars: 2,
        afterUpdateElement: getArticle
    });

    function getArticle(text, li) {

        var artID = li.id.substr(3);
        $("aId").value = artID;

        var selected;
        var artCat = li.getElementsByClassName('entryCategory')[0].innerHTML;
        var artTitle = li.getElementsByClassName('entryText')[0].innerHTML;
        var artMeta = li.getElementsByClassName('entryMeta')[0].innerHTML;
        selected = '<span class="entryID">Artykuł #' + artID + '</span>';
        selected += '<span class="entryCategory">Kategoria<span class="name">' + artCat + '</span></span>';
        selected += '<span class="entryText">' + artTitle + '</span>';
        selected += '<span class="entryMeta">' + artMeta + '</span>';

        if (li.hasClassName("connected")) {
            $("btnAssignTicket").writeAttribute('disabled', 'disabled').addClassName('btnDisabled');
            $("isAssigned").show();
        }
        else {
            if($("btnAssignTicket").hasAttribute('disabled')) {
                $("btnAssignTicket").removeAttribute('disabled');
            }
            $("isAssigned").hide();
            $("btnAssignTicket").removeClassName('btnDisabled');
        }
        $("selectedItemInfo").innerHTML = selected;
        $("selectedItem").show();
        $("initialInfo").hide();
        $("autocomplete").value = "";
    }
</script>
