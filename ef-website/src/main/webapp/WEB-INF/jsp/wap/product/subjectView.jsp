<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>【 精选专题 】 -e飞蚁</title>
    <meta name="description" content="">
    <style>
        .list-class .ul-list-img p {
            padding: 0;
        }
    </style>
</head>
<body>
<artice class="custom">
    <div class="bd list-class">
        <ul class="bd ul-list-img">
            <li><p>${subject.subjectDescription.content}</p></li>
        </ul>
        <ul class="bd ul-list">
            <c:forEach items="${productModelList}" var="productModel">
                <li class="bd">
                    <a href="<c:url value="/product/productModel/${productModel.productModel.id}"/>">
                        <img width="100%"
                             src="http://pro.efeiyi.com/${productModel.productModel.productModel_url}@!product-model"
                             alt="">

                        <p class="name">${productModel.productModel.product.name}</p>

                        <p class="price red"><em>￥</em><span>${productModel.productModel.price}</span></p>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</artice>
<script>
    $().ready(function () {
        $("img").each(function () {
            $(this).css("width", "100%");
        })
    });
</script>
</body>
</html>