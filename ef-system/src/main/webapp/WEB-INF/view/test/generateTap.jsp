<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/7/15
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>
    </style>
</head>
<body>
<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>

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
                <%--<td class="am-primary am-u-md-3">key</td>--%>
                <%--<td class="am-u-md-3">value</td>--%>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">value</td>
            </tr>
            <tr>
                <%--<td class="am-primary am-u-md-3">key</td>--%>
                <%--<td class="am-u-md-3">value</td>--%>
                <td class="am-primary am-u-md-3">key</td>
                <td class="am-u-md-3">卡拉集散地反抗了的加速卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡卡</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
