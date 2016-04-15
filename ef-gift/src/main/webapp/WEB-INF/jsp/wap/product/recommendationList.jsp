<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  <title>【 ${productModel.product.name} 】${productModel.product.subName} -e飞蚁</title>
  <c:if test="${product.master!=null}">
    <c:set var="master">
      ${productModel.product.master.fullName}
    </c:set>
  </c:if>
  <meta name="keywords" content="${productModel.product.project.name},${master.name},${productModel.product.name},${productModel.product.subName}, ${productModel.name}" />
  <meta name="description" content="${productModel.name},${productModel.product.name},${productModel.product.subName},${productModel.product.project.description}" />
</head>
<body>
<!--//End--header-->
<artice class="custom">
  <div class="bd pro-rec-area">
    <div class="list-ad1"><a href="<c:url value="/product/productModel/${productModel.id}"/>"><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!recommendation-mobile-picture" alt=""/></a></div>
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
           <a href="http://${productModel.product.master.name}.efeiyi.com">
          <img src="http://tenant.efeiyi.com/${productModel.product.master.favicon}@!tenant-mobile-tenant-list" alt=""/>
          </a>
        </span>
        <span><a href="http://${productModel.product.master.name}.efeiyi.com" >查看大师<i class="arrow-right"></i></a></span>
      </div>
      </c:if>
    </div>
    <!-- //End--pep-info-->
    <div class="bd btns">
      <c:if test="${productModel.amount<=0}">
        <a class="not-btn-buy" href="#售 罄">售 罄</a>
      </c:if>
    </div>
    <div class="bd btns">
      <c:if test="${productModel.amount>0}">
      <a class="btn-buy"  href="<c:url value="/order/easyBuy/${productModel.id}?amount=1"/>">立即购买</a>
      <a class="btn-cart"  href="<c:url value="/cart/addProduct.do?id=${productModel.id}&redirect=/product/productModel/${productModel.id}&amount=1"/>">加入购物车</a>
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
            <c:set var="name">
              <c:if test="${fn:length(productModel.product.productModelList)==1}">
                ${productModel.product.name}
              </c:if>
              <c:if test="${fn:length(productModel.product.productModelList)>1}">
                ${productModel.product.name}[${productModel.name}]
              </c:if>
            </c:set>
        <p class="name">${name}</p>
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

<script type="text/javascript">
  var _mvq = window._mvq || [];
  window._mvq = _mvq;
  _mvq.push(['$setAccount', 'm-197303-0']);
  _mvq.push(['$setGeneral', 'goodsdetail', '', /*用户名*/ '', /*用户id*/ '']);
  _mvq.push(['$logConversion']);

  _mvq.push(['$addGoods', /*分类id*/ '', /*品牌id*/ '',/*商品名称*/ '${productModel.name}',/*商品ID*/ '${productModel.id}',/*商品售价*/ '${productModel.price}',
    /*商品图片url*/ 'http://pro.efeiyi.com/${productModel.productModel_url}', /*分类名*/ '${productModel.product.project.name}', /*品牌名*/ '', /*商品库存状态1或是0*/ '${productModel.product.status}', /*网络价*/ '',/*收藏人数*/ '', /*商品下架时间*/ '']);
  _mvq.push(['$logData']);
</script>
</body>
</html>