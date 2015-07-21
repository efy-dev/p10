<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>测试数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">头衔</td>
                <td class="am-u-md-3">${object.title}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">等级</td>
                <td class="am-u-md-3">${object.level}</td>
                <td class="am-primary am-u-md-3">简介</td>
                <td class="am-u-md-3">${object.brief}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
