<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<body>
<body>
<div class="slide-right">
    <div class="title">${tabTitle}</div>
    <div class="div-list">
        <ul class="div-list-ul">
            <c:forEach items="${documentList}" var="document" varStatus="status">
                <li>
                    <a href="" target="_blank" title="">${status.index + 1}、${document.title}<em>[<fmt:formatDate
                            value="${document.publishDate}" pattern="yyyy-MM-dd"/>]</em></a>
                </li>
            </c:forEach>
            <li><a href="" target="_blank" title="">1、水城千米农民画成画仪式筹备工作有序进行水城千米农民画成画仪式筹备工作有序进行水城千米农民画成画仪式筹备工作有序进行水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">2、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">3、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">4、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">5、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">6、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">7、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">8、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">9、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">10、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">11、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">12、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">13、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">14、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">15、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">16、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">17、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">18、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">19、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>
            <li><a href="" target="_blank" title="">20、水城千米农民画成画仪式筹备工作有序进行<em class="time">[2015-6-29]</em></a></li>

        </ul>
    </div>
    <%--<div class="pages wh">--%>
    <%--<ul class="am-pagination am-pagination-centered">--%>
    <%--<li><a href="">首页</a></li>--%>
    <%--<li><a href="">上一页</a></li>--%>
    <%--<li class="am-active"><a href="">1</a></li>--%>
    <%--<li><a href="">2</a></li>--%>
    <%--<li><a href="">3</a></li>--%>
    <%--<li><a href="">4</a></li>--%>
    <%--<li><a href="">5</a></li>--%>
    <%--<li><a href="">...</a></li>--%>
    <%--<li><a href="#">9</a></li>--%>
    <%--<li><a href="#">10</a></li>--%>
    <%--<li class="am-disabled bigRound"><a href="#">下一页</a></li>--%>
    <%--<li class="pages-total">共135条</li>--%>
    <%--<li class="pages-nums">第01/35页</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <c:set var="newCount" value="0" scope="page"/>
    <div class="pages wh">
        <ul class="am-pagination am-pagination-centered">
            <div style="clear: both">
                <c:url value="/news.do" var="url"/>
                <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
                    <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                    <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                </ming800:pcPageList>
            </div>
        </ul>
    </div>
    <!-- //End--div-list-->
</div>
</body>
