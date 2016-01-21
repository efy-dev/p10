<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/12
  Time: 9:29
  To change this template use File | Settings | File Templates.
--%>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>e飞蚁送你5元代金券</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-product-pic"
       style="position: absolute;left: 0;top: -1000px;width: 100%">
</head>
<body>
<%--<header class="am-header custom-header newcustom-header">--%>
  <%--<div class="am-header-left am-header-nav">--%>
    <%--<a href="#chevron-left" class="chevron-left"></a>--%>
  <%--</div>--%>
  <%--<!-- //End--chevron-left-->--%>
  <%--<h1 class="am-header-title">e飞蚁送你5元代金券</h1>--%>
  <%--<!-- //End--title-->--%>
<%--</header>--%>
<!--//End--header-->
<div class="custom newcustom">
  <div data-am-widget="slider" class="am-slider am-slider-a1 olli" data-am-slider='{&quot;directionNav&quot;:false}' >
    <ul class="am-slides ">
      <li><div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${productModel.productModel_url}@!wap-rebate-picture"><div class="c-page"><span>${productModel.product.name}[${productModel.name}]</span></div></div></li>
      <c:forEach items="${productModel.product.productPictureList}" var="picture">
        <c:if test="${picture.status=='1'&&picture.productModel.id==productModel.id}">
          <li><div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-rebate-picture"><div class="c-page"><span>${productModel.product.name}[${productModel.name}]</span></div></div></li>
        </c:if>
      </c:forEach>
    </ul>
  </div>
</div>
<!--//End--custom-pic-->
<div class="t-use ae">
  <form>
    <div class="t-use-top ae">
      <div class="user-pic"><a href="#"><img src="<c:url value="/scripts/wap/upload/fx-x-1.png"/>"></a></div>
      <div class="user-text">
         <c:set var="shareUser1">
          ${sharerUser.getUsername()}
         </c:set>
        <p>${fn:substring(shareUser1, 0,3 )}****${fn:substring(shareUser1,7,11)}豪掷${purchaseOrder.purchaseOrderProductList.get(0).productModel.price}元将宝贝收入囊中，土豪啊有木有，抄起代金券，看看土豪是怎么炼成的！</p>
      </div>
    </div>
    <div class="t-use-center ae tab-convert">
      <ul>
        <li>
          <div class="right">
            <div class="money"><strong>${couponBatch.price}</strong><span>现金券</span><i>¥</i></div>
            <div class="page"><p>满${couponBatch.priceLimit}元使用</p><p>全场通用</p><p>${fn:substring(couponBatch.startDate,0 ,11 )}至${fn:substring(couponBatch.endDate,0 ,11 )}</p></div>
          </div>
        </li>
        <!-- 状态1-->
        <%--<li>--%>
          <%--<p class="state-1">请输入手机号，代金券将直接存入该账户。</p>--%>
        <%--</li>--%>
        <li>
          <a href="http://www.efeiyi.com/yhq.do?couponBatchId=iilsik60373zsqx4"></a>
          <%--<input type="text" placeholder="输入手机号" class="int-text" maxlength="11">--%>
          <%--<input onclick="getCoupon()" class="int-btn" value="保&nbsp;存" >--%>
        </li>
        <!-- 状态3-->
        <%--<li >--%>
          <%--<p class="state-3">当前手机号码<area style="display: none" id="numberId"><a href="#">[修改]</a></p>--%>
        <%--</li>--%>
      </ul>
    </div>
    <div class="t-use-botton ae">
      <a href="http://www.efeiyi.com/yhq.do?couponBatchId=iilsik60373zsqx4" class="botn">去&nbsp;领&nbsp;取</a>
    </div>
  </form>
</div>
<!--//End--t-use-->
<div class="extended ae">
  <div class="hader-list">看&nbsp;看&nbsp;朋&nbsp;友&nbsp;们&nbsp;的&nbsp;领&nbsp;券&nbsp;神&nbsp;功</div>
  <ul class="ae">
    <c:forEach items="${userList}" var="user">
    <li class="add-cord">
      <div class="t-use-top ae">
        <div class="user-pic"><a href="#"><img src="${user.headurl}"></a></div>
        <div class="user-text">
          <h4>
            <span>
            ${user.nickname}
            </span><span>${fn:substring(user.createDateTime,0 ,11 )}</span><span>${fn:substring(user.createDateTime,11 ,19 )}</span></h4>
          <p>要精品也要实惠，我来送你e飞蚁平台代金券啦！快去购物吧！</p>
          <strong>5元</strong>
        </div>
      </div>
    </li>
    </c:forEach>
    <div class="illustrate ae">
      <h5>活动说明：</h5>
      <p>1、代金券可在e飞蚁商城购买商品时抵现金使用。</p>
      <p>2、请您在自发放该代金券起5日内使用,逾期无效。本活动最终解释权归e飞蚁所有。</p>
    </div>
  </ul>
  <div class="hader-list">${fn:substring(shareUser1, 0,3 )}****${fn:substring(shareUser1,7,11)}&nbsp;入&nbsp;手&nbsp;的&nbsp;宝&nbsp;贝&nbsp;清&nbsp;单</div>
  <ul class="cost-name ae">
    <c:forEach items="${purchaseOrder.purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="rec">
    <li>
      <div class="sit-pic"><a href="<c:url value="/product/productModel/${purchaseOrderProduct.productModel.id}"/>"><img src="http://pro.efeiyi.com/${purchaseOrderProduct.productModel.productModel_url}"></a></div>
      <div class="sit-txt">
        <p>${purchaseOrderProduct.productModel.name}</p>
        <p>${purchaseOrderProduct.productModel.price}元</p>
        <a href="<c:url value="/product/productModel/${purchaseOrderProduct.productModel.id}"/>">查看商品</a>
      </div>
    </li>
   </c:forEach>
  </ul>

</div>
<div class="footer-fx"><a href="#" class="footer-btn" id="share">邀&nbsp;请&nbsp;好&nbsp;友&nbsp;来&nbsp;赚&nbsp;翻&nbsp;全&nbsp;场</a></div>
<div id="cover" style="display: none;"><em class="bg"></em><img src="/scripts/wap/upload/guide-share.png" class="share-picture"
                                                                alt=""></div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script type="text/javascript">
  function getCoupon(){
    var number = $(".int-text").val();
    alert(number);
      ajaxRequest("<c:url value="/sharePage/saveCoupon.do"/>", {"number": number}, function (data) {
        if (data == true) {
          $("#numberId").html(number);
          $("#numberId").show();
          $(".int-text").val("");
        } else {
          $("#numberId").show();
        }
      }, function () {
      }, "post");
  }
</script>
<script type='text/javascript'>
  $().ready(function () {
    $("#share").click(function () {
      if (isWeiXin()) {
        $("#cover").show();
        $(".custom-header").css("z-index", "0");
      }else {
        $("#cover").show();
        $(".custom-header").css("z-index", "0");
      }
    })
    $("#cover").click(function () {
      $(this).hide();
    })
  })

</script>
</body>
</html>
