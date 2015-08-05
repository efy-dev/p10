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
                <th>产品数据</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">产品名字</td>
                <td class="am-u-md-3">${object.name}</td>
                <td class="am-primary am-u-md-3">产品编号</td>
                <td class="am-u-md-3">${object.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">产品价格</td>
                <td class="am-u-md-3">${object.price}</td>
                <td class="am-primary am-u-md-3">产品类别</td>
                <td class="am-u-md-3">${object.category.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">产品描述</td>
                <td class="am-u-md-3">${object.productDescription.content}</td>
                <td class="am-primary am-u-md-3">产品图片</td>
                <td class="am-u-md-3"><img src="${object.picture_url}" alt="产品图片"></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
