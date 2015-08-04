<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">商家名字拼音</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">商家中文名字</td>
                <td class="am-u-md-3">${object.fullName}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">图标</td>
                <td class="am-u-md-3" colspan="3">${object.logoUrl}</td>
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
