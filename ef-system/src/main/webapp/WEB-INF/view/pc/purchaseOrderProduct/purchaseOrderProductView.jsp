<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
    <script src="/scripts/ckeditor/ckeditor.js"></script>
    <style>
    </style>
</head>
<body>
<%--<jsp:include page="/do/generateTabs.do?qm=${requestScope.qm}&conditions=${requestScope.conditions}"/>--%>

<div class="am-g">
    <div class="am-u-md-12">
        <h2>详细信息</h2>
        <table class="am-table am-table-bordered">
            <tbody>
            <tr>

                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.productModel.product.name}</td>
                <td class="am-primary am-u-md-3">编号</td>
                <td class="am-u-md-3">${object.productModel.product.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">价格</td>
                <td class="am-u-md-3">${object.productModel.product.price}</td>
                <td class="am-primary am-u-md-3">分类</td>
                <td class="am-u-md-3">${object.productModel.product.category.name}</td>
            </tr>

            <tr>
                <td class="am-primary am-u-md-3">图片</td>
                <td class="am-u-md-3"><img src="${object.productModel.product.picture_url}" alt="产品图片"></td>
                <td class="am-primary am-u-md-3">描述</td>
                <td class="am-u-md-3">${object.productModel.product.productDescription.content}</td>
            </tr>
            </tbody>
        </table>
    </div>


</div>
</body>
</html>
