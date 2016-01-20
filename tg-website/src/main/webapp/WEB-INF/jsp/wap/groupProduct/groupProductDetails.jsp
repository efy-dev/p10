<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/26
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${groupProduct.productModel.product.name}
    <c:if test="${(groupProduct.productModel.product.productModelList.size()>1)&&(null!=groupProduct.productModel.name)&&(''!=groupProduct.productModel.name)}">
      [${groupProduct.productModel.name}]
    </c:if>
  </title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/amazeui.min.css?v=20150831"/>">
  <link type="text/css" rel="stylesheet"  href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
</head>
<body>
<header class="am-header custom-header">
  <div class="am-header-left am-header-nav">
    <a href="javascript:history.go(-1)" class="chevron-left"></a>
  </div>
  <!-- //End--chevron-left-->
  <h1 class="am-header-title">我的团长我的团</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav">
    <a href="#chevron-right" class="chevron-right" id="menu">
      <i class="line"></i>
    </a>
  </div>
  <!-- //End--chevron-left-->
  <div class="menu-list">
    <ul class="bd">
      <li><a href="http://www.efeiyi.com" title="首页">e&nbsp;飞&nbsp;蚁&nbsp;商&nbsp;城</a></li>
      <li><a href="http://a.efeiyi.com/tuan" title="分类">团&nbsp;购&nbsp;首&nbsp;页</a></li>
    </ul>
  </div>
