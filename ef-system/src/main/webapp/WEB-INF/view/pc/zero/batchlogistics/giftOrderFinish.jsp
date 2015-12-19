<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/14
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title>准备提交数据中</title>
</head>
<body>
<form id="form1" action="/batch/deppon.do" method="post">
    <input name="qm" type="hidden" value="listBatchGift_default">
    <input name="result" type="hidden" value="redirect:/basic/xm.do?qm=plistBatchGift_default">
    <c:forEach items="${objectList}" var="purchaseOrderProduct">
        <input name="${purchaseOrderProduct.purchaseOrder.id}" type="hidden">
    </c:forEach>
</form>
<script>
    $("#form1").submit();
</script>
</body>
</html>
