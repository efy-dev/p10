<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>发货记录</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">发货时间</td>
                <td class="am-u-md-3"><fmt:formatDate value="${object.createDateTime}" type="both" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>商家产品信息</h2>
        <jsp:include flush="true"
                     page="/basic/xm.do?qm=listProduct_tenant&conditions=tenant.id:${object.id}"/>
    </div>
</div>
</body>
</html>
