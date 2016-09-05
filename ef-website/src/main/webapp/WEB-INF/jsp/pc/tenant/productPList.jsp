<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- //End--header-->
<html>
<head>
    <title>【${tenant.name}】-e飞蚁</title>
    <c:if test="${not empty tenantMasterList}">
        <c:set var="tenantName">
            ${tenantMasterList.get(0).master.fullName}
        </c:set>
    </c:if>
    <c:if test="${not empty productModelList}">
        <c:set var="projectName">
            ${productModelList.get(0).product.project.name}
        </c:set>
        <c:set var="projectContent">
            ${productModelList.get(0).product.project.name}
        </c:set>
    </c:if>
    <meta name="keywords" content="${projectName},${tenantName},${tenant.name}"/>
    <meta name="description" content="${tenant.name},${projectContent}"/>
</head>
<body>
<div class="hd shop">
    <div class="shop-header wh">
        <div class="hd">
            <div class="logo">
                <div class="img"><img src="<c:url value="http://pro.efeiyi.com/${tenant.logoUrl}@!tenant-logo"/>"
                                      alt=""/></div>
                <span class="des">
                <p><h1>${tenant.name}</h1></p>
                    <c:if test="${not empty tenantMasterList}">
                        <p><font>${tenantMasterList.get(0).master.originProvince.name}</font><font>${tenantMasterList.get(0).master.fullName}</font><font><ming800:status
                                name="level" dataType="Project.level"
                                checkedValue="${tenantMasterList.get(0).master.level}" type="normal"/></font></p>
                    </c:if>
                </span>
            </div>
            <!-- //End-->
            <div class="btndes">
                <%--<a href="" title="收藏店铺">收 藏 店 铺</a>--%>
                <c:if test="${empty tenantMasterList}">
                    <%--<a title="了解传承人" target="_blank">了 解 大 师</a>--%>
                </c:if>
                <c:if test="${not empty tenantMasterList}">
                    <a href="http://${tenantMasterList.get(0).master.name}.efeiyi.com" title="了解传承人"
                       target="_blank"> ${tenantMasterList.get(0).master.fullName} 个人主页</a>
                </c:if>
                <c:if test="${not empty artistry}">
                    <a href="http://minglu.efeiyi.com/project/${artistry.id}" title="了解传承人"
                       target="_blank">了解 ${artistry.name}</a>
                </c:if>
            </div>
        </div>
    </div>
    <!-- //End--shop-header-->
    <div class="focus wh">
        <ul class="slider-main">
            <li style="display: block;"><img src="<c:url value="http://pro.efeiyi.com/${tenant.pictureUrl}"/>"
                                             width="1280" height="481" alt=""/></li>
        </ul>
    </div>
    <!-- //End--focus-->
    <div class="shop-sort wh">
        <ul class="link1">
            <li class="active"><a href="" title="推荐商品">推荐商品</a></li>
        </ul>
        <dl class="link2">
            <dt class="">排&nbsp;&nbsp;序</dt>
            <dd style="display:none;">
                <a href="<c:url value="/tenant/${tenantId}?sort=desc:price"/>" title="价格从高到低">价格从高到低</a>
                <a href="<c:url value="/tenant/${tenantId}?sort=asc:price"/>" title="价格从低到高">价格从低到高</a>
                <a href="<c:url value="/tenant/${tenantId}?sort=desc:saleAmount"/>" title="销量">销量</a>
                <a href="<c:url value="/tenant/${tenantId}?sort=desc:product.createDateTime"/>" title="新品">新品</a>
                <a href="<c:url value="/tenant/${tenantId}?sort=desc:popularityAmount"/>" title="人气">人气</a>
            </dd>
        </dl>
    </div>
    <!-- //End--shop-sort-->
    <div class="category">
        <div class="list-pro">
            <ul class="ul-item">
                <c:forEach items="${productModelList}" var="productModel">
                    <li>
                        <a href="/product/productModel/${productModel.id}" target="_blank" title="">
                            <img class="imgfilter"
                                 src="<c:url value="http://pro.efeiyi.com/${productModel.productModel_url}@!product-hot"/>"
                                 alt="">
                            <c:set var="name">
                                <c:if test="${fn:length(productModel.product.productModelList)==1}">
                                    ${productModel.product.name}
                                </c:if>
                                <c:if test="${fn:length(productModel.product.productModelList)>1}">
                                    ${productModel.product.name}[${productModel.name}]
                                </c:if>
                            </c:set>
                            <p class="wh name"> ${name}
                            </p>
                            <c:if test="${productModel.price.intValue()!= 0 }">
                                <p class="wh price">￥${productModel.price}</p>
                            </c:if>
                        </a>
                    </li>
                </c:forEach>
            </ul>
            <div class="page wh">
                <ming800:pcPageList bean="${pageEntity}" url="${pageContext.request.contextPath}/tenant/${tenantId}">
                    <ming800:pcPageParam name="conditions"
                                         value='<%=request.getParameter("conditions")!=null ? request.getParameter("conditions") : ""%>'/>
                    <ming800:pcPageParam name="sort"
                                         value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
                </ming800:pcPageList>
            </div>
        </div>
    </div>
</div>
</body>
</html>
