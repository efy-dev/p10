<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/28
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<body>
<div class="slide-right">
    <div class="title">${tabTitle}<span>(共计${pageInfo.count}人)</span><a class="more" href="#" target="_parent">会员申请指南</a></div>
    <div class="list-table">
        <table>
            <c:forEach items="${documentList}" var="document" varStatus="status">
                <tr>
                    <td class="txt-left">
                        <p>${document.name}</p>
                    </td>
                    <td>${document.title}</td>
                    <td><fmt:formatDate
                            value="${document.publishDate}" pattern="yyyy.MM"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<!-- //End--slide-right-->
</div>
</div>

</body>