</header>
<!--//End--header-->
<div class="my-colonel ae">
  <!-- 轮播产品-->
  <div class="custom newcustom">
    <div data-am-widget="slider" class="am-slider am-slider-a1 am-addol" data-am-slider='{&quot;directionNav&quot;:false}' >

      <ul class="am-slides">
          <li>
            <div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${groupProduct.productModel.productModel_url}@!wap-product-pic"><div class="c-page"><span>${groupProduct.productModel.product.name}
              <c:if test="${(groupProduct.productModel.product.productModelList.size()>1)&&(null!=groupProduct.productModel.name)&&(''!=groupProduct.productModel.name)}">
                [${groupProduct.productModel.name}]
              </c:if>
              </span></div></div>
          </li>
          <c:forEach items="${groupProduct.productModel.product.productPictureList}" var="picture">
            <c:if test="${picture.status=='1'&&picture.productModel.id==groupProduct.productModel.id}">
                    <li >
                      <div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!wap-product-pic"><div class="c-page"><span>${groupProduct.productModel.product.name}[${groupProduct.productModel.name}]</span></div></div>
                    </li>
            </c:if>
    </c:forEach>
        </ul>
    </div>
    <!-- <div data-am-widget="slider" class="am-slider am-slider-a1 olli" data-am-slider='{&quot;directionNav&quot;:false}' >
         <ul class="am-slides ">
             <li><div class="colonel-pic ae"><img src="../shop2015/upload/mypurchase02.png"><div class="c-page"><span>《东方清韵》瓷胎竹编茶》瓷胎竹编茶》瓷胎竹编茶具套装典藏版装典藏版</span></div></div></li>
             <li><div class="colonel-pic ae"><img src="../shop2015/upload/mypurchase02.png"><div class="c-page"><span>《东方清韵》瓷胎竹编茶》瓷胎竹编茶》瓷胎竹编茶具套装典藏版装典藏版</span></div></div></li>
             <li><div class="colonel-pic ae"><img src="../shop2015/upload/mypurchase02.png"><div class="c-page"><span>《东方清韵》瓷胎竹编茶》瓷胎竹编茶》瓷胎竹编茶具套装典藏版装典藏版</span></div></div></li>
             <li><div class="colonel-pic ae"><img src="../shop2015/upload/mypurchase02.png"><div class="c-page"><span>《东方清韵》瓷胎竹编茶》瓷胎竹编茶》瓷胎竹编茶具套装典藏版装典藏版</span></div></div></li>
         </ul>
     </div>-->
  </div>
  <!-- 轮播产品-->
  <!--价格-->
  <div class="cost ae">
    <div class="txt1"><s>原价:${groupProduct.productModel.price}元</s></div>
    <div class="txt2"><em>拼团价:${groupProduct.groupPrice}元</em><i class="icon"></i></div>
  </div>
  <!--功能-->
  <div class="iwill ae">
    <div class="page ae"><div class="left"><p>${groupProduct.memberAmount}人起成团</p></div><div class="right"><p>成团时间${groupProduct.groupPurchaseTime}天</p></div></div>
    <div class="txt3 ae"><span>开团后，该团若在规定时间内成功组团，就可以享受团购价，若组团失败，则系统将退还钱款。</span></div>
    <c:if test="${groupProduct.status==1}">
      <a href="<c:url value="/group/groupBuy.do?groupProductId=${groupProduct.id}"/>" class="btn">我&nbsp;要&nbsp;开&nbsp;团</a>
    </c:if>
    <c:if test="${groupProduct.status==0}">
      <a href="#" class="btn">该&nbsp;商&nbsp;品&nbsp;已&nbsp;下&nbsp;架</a>
    </c:if>
  </div>
  <!--拼团玩法-->
  <div class="method addmethod ae">
    <div class="met-head ae">
      <span>拼团玩法</span>
      <span><a href="<c:url value="/product/playDetails"/>">查看详情<i class="met-icon"></i></a></span>
    </div>
    <div class="met-footer ae">
      <ul class="ae">
        <li>
          <p><strong>1</strong></p>
          <p>选择心仪商品</p>
        </li>
        <li class="active">
          <p><strong>2</strong></p>
          <p>支付开团或参团</p>
        </li>
        <li class="hover">
          <p><strong>3</strong></p>
          <p>招募团员</p>
        </li>
        <li class="hover">
          <p><strong>4</strong></p>
          <p>达到人数组团成功</p>
        </li>
      </ul>
    </div>
  </div>
  <!-- 选项卡-->
  <div class="colonel-table ae">
    <!--产品-->
    <div class="c-title ae">
      <ul>
        <li class="active">产品介绍</li>
        <li>评论</li>
      </ul>
    </div>
    <!--评论-->
    <div class="c-content ae">
      <div class="co-page">
        <div class="introduce ae">
          <c:if test="${not empty groupProduct.productModel.product.productDescription.content}">
            ${groupProduct.productModel.product.productDescription.content}
          </c:if>
          <c:if test="${not empty groupProduct.productModel.product.productPictureList&&fn:length(groupProduct.productModel.product.productPictureList)>0&&empty groupProduct.productModel.product.productDescription.content}">
            <c:forEach items="${groupProduct.productModel.product.productPictureList}" var="productPicture">
              <p>
                <img style="margin:0" src="http://pro.efeiyi.com/${productPicture.pictureUrl}@!pc-detail-view"/>
              </p>
            </c:forEach>

          </c:if>
          <div class="button ae"><a href="http://www.efeiyi.com/product/productModel/${groupProduct.productModel.id}" class="gbtn"><span>原价直接购买</span><i class="icon1"></i></a></div>
        </div>
        <a class="efeiyi-btn" href="<c:url value="/group/protocol"/>">e飞蚁拼团协议<i class="efiyi"></i></a>
      </div>
      <div class="co-page" style="display: none">
  <c:if test="${not empty purchaseOrderProductList&&fn:length(purchaseOrderProductList) >0}">
        <div class="col-pl ae">
          <ul class="ae">
            <c:forEach items="${purchaseOrderProductList}" var="purchaseOrderProduct" varStatus="rec">
              <c:if test="${not empty purchaseOrderProduct.purchaseOrderComment&&purchaseOrderProduct.purchaseOrderComment.status!='0'}">
                <li>
                  <c:set var="user">
                    ${purchaseOrderProduct.purchaseOrder.user.getUsername()}
                  </c:set>
                  <div class="co-pic"><img class="am-circle" src="<c:url value="/scripts/wap/upload/yonghm.jpg"/>"></div><h5>${fn:substring(user, 0,3 )}****${fn:substring(user,7,11)}</h5><P>${purchaseOrderProduct.purchaseOrderComment.content}</P><p><strong></strong></p></li>
                </li>
              </c:if>
            </c:forEach>

          </ul>
        </div>
  </c:if>
      </div>
    </div>
  </div>
</div>
<!--//End--footer-->
<!--悬浮订单-->
<div class="met-nav ae">
  <a href="<c:url value="/tuan.do"/>"><p><i class="met-1con m-icon"></i></p><p>团购首页</p></a>
  <a href="<c:url value="/person/myGroup.do"/>"><p><i class="met-2con m-icon"></i></p><p>我的团</p></a>
  <a href="<c:url value="/person/myPurchaseOrder.do"/>"><p><i class="met-3con m-icon"></i></p><p>我的订单</p></a>
  <a href="<c:url value="/person/personInfoView.do"/>"><p><i class="met-4con m-icon"></i></p><p>个人中心</p></a>
</div>
<!--在线客服-->
<div class="scroll-bar">
  <div class="scroll-bar-top" style="display: block;">
    <span class="btn"><i class="icon1"></i></span>
  </div>
  <!-- //End--返回顶部-->
</div>
<!--<div class="scroll-bar">
    <div class="scroll-bar-top">
        <span class="btn"><i class="icon1"></i></span>
    </div>
    &lt;!&ndash; //End&#45;&#45;返回顶部&ndash;&gt;-->
</div>
<!--//End--footer-->

<style type="text/css">
  .my-colonel{margin-bottom: 70px;}
  #MEIQIA-BTN-HOLDER {
    right: 0;bottom: 145px;}
  #MEIQIA-BTN {
    background: #000;
    width: 33px;
    height:53px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
  }
  #MEIQIA-BTN-LINE {
    display: none;}
  #MEIQIA-BTN-TEXT {
    width:48px;
    font-size: 12px;
    position: absolute;
    left:-28px;
    top:20px;,
  display: none;
  }
  .MEIQIA-ICON {
    background:url("http://www.efeiyi.com/scripts/wap/images/qq.png") -176px -143px;
    background-size: auto auto;
  }
  #MEIQIA-BTN-ICON {
    width: 23px;
    height: 28px;
    margin: 0;
    float: left;
    margin-left:5px;
    margin-top: 6px;
  }
</style>
<script type='text/javascript'>
  (function(m, ei, q, i, a, j, s) {
    m[a] = m[a] || function() {
              (m[a].a = m[a].a || []).push(arguments)
            };
    j = ei.createElement(q),
            s = ei.getElementsByTagName(q)[0];
    j.async = true;
    j.src = i;
    s.parentNode.insertBefore(j, s)
  })(window, document, 'script', '//eco-api.meiqia.com/dist/meiqia.js', '_MEIQIA');
  _MEIQIA('entId', 486);
</script>
<!--end在线客服-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/wap/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/wap/js/amazeui.min.js"/>"></script>
<!--自定义js--Start-->
<script src="<c:url value="/scripts/wap/js/system.js?v=20150831"/>"></script>
<script src="<c:url value="/scripts/wap/js/myorder.js?v=20150831"/>"></script>
<!--自定义js--End-->
<script>
  var _hmt = _hmt || [];
  (function() {
    var hm = document.createElement("script");
    hm.src = "//hm.baidu.com/hm.js?99fa5c9048e30c9dada20ea390329f89";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(hm, s);
  })();
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-70397028-1', 'auto');
  ga('send', 'pageview');

</script>
<!--自定义js--End-->
</body>
</html>
