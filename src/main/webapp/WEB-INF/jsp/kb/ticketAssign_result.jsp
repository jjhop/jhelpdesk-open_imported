<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

<div class="pagecontentsubheader">
    <h3 id="headTicketArticles">Dziękujemy</h3>
</div>
<div class="contentmiddle h335">
    <table class="standardtable" cellspacing="0">
        <tr>
            <td>
                <p>
                    <c:choose>
                        <c:when test="${success}">
                            Artykuł został powiązany.
                        </c:when>
                        <c:otherwise>
                            Nie można powiązać zgłoszenia ze wskazanych artykułem.
                        </c:otherwise>
                    </c:choose>
                </p>
            </td>
        </tr>
    </table>
</div>
<script type="text/javascript">
    setTimeout("window.parent.eval('Lightview.hide(); window.location.reload();')", 1500);
</script>