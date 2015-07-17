<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/6/29
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
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
                <td class="am-primary am-u-md-3">类型</td>
                <td class="am-u-md-3">${object.type}</td>
                <td class="am-primary am-u-md-3">简介</td>
                <td class="am-u-md-3">${object.content}</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
