<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="description" content="${product.name}">
    <meta name="keywords" content="${product.productDescription.content}">
</head>
<body>
<!--作品详情-->
<div class="wh">
    <div class="hd">
        <div id="page-nav">
            <p><a href="<c:url value="/"/>">首页</a><span id="zpxq-1"><a href="<c:url value="/work/list"/>">作品</a></span><span>${product.name}</span></p>
        </div>
    </div>
</div>

<div class="wh">
    <div class="hd">
        <div id="center--1">
            <div class="center-buttom-1"></div>
            <div class="center-right">
                <div class="content-border">
                    <dl class="right-content">
                        <c:if test="${product.masterWorkPictureList.size() > 0}">
                            <c:forEach items="${product.masterWorkPictureList}" var="productPicture">
                                <dt class="right-content-img"><img src="http://tenant.efeiyi.com/${productPicture.pictureUrl}@!tenant-pc-work-view"></dt>
                            </c:forEach>
                        </c:if>
                        <c:if test="${product.masterWorkPictureList.size() == 0}">
                            <dt class="right-content-img"><img src="http://tenant.efeiyi.com/${product.pictureUrl}@!tenant-pc-work-view"></dt>
                        </c:if>
                        <dd class="right-content-p">
                            ${product.productDescription.content}
                        </dd>
                    </dl>
                    <div class="right-border"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--其他内容-->
</body>
</html>