<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/28
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<body>
<script type="text/javascript">
    function getMatchJnodes(id){
        var jmenu = document.getElementById("jmenu").value;
        var currentJnode = document.getElementById("currentJnode").value;
        var matchJnode = document.getElementById("matchJnode").value;
        var url =' <c:url value="/view/viewDefault.do"/>' + "?id=" + id + "&jmenu=" + jmenu + "&currentJnode=" + currentJnode + "&matchJnode=" + matchJnode;
        window.location=url;
    }
</script>
<div class="slide-right">
    <div class="title-hide">${tabTitle}</div>
    <div class="div-list">
        <ul class="div-list-ul">
            <c:forEach items="${documentList}" var="document" varStatus="status">
                <li>
                    <a href='javascript:void(0)' onclick="getMatchJnodes('${document.id}')"><p><strong><em>${status.index + 1}、</em>${document.title}[<fmt:formatDate
                            value="${document.publishDate}" pattern="yyyy-MM-dd"/>]</strong></p>

                    <p>${document.sampleContent}...</p></a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!-- //End--div-list-->
    <div class="pages wh">
        <c:url value="/protection/protection.do" var="url"/>
        <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="${url}">
            <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
            <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
        </ming800:pcPageList>
    </div>
    <!-- //End--pages-->
</div>
<!-- //End--slide-right-->
</div>
</div>

</body>
