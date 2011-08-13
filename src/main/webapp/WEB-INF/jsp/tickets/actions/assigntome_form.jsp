<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Prośba o potwierdzenie</h3>
</div>

<div class="contentmiddle hAuto">
    <form action="" method="post">
        <input type="hidden" name="approve" value="true"/>
        <table class="standardtable" cellspacing="0">
            <tr>
                <td>
                    <p class="question">
                        Czy jesteś pewien?
                    </p>
                    <p>
                        <input class="btn" type="submit" value="Tak, przypisz do mnie"/>
                        <a href="javascript:window.parent.eval('Lightview.hide()');">Nie, jednak rezygnuję</a>
                    </p>
                </td>
            </tr>
        </table>
    </form>
</div>




