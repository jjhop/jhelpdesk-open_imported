<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<script type="text/javascript" src="<c:url value="/js/calendar.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/lang/calendar-en.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/calendar-setup.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/prototype.1.7.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/scriptaculous.1.9.0.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/effects.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/builder.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/script.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/stereotabs.js"/>"></script>
<script type="text/javascript">

String.prototype.charCount = function (counter, ml) {
    var charsLeft = ml - this.length;
    var percent = Math.ceil(ml * 0.90);
    $(counter).update(charsLeft);

    (this.length >= percent) ? $(counter).show() : $(counter).hide();
}

String.prototype.charTextCount = function (counter, ml) {
    var charsLeft = ml - this.length;
    var percent = Math.ceil(ml * 0.90);
    $(counter).update(charsLeft);

    (this.length >= percent) ? $(counter).show() : $(counter).hide();

    return this.slice(0, ml);
    
}

</script>