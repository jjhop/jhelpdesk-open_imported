<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp" %>

Czy jesteś pewien?

<form action="" method="post">
    <input type="hidden" name="approve" value="true"/>
    <input type="submit" value="Tak, przypisz do mnie"/>
    <a href="javascript:window.parent.eval('Lightview.hide()');">Nie, jednak rezygnuję</a>
</form>