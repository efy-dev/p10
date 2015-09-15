<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/17
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div class="hd">
    <div class="focus wh">
        <!--轮播图-->
        <ul class="slider-main">
            <c:forEach items="${bannerList}" var="banner" varStatus="status">
                <c:if test="${status.index==0}">
                    <li style="display: block;">
                </c:if>
                <c:if test="${status.index!=0}">
                    <li>
                </c:if>
                <img src="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner" width="1280" height="481" alt=""/></li>
            </c:forEach>
            <%--<li><img src="shop2015/upload/focus2.jpg" width="1280" height="481" alt=""/></li>--%>
            <%--<li><img src="shop2015/upload/focus3.jpg" width="1280" height="481" alt=""/></li>--%>
            <%--<li><img src="shop2015/upload/focus4.jpg" width="1280" height="481" alt=""/></li>--%>
        </ul>
        <ul class="slider-nav">
            <li class="active"></li>
            <c:forEach items="${bannerList}" var="banner"  begin="1">
                <li></li>
            </c:forEach>
        </ul>
    </div>
    <!-- //End--topbar-->
    <div class="box-hd wh">
        <div class="title wh"><h3>品牌故事</h3></div>
        <div class="banner">
            <a href="" target="_blank"><img src="/scripts/images/banner.jpg" width="1280" height="400" alt=""/></a>
        </div>
    </div>
    <!-- //End--品牌故事-->

    <c:forEach items="${projectList}" var="project">
        <div class="box-hd wh">
            <div class="title wh"><h3> ${project.name}</h3></div>
            <div class="list-pro">
                <ul class="ul-item">
                    <c:forEach items="${recommendMap.get(project.id)}" var="product" varStatus="status" begin="0" end="3">
                        <c:if test="${status.index%2==1}">
                            <c:set var="style" value="even"/>
                        </c:if>
                        <c:if test="${status.index%2==0}">
                            <c:set var="style" value="odd"/>
                        </c:if>
                        <li class="${style}"><a href="<c:url value="/product/hot/${product.id}"/>" target="_blank"
                                                title="${product.product.name}"><strong>${product.product.name}</strong><span
                                class="price"><em>￥</em><font>${product.price}</font></span><img class="imgfilter"
                                                                                                 src="http://pro.efeiyi.com/${product.productModel_url}@!home-product"
                                                                                                 alt=""/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>

    <div class="box-hd">
        <div class="title wh"><h3>传承人</h3><a class="more" href="" target="_blank" title="了解更多传承人"><i class="icon"></i>了解更多传承人</a>
        </div>
        <div class="list-pep wh">
            <ul class="ul-item">
                <c:forEach items="${masterList}" var="master">
                    <li>
                        <a href="" target="_blank"><img class="imgfilter" src="http://tenant.efeiyi.com/${master.favicon}"
                                                        alt=""/></a>

                        <p><strong>${master.name}</strong></p>

                        <p>[${master.getMainProjectName().getProject().getName()}]</p>

                        <p><ming800:status name="level" dataType="Project.level" checkedValue="${master.getMainProjectName().getProject().getLevel()}" type="normal"/>传承人</p>
                        <%--<ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/>--%>

                        <p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>
                    </li>
                </c:forEach>
                <%--<li>--%>
                <%--<a href="" target="_blank"><img class="imgfilter" src="shop2015/upload/pep-2.jpg" alt=""/></a>--%>

                <%--<p><strong>姚惠芬</strong></p>--%>

                <%--<p>[苏绣]</p>--%>

                <%--<p>国家级传承人</p>--%>

                <%--<p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>--%>
                <%--</li>--%>
                <%--<li>--%>
                <%--<a href="" target="_blank"><img class="imgfilter" src="shop2015/upload/pep-3.jpg" alt=""/></a>--%>

                <%--<p><strong>吴国本</strong></p>--%>

                <%--<p>[徐州剪纸]</p>--%>

                <%--<p>国家级传承人</p>--%>

                <%--<p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>--%>
                <%--</li>--%>
                <%--<li>--%>
                <%--<a href="" target="_blank"><img class="imgfilter" src="shop2015/upload/pep-4.jpg" alt=""/></a>--%>

                <%--<p><strong>朱炳仁</strong></p>--%>

                <%--<p>[铜雕技艺]</p>--%>

                <%--<p>国家级传承人</p>--%>

                <%--<p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>--%>
                <%--</li>--%>
                <%--<li>--%>
                <%--<a href="" target="_blank"><img class="imgfilter" src="shop2015/upload/pep-5.jpg" alt=""/></a>--%>

                <%--<p><strong>殷秀云</strong></p>--%>

                <%--<p>[雕漆技艺]</p>--%>

                <%--<p>国家级传承人</p>--%>

                <%--<p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>--%>
                <%--</li>--%>
                <%--<li>--%>
                <%--<a href="" target="_blank"><img class="imgfilter" src="shop2015/upload/pep-6.jpg" alt=""/></a>--%>

                <%--<p><strong>陆光正</strong></p>--%>

                <%--<p>[东阳木雕]</p>--%>

                <%--<p>国家级传承人</p>--%>

                <%--<p><a class="more" href="" target="_blank" title="更多"><i class="icon"></i>更多</a></p>--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>
    <!-- //End--传承人-->
</div>
</body>
</html>
