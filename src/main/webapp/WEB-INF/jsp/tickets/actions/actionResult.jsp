<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3>Dziękujemy</h3>
</div>
<div class="contentmiddle">
    <table class="standardtable" cellspacing="0">
        <tr>
            <td>
                <p id="actionMailConfirm">
                    dzieki itd... wysłaliśmy maile.. tararara... zamknij...
                </p>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
    setTimeout("window.parent.eval('Lightview.hide(); window.location.reload();')", 1500);
</script>