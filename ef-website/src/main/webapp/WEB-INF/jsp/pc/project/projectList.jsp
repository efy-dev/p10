<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--topbar-->
<!-- //End--header-->
<!--//End--nav-new-->
<!--//End--focus-new-->
<div class="wh reco-shop">
    <div class="hd">
        <div class="wh shop-img">
            <div class="img">
                <ul>
                    <c:forEach items="${tenantList}" var="tenant">
                        <li><a href="<c:url value="/tenant/${tenant.id}"/>" title=""><img
                                src="http://pro.efeiyi.com/${tenant.pictureUrl}@!project-tenant-pc" alt=""></a></li>
                    </c:forEach>
                </ul>
            </div>
            <div class="icon-new btn-prev btn-no" title="上一个"></div>
            <div class="icon-new btn-next" title="下一个"></div>
        </div>
    </div>
</div>
<!-- //End--reco-shop-->

<div class="wh">
    <div class="hd classify">
        <c:forEach items="${projectList}" var="project">
            <div class="items">
                <div class="img-big">
                    <a href="<c:url value="/product/list/${project.id}"/>" target="_blank">
                        <strong class="tbar">${project.name}</strong>
                        <img class="imgfilter" src="http://pro.efeiyi.com/${project.picture_pc_url}@!project-list-pc"
                             alt="">
                    <span class="txt">
                        <c:choose>
                            <c:when test="${project.description.length()<=60}">
                                ${project.description}
                            </c:when>
                            <c:when test="${project.description.length()>60}">
                                ${project.description.substring(0,59)}...
                            </c:when>
                        </c:choose>
                    </span>
                    </a>
                </div>
                <c:forEach items="${productMap.get(project.id)}" var="product">
                    <div class="img-small">
                        <a href="<c:url value="/product/productModel/${product.productModelList.get(0).id}"/>">
                            <strong class="tbar">${product.name}</strong>
                                <%--${product.productModelList.size()}--%>
                            <img class="imgfilter"
                                 src="http://pro.efeiyi.com/${product.productModelList.get(0).productModel_url}@!project-list-product-pc"
                                 alt="">
                            <span class="money"><em>￥</em><font>${product.productModelList.get(0).price.intValue()}</font></span>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
    <!-- //ENd-->
</div>
<!--//ENd--classify-->

</body>
</html>
