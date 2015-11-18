<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="wh nav-new">
    <div class="hd">
        <div class="cate">
            <div class="ld"><h2>非遗商品分类<i class="icon-new"></i></h2></div>
            <div class="allsort">
                <c:forEach items="${categoryList}" var="category">
                    <div class="item">
                        <h3><a href="<c:url value="/project/product/${category.id}"/>" title="">${category.name}</a><i class="icon-new icon-link"></i></h3>
                        <div class="i-mc" style="display: none;">
                            <div class="links">
                                <c:forEach items="${projectMap.get(category.id)}" var="project">
                                    <a href="<c:url value="/product/list/${project.id}"/>" title="">${project.name}</a>
                                </c:forEach>
                            </div>
                            <!-- //End--links-->
                            <div class="reco">
                                <c:forEach items="${projectMap.get(category.id)}" var="project">
                                    <c:if test="${not empty recommendedTenantList}">
                                        <c:forEach items="${recommendedTenantList}" var="tenant">
                                            <c:if test="${project.id==tenantMap.get(tenant.id)}">
                                                <a href="<c:url value="/tenant/${tenant.id}"/>" title=""> <img class="imgfilter" src="http://pro.efeiyi.com/${tenant.logoUrl}" alt=""></a>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </div>
                                <%--</c:forEach>--%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="items">
            <a href="<c:url value="/"/>">首页</a>
            <a href="">品牌专区</a>
            <a href="">各地非遗</a>
            <a href="">大师</a>
            <a href="">工艺</a>
        </div>
    </div>
</div>
<!--//End--nav-new-->
<div class="wh focus-new">
    <div class="hd">
        <ul class="slider-main">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <c:if test="${status.index==0}">
                    <li style="display: block;">
                </c:if>
                <c:if test="${status.index!=0}">
                    <li>
                </c:if>
                <a href="<c:url value="${banner.directUrl}"/> " target="_blank"><img
                        src="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner" width="1280" height="481"
                        alt=""/></a></li>
            </c:forEach>
        </ul>
        <ul class="slider-nav">
            <li class="active"></li>
            <c:forEach items="${bannerList}" var="banner" begin="1">
                <li></li>
            </c:forEach>
        </ul>
        <div class="btn btn-prev" title="上一页"></div>
        <div class="btn btn-next" title="下一页"></div>
    </div>
</div>
