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
<body>
<div class="slide-right">
    <div class="title">${tabTitle}</div>
    <div class="div-list">
        <ul class="div-list-ul">
            <c:forEach items="${documentList}" var="document" varStatus="status">
                <li>
                    <p><strong><em>${status.index + 1}、</em>${document.title}[<fmt:formatDate
                            value="${document.publishDate}" pattern="yyyy-MM-dd"/>]</strong></p>

                    <p>${document.sampleContent}...</p>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="pages wh">
        <ul class="am-pagination am-pagination-centered">
            <li><a href="">首页</a></li>
            <li><a href="">上一页</a></li>
            <li class="am-active"><a href="">1</a></li>
            <li><a href="">2</a></li>
            <li><a href="">3</a></li>
            <li><a href="">4</a></li>
            <li><a href="">5</a></li>
            <li><a href="">...</a></li>
            <li><a href="#">9</a></li>
            <li><a href="#">10</a></li>
            <li class="am-disabled bigRound"><a href="#">下一页</a></li>
            <li class="pages-total">共135条</li>
            <li class="pages-nums">第01/35页</li>
        </ul>
    </div>
</div>

<!-- //End--div-list-->

</body>
