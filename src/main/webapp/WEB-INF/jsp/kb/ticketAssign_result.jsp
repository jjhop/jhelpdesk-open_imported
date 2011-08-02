<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>


<div class="pagecontentsubheader">
    <h3>Dziękujemy</h3>
</div>
<div class="contentmiddle h335">
    <table class="standardtable" cellspacing="0">
        <tr>
            <td>
                <p>
                    ${message}
                </p>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    setTimeout("window.parent.eval('Lightview.hide(); window.location.reload();')", 3000);
</script>