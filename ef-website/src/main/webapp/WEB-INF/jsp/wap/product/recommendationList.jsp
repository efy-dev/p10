<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/9/17
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <title>商品推荐专区</title>

</head>
<body>
<!--//End--header-->
<artice class="custom">
  <div class="bd pro-rec-area">
    <div class="list-ad1"><a href="<c:url value="/product/productModel/${productModel.id}"/>"><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model-wap-view" alt=""/></a></div>
    <!-- //End-->
    <div class="bd pep-info">
      <div class="bd txt">
        <p class="txt-price"><em>￥</em><span>${productModel.price}</span></p>
        <p class="txt-name"><strong>${productModel.product.name}</strong></p>
        <p class="txt-des">${productModel.product.subName}</p>
      </div>
      <c:if test="${not empty productModel.product.master.id}">
      <div class="img">
        <span>
           <a href="<c:url value="http://${productModel.product.master.name}.efeiyi.com"/>">
          <img src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tenant-mobile-tenant-list" alt=""/>
          </a>
        </span>
        <span><a href="<c:url value="http://${productModel.product.master.name}.efeiyi.com"/>" >查看大师<i class="arrow-right"></i></a></span>
      </div>
      </c:if>
    </div>
    <!-- //End--pep-info-->
    <div class="bd btns">
      <c:if test="${productModel.amount<=0}">
        <a class="not-btn-buy" href="#缺 货">缺 货</a>
      </c:if>
    </div>
    <div class="bd btns">
      <c:if test="${productModel.amount>0}">
      <a class="btn-buy"  href="<c:url value="/order/easyBuy/${productModel.id}"/>">立即购买</a>
      <a class="btn-cart" href="<c:url value="/cart/addProduct.do?id=${productModel.id}"/>">加入购物车</a>
      </c:if>
    </div>
  </div>

  <!-- //End-->
  <div class="bd list-class">
    <ul class="ul-list">
      <c:forEach items="${productModelList}" var="productModel" begin="0" end="7" varStatus="rec">

        <li>
          <a href="<c:url value='/product/productModel/${productModel.id}'/>" style="color: #000" title="">
         <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!product-model" alt="">

        <p class="name">${map.get(productModel)}</p>
        <p class="price"><em>￥</em><span>${productModel.price}</span></p>
          </a>
      </li>

      </c:forEach>
    </ul>
  </div>
</artice>

<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../shop2015/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../shop2015/js/amazeui.min.js"></script>
<!--自定义js--Start-->
<script src="../shop2015/js/system.js?v=20150831"></script>
<!--自定义js--End-->
</body>
</html>