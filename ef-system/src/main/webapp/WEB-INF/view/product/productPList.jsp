<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/25
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>

<html>
<head>
    <title></title>
    <script type="text/javascript" src="<c:url value='/scripts/jquery-1.11.1.min.js'/>"></script>
</head>
<body>


<jsp:include flush="true" page="/manage/getMenu.do?jmenuName=commonMenu&resultPage=/jmenu/manageTemplateHeader&match=${requestScope.qm}"></jsp:include>

<div class="am-cf admin-main">

    <jsp:include flush="true" page="/manage/getMenu.do?jmenuName=commonMenu&resultPage=/jmenu/manageTemplateLeft&match=${requestScope.qm}"></jsp:include>

    <div class="admin-content">

        <table>
            <tr>
                <td>产品id</td>
                <td>产品名称</td>
                <td>图片地址</td>
                <td>价格</td>
                <td>系列</td>
            </tr>

            <c:forEach items="${requestScope.pageInfo.list}" var="product">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.picture_url}</td>
                    <td>${product.price}</td>
                    <td>${product.serial}</td>
                </tr>
            </c:forEach>


        </table>
        <div style="clear: both">
            <ming800:pcPageList bean="${requestScope.pageInfo.pageEntity}" url="/basic/xm.do">
                <ming800:pcPageParam name="qm" value="${requestScope.qm}"/>
                <ming800:pcPageParam name="conditions" value="${requestScope.conditions}"/>
                <ming800:pcPageParam name="menuId" value="${requestScope.menuId}"/>
            </ming800:pcPageList>
        </div>

    </div>

</div>



</body>
</html>
