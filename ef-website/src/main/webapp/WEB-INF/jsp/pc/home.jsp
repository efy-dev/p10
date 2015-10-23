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
                <a href="<c:url value="${banner.directUrl}"/> " target="_blank"><img
                        src="http://pro.efeiyi.com/${banner.imageUrl}@!home-banner" width="1280" height="481"
                        alt=""/></a></li>
            </c:forEach>
            <%--<li><img src="shop2015/upload/focus2.jpg" width="1280" height="481" alt=""/></li>--%>
            <%--<li><img src="shop2015/upload/focus3.jpg" width="1280" height="481" alt=""/></li>--%>
            <%--<li><img src="shop2015/upload/focus4.jpg" width="1280" height="481" alt=""/></li>--%>
        </ul>
        <ul class="slider-nav">
            <li class="active"></li>
            <c:forEach items="${bannerList}" var="banner" begin="1">
                <li></li>
            </c:forEach>
        </ul>
    </div>
    <!-- //End--topbar-->
    <div class="box-hd wh">
        <div class="title wh"><h3>非遗优选</h3></div>
        <div class="banner">
            <ul class="brand-ul">
                <li class="stau1"><a href="${advertisement[0].redirect}" target="_blank" title=""><strong>${advertisement[0].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[0].img}@!advertisement-small" alt=""></a></li>
                <li class="stau2"><a href="${advertisement[1].redirect}" target="_blank" title=""><strong>${advertisement[1].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[1].img}@!advertisement-big" alt=""></a></li>
                <li class="stau1"><a href="${advertisement[2].redirect}" target="_blank" title=""><strong>${advertisement[2].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[2].img}@!advertisement-small" alt=""></a></li>
                <li class="stau1"><a href="${advertisement[3].redirect}" target="_blank" title=""><strong>${advertisement[3].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[3].img}@!advertisement-small" alt=""></a></li>
                <li class="stau1"><a href="${advertisement[4].redirect}" target="_blank" title=""><strong>${advertisement[4].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[4].img}@!advertisement-small" alt=""></a></li>
                <li class="stau1"><a href="${advertisement[5].redirect}" target="_blank" title=""><strong>${advertisement[5].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[5].img}@!advertisement-small" alt=""></a></li>
                <li class="stau1"><a href="${advertisement[6].redirect}" target="_blank" title=""><strong>${advertisement[6].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[6].img}@!advertisement-small" alt=""></a></li>
                <li class="stau2"><a href="${advertisement[7].redirect}" target="_blank" title=""><strong>${advertisement[7].name}</strong><img class="imgfilter" src="http://pro.efeiyi.com/${advertisement[7].img}@!advertisement-big" alt=""></a></li>
            </ul>
        </div>
    </div>
    <!-- //End--品牌故事-->

    <c:forEach items="${projectList}" var="project">
        <div class="box-hd wh">
            <div class="title wh"><h3> ${project.name}</h3></div>
            <div class="list-pro">
                <ul class="ul-item">
                    <c:forEach items="${recommendMap.get(project.id)}" var="product" varStatus="status" begin="0"
                               end="3">
                        <c:if test="${status.index%2==1}">
                            <c:set var="style" value="even"/>
                        </c:if>
                        <c:if test="${status.index%2==0}">
                            <c:set var="style" value="odd"/>
                        </c:if>
                        <li class="${style}"><a href="<c:url value="/product/hot/${product.productModel.id}"/>"
                                                target="_blank"
                                                title="${product.productModel.name}"><strong>${product.productModel.name}</strong><img
                                class="imgfilter"
                                src="http://pro.efeiyi.com/${product.productModel.product.getProductPicture().pictureUrl}@!home-product"
                                alt=""/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:forEach>

    <div class="box-hd">
        <div class="title wh"><h3>大师</h3><a class="more" href="http://master.efeiyi.com" target="_blank" title="了解更多大师"><i
                class="icon"></i>了解更多大师</a>
        </div>
        <div class="list-pep wh">
            <ul class="ul-item">
                <c:forEach items="${masterList}" var="master">
                    <li>
                        <a href="http://${master.name}.efeiyi.com" target="_blank"><img class="imgfilter"
                                                                                        src="http://tenant.efeiyi.com/${master.favicon}@!ef-home-master"
                                                                                        alt=""/></a>

                        <p><a href="http://${master.name}.efeiyi.com"
                              target="_blank"><strong>${master.fullName}</strong></a></p>

                        <p>[${master.getMainProjectName().getProject().getName()}]</p>

                        <p><ming800:status name="level" dataType="Project.level"
                                           checkedValue="${master.getMainProjectName().getProject().getLevel()}"
                                           type="normal"/>大师</p>
                            <%--<ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/>--%>
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
