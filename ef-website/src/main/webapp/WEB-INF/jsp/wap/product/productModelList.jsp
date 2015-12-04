<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
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
    <title>【${proName}】-e飞蚁</title>
    <meta name="keywords" content="${proName}" />
    <meta name="description" content="${project.description}" />
</head>
<body>
<artice class="custom">
    <div class="bd list-class">
        <ul class="ul-list-nav ul-list-nav2">
            <%--<li><a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="人气">人气</a></li>--%>
            <li>
                <c:if test="${str==null}">
                    <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="价  格">价格</a>
                </c:if>
                <c:if test="${str=='desc'}">
                    <a href="<c:url value="/product/list/${project.id}?sort=asc:price&pageEntity.index=1"/>" title="价  格">价格<i style="background:url(/scripts/wap/images/icon-new.png) no-repeat 0 0;background-size:100px auto;width:8px;height:20px;display:inline-block;margin-left:2px;position:relative;top:2px -webkit-transform: rotate(-180deg);
    transform: rotate(-180deg);"></i></a>
                </c:if>
                <c:if test="${str=='asc'}">
                    <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="价  格">价格<i style="background:url(/scripts/wap/images/icon-new.png) no-repeat 0 0;background-size:100px auto;width:8px;height:20px;display:inline-block;margin-left:6px;position:relative;top:11px"></i></a>
                </c:if>
            </li>
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:product.createDateTime&pageEntity.index=1"/>" title="新品">新品</a></li>
        </ul>
        <%--<div class="list-ad1"><a><img src="http://pro.efeiyi.com/${project.picture_wap_url}@!project-wap-view" alt=""/></a></div>--%>
         <c:if test="${productModelList.size()>0}">
            <ul class="ul-list">
                <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
                        <li>
                            <a  href="<c:url value="/product/productModel/${productModel.id}"/>" style="color: #000">
                            <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model-wap-view" alt="">
                            <p class="wh name">${map.get(productModel)}
                            </p>
                            <p class="price"><em>￥</em><span>${productModel.price}</span></p>
                            </a>
                        </li>
                </c:forEach>
            </ul>
        </c:if>

    </div>
    <div class="page bd">
        <ming800:pcPageList bean="${pageEntity}" url="/product/list/${project.id}">
            <ming800:pcPageParam name="sort"
                                 value='<%=request.getParameter("sort")!=null ? request.getParameter("sort") : ""%>'/>
        </ming800:pcPageList>
    </div>
</artice>

</body>
</html>
