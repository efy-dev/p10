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
</body>
</html>
