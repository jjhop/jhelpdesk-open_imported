<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader" class="kb"><h2>Baza wiedzy</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div class="pagecontentsubheader"><h3 id="headKBList">a co tutaj?</h3></div>
                <div id="content">
                    <div class="contenttop"></div>
                    <div class="contentmiddle">
                        <form action="<c:url value="/help/kb/search.html"/>">
                            <table cellspacing="0" class="standardtable">
                                <tr>
                                    <th colspan="4" class="lastcol">Kryteria wyszukiwania</th>
                                </tr>
                                <tr>
                                    <td>Szukana fraza</td>
                                    <td colspan="2"><input type="text" name="query" class="txtKB" size="70" /></td>
                                    <td class="lastcol"><input type="submit" value="Szukaj" class="btn" /></td>
                                </tr>
                            </table>
                        </form>
                        <c:if test="${msg != null}">
                            <p id="msg2Hide" class="msg">${msg}</p>
                            <script type="text/javascript">
                                hideMe('msg2Hide');
                            </script>
                        </c:if>
                        <br/>
                        <table cellspacing="0" class="standardtable">
                            <tr>
                                <th colspan="2" class="lastcol">Ostatnie artykuły</th>
                            </tr>
                            <tr>
                                <td class="lastcol">
                                    <ol>
                                        <c:forEach items="${categories}" var="itemSection">
                                            <li><c:out value="${itemSection.categoryName}"/> (${fn:length(itemSection.articles)})
                                                <ul>
                                                    <c:forEach items="${itemSection.articles}" var="art">
                                                        <li>
                                                            <a href="<c:url value="/help/base/articles/${art.id}/show.html"/>">
                                                                <c:out value="${art.title}"/>
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </li>
                                        </c:forEach>
                                    </ol>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="contentbottom"></div>
                </div>
            </td>
            <td class="leftcells colNarrowRight">
                <div class="pagecontentsubheader"><h3 id="headKBCatList">Kategorie</h3></div>
                <div class="contenttop"></div>
                <div class="contentmiddle">
                    <ul class="kbList">
                        <c:forEach items="${categories}" var="c">
                            <li><a href="<c:url value="/help/base/category/${c.id}/show.html"/>"
                                   class="catName"><c:out value="${c.categoryName}"/></a>
                                <span class="catCount">(${fn:length(c.articles)})</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="contentbottom"></div>
            </td>
        </tr>
    </table>
</div>
