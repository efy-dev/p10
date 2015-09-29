<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js">
<head>
</head>
<body>
<!-- //End--topbar-->
<div class="hd explosion">
  <div class="details wh">
    <div class="img"><a href="<c:url value="/product/productModel/${productModel.id}"/>" target="_blank"  title=""><img class="imgfilter" src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-hot-picture" /></a></div>
    <%--<div class="img"><a href="<c:url value=''/>" target="_blank" title=""><img class="imgfilter" src="" width="500" height="350"/></a></div>--%>
    <div class="info">
      <h1>${productModel.product.name}</h1>
       <%--<c:if test="${empty productModel.product.master} ">--%>
       <%--<div class="p-img">--%>
        <%--<a href="http://${productModel.product.master.name}.efeiyi.com" target="_blank" title=""><img class="imgfilter" src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!ef-home-master" target="_blank" alt="" /></a>--%>
        <%--<div class="des-txt">--%>

          <%--<p><a href="http://${productModel.product.master.name}.efeiyi.com" target="_blank" title="">${productModel.product.master.fullName}</a></p>--%>
          <%--<p>[${productModel.product.master.getMainProjectName().getProject().getName()}]</p>--%>
          <%--<p><ming800:status name="level" dataType="Project.level" checkedValue="${productModel.product.master.getMainProjectName().getProject().getLevel()}" type="normal"/>大师</p>--%>
           <%--</div>--%>
       <%--</div>--%>
      <%--</c:if>--%>

        <div class="p-img">

          <c:if test="${empty productModel.product.master}">
          </c:if>
          <c:if test="${not empty productModel.product.master.id}">
          <a href="http://${productModel.product.master.name}.efeiyi.com" target="_blank" title=""><img class="imgfilter" src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!ef-home-master" target="_blank" alt="" /></a>
          <div class="des-txt">

            <p><a href="http://${productModel.product.master.name}.efeiyi.com" target="_blank" title="">${productModel.product.master.fullName}</a></p>
            <p>[${productModel.product.master.getMainProjectName().getProject().getName()}]</p>
            <p><ming800:status name="level" dataType="Project.level" checkedValue="${productModel.product.master.getMainProjectName().getProject().getLevel()}" type="normal"/>大师</p>
            </div>
          </c:if>
        </div>

      <%--<div class="p-img"><a href="http://${productModel.product.master.name}.efeiyi.com" title=""><img class="imgfilter" src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tenant-pc-tenant-list" width="286" height="206" alt=""/></a></div>--%>
      <div class="item p-text">${productModel.product.subName}</div>
      <div class="item p-price"><em>￥</em>${productModel.price}</div>
      <div class="item p-btn">
        <a class="cart" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>" title="加入购物车"><i class="icon"></i>加入购物车</a>
        <a class="buy"  href="<c:url value="/order/easyBuy/${productModel.id}"/>"} title="立即购买">立即购买</a>
      </div>
    </div>
  </div>
  <!-- //End--details-->
  <div class="shop-sort wh">
    <ul class="link1">
      <li><a href="" title="推荐商品">推荐商品</a></li>
    </ul>
  </div>
  <!-- //End--shop-sort-->
  <c:if test="${productModelList.size()>0}">
  <div class="category">
    <div class="list-pro">
      <ul class="ul-item">
        <c:forEach items="${productModelList}" var="productModel" begin="0" end="15" varStatus="rec">
          <li>
            <a href="<c:url value='/product/productModel/${productModel.id}'/>" target="_blank" title="">
              <img class="imgfilter" src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-hot" alt="">
              <p class="wh name">
                ${productModel.product.name}
                <%--<c:if test="${fn:length(map.get(productModel))>'10'}">--%>
                  <%--${fn:substring(map.get(productModel),"0","10")}...--%>
                <%--</c:if>--%>
                <%--<c:if test="${fn:length(map.get(productModel))<='10'}">--%>
                 <%--${map.get(productModel)}--%>
                <%--</c:if>--%>
              </p>
              <p class="wh price">￥${productModel.price}</p>
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
    </c:if>
    <!-- //End--list-pro-->
    <%--    <div class="page wh">
          <ul class="am-pagination am-pagination-centered">
            <li class="bigRound"><a href="">«</a></li>
            <li><a href="">1</a></li>
            <li class="am-active"><a href="#">2</a></li>
            <li class="am-disabled bigRound"><a href="#">»</a></li>
          </ul>
        </div>--%>
    <!-- //End--page-->
  </div>
  <!-- //End---->

</div>
<!-- //End--footer-->

<!--[if (gte IE 9)|!(IE)]><!-->
<script href="<c:url value='/scripts/js/jquery.min.js'/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script href="<c:url value='http://libs.baidu.com/jquery/1.11.3/jquery.min.js'/>"></script>
<script href="<c:url value='http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js'/>"></script>
<script href="<c:url value='/scripts/js/amazeui.ie8polyfill.min.js'/>"></script>
<![endif]-->
<script href="<c:url value='/scripts/js/amazeui.min.js'/>"></script>
<script href="<c:url value='/scripts/js/system.js'/>"></script>
</body>
</html>
