<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="am-g" style="margin-top: 30px;">
    <div class="am-u-md-12">
        <table class="am-table am-table-bordered">
            <thead>
            <tr>
                <th>详细信息</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="am-primary am-u-md-3">名字</td>
                <td class="am-u-md-3">${object.productModel.product.name}</td>
                <td class="am-primary am-u-md-3">编号</td>
                <td class="am-u-md-3">${object.productModel.serial}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">价格</td>
                <td class="am-u-md-3">${object.productModel.price}</td>
                <td class="am-primary am-u-md-3">分类</td>
                <td class="am-u-md-3">${object.productModel.product.project.projectCategory.name}</td>
            </tr>

            <tr>
                <td class="am-primary am-u-md-3">图片</td>
                <td class="am-u-md-3" colspan="3">
                    <img width="20px" src="http://pro.efeiyi.com/${object.productModel.productModel_url}@!product-model" alt="产品图片">
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">规格</td>
                <td class="am-u-md-3" colspan="3">${object.productModel.name}</td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">属性</td>
                <td class="am-u-md-3" colspan="3">
                    <c:if test="${object.productModel.status == 1}">
                        <c:forEach var="ProductProperty" items="${object.productModel.productPropertyValueList}">
                            ${ProductProperty.projectPropertyValue.value}
                        </c:forEach>
                    </c:if>
                    <c:if test="${object.productModel.status == 2}">
                        ${object.productModel.customProperty}
                    </c:if>
                </td>
            </tr>
            <tr>
                <td class="am-primary am-u-md-3">描述</td>
                <td class="am-u-md-3" colspan="3">
                        ${object.productModel.product.productDescription.content}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
