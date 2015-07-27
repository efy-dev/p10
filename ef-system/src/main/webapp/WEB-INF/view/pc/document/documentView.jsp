<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
                <th>文档详情</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">标题</td>
                <td class="am-u-md-3">${object.title}</td>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">关键字</td>
                <td class="am-u-md-3">${object.keywords}</td>
                <td class="am-primary am-u-md-3">内容</td>
                <td class="am-u-md-3">${object.documentContent.content}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
