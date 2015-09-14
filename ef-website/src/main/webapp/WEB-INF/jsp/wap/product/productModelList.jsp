<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/28
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表</title>
</head>
<body>
<artice class="custom">
    <div class="bd list-class">
        <ul class="ul-nav-slice3">
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="人气">人气</a></li>
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="价格">价格</a></li>
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="新品">新品</a></li>
        </ul>

        <c:if test="${productModelList.size()>0}">
            <ul class="ul-list">
                <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
                    <a  href="<c:url value="/product/productModel/${productModel.id}"/>" target="_blank">
                        <li>
                            <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model" alt="">

                            <p class="wh name">${productModel.product.name}
                                <c:forEach items="${productModel.productPropertyValueList}" var="productPropertyValue" varStatus="rec">
                                    ${productPropertyValue.projectPropertyValue.value}
                                </c:forEach>
                            </p>
                            <p class="price"><em>￥</em><span>${productModel.price.intValue()}</span></p>
                        </li>
                    </a>
                </c:forEach>
            </ul>
        </c:if>

        <%--<div class="list-pro">--%>
        <%--<ul class="ul-item">--%>
        <%--<li>--%>
        <%--<a href="<c:url value="/product/${productModel.id}"/>" target="_blank" title="">--%>
        <%--<img class="imgfilter"--%>
        <%--src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-hot" alt=""/>--%>

        <%--<p class="wh name">${productModel.name}</p>--%>

        <%--<p class="wh price">￥${productModel.price}</p>--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--</ul>--%>
        <%--<!-- //End-->--%>
        <%--</div>--%>

    </div>
</artice>
</body>
</html>
