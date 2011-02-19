<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/WEB-INF/jsp/inc/taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="knowledgebase" class="management">
    <div id="pagecontentheader"><h2>Baza wiedzy</h2></div>
    <table  cellspacing="0">
        <tr>
            <td class="rightcells">
                <div id="pagecontentsubheader"><h3>a co tutaj?</h3></div>
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
                        <br /><br />
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
                                                            <a href="<c:url value="/help/base/showOne.html?id=${art.articleId}"/>">
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

                <div id="pagecontentsubheader"><h3>Kategorie</h3></div>

                <div class="contenttop"></div>
                <div class="contentmiddle">

                    <ul class="kbList">
                        <li><a href="#" class="catName">Phasellus quis</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Sed nec diam eu</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Morbi euismod</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Vestibulum</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Lorem ipsum</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Praesent id metus</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Quisque eget</a><span class="catCount">(1)</span></li>
                        <li><a href="#" class="catName">Vivamus id</a><span class="catCount">(1)</span></li>
                    </ul>

                </div>
                <div class="contentbottom"></div>

            </td>
        </tr>
    </table>
</div>
