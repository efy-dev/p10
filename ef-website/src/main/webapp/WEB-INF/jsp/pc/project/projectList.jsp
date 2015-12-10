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
<%--<div class="wh reco-shop">--%>
<%--<div class="hd">--%>
<%--<div class="wh shop-img">--%>
<%--<div class="img">--%>
<%--<ul>--%>
<%--<c:forEach items="${tenantList}" var="tenant">--%>
<%--<li><a href="<c:url value="/tenant/${tenant.id}"/>" title=""><img--%>
<%--src="http://pro.efeiyi.com/${tenant.pictureUrl}@!project-tenant-pc" alt=""></a></li>--%>
<%--</c:forEach>--%>
<%--</ul>--%>
<%--</div>--%>
<%--<div class="icon-new btn-prev btn-no" title="上一个"></div>--%>
<%--<div class="icon-new btn-next" title="下一个"></div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<!-- //End--reco-shop-->

<div class="wh addtop">
    <div class="hd classify">
        <c:forEach items="${projectList}" var="project">
            <div class="items">
                <div class="img-big">
                    <a href="<c:url value="/product/list/${project.id}"/>" target="_blank">
                        <div class="tbar2-n1">
                            <div class="tbar2-n2"><strong class="tbar2">${project.name}</strong></div>
                        </div>
                            <%--<strong class="tbar"></strong>--%>
                        <img class="imgfilter" src="http://pro.efeiyi.com/${project.picture_pc_url}@!project-list-pc"
                             alt="">

                        <div class="tbar-txt">
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
                        </div>
                    </a>
                </div>
                <c:if test="${not empty productMap.get(project.id)}">
                    <c:forEach items="${productMap.get(project.id)}" var="product">
                        <c:if test="${not empty product.productModelList}">
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
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <!-- //ENd-->
</div>
<!--//ENd--classify-->
<script type="text/javascript">
    $().ready(function () {
        ;
        $(".allsort").show()
        $(".cate").removeAttr("id");
        if (${projectCategory.id==project.id}) {

        }
    })
</script>
</body>
</html>
