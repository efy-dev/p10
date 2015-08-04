<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
                <th>商家用户数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">商家用户id</td>
                <td class="am-u-md-3">${object.id}</td>
                <td class="am-primary am-u-md-3">temp</td>
                <td class="am-u-md-3">${object.temp}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
