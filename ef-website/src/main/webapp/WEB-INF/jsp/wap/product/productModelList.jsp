<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>【${project.name}】-e飞蚁</title>
    <meta name="keywords" content="${project.name}" />
    <meta name="description" content="${project.description}" />
</head>
<body>
<artice>
    <div class="bd search-sort">
        <ul class="bd tnav">
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:saleAmount&pageEntity.index=1"/>" title="销 量">销 量</a></li>
            <li>
            <c:if test="${str==null||flag==2||flag==3||flag==4}">
                <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="销 量">价 格</a>
            </c:if>
            <c:if test="${flag==1&&str=='desc'}">
            <a href="<c:url value="/product/list/${project.id}?sort=asc:price&pageEntity.index=1"/>" title="销 量">价 格</a><i class="icon-a2"></i>
            </c:if>
            <c:if test="${flag==1&&str=='asc'}">
            <a href="<c:url value="/product/list/${project.id}?sort=desc:price&pageEntity.index=1"/>" title="销 量">价 格</a><i class="icon-a1"></i>
            </c:if>
            </li>
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:popularityAmount&pageEntity.index=1"/>" title="人 气">人 气</a></li>
            <li><a href="<c:url value="/product/list/${project.id}?sort=desc:product.createDateTime&pageEntity.index=1"/>" title="新 品">新 品</a></li>
        </ul>
         <c:if test="${productModelList.size()>0}">
            <ul class="ul-list">
                <c:forEach items="${productModelList}" var="productModel" varStatus="rec">
                        <li>
                            <a  href="<c:url value="/product/productModel/${productModel.id}"/>" style="color: #000">
                            <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model-wap-view" alt="">
                                <c:set var="name">
                                    <c:if test="${fn:length(productModel.product.productModelList)==1}">
                                        ${productModel.product.name}
                                    </c:if>
                                    <c:if test="${fn:length(productModel.product.productModelList)>1}">
                                        ${productModel.product.name}[${productModel.name}]
                                    </c:if>
                                </c:set>
                                <p class="wh name">${name}
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
