<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${group.groupProduct.productModel.product.name}[${group.groupProduct.productModel.name}]</title>
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
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/app.css?v=20150831"/>">
  <link type="text/css" rel="stylesheet" href="<c:url value="/scripts/wap/css/myorder.css?v=20150831"/>">
  <style>.colonel-table .introduce img{width:100%!important;float:left;margin-bottom:1.7rem;height: 100%!important;}</style>
</head>
<body>
<header class="am-header custom-header">
  <!-- //End--chevron-left-->
  <h1 class="am-header-title" style="margin: 0 10%;">我的团长我的团</h1>
  <!-- //End--title-->
  <div class="am-header-right am-header-nav am-header-right1">
    <a href="<c:url value="/person/personInfoView.do"/>" class="chevron-right" id="menu">
      <i class="icon icon-user"></i>
    </a>
  </div>
</header>
<!--//End--header-->
<div class="my-colonel ae">
  <!--产品-->
  <!-- 轮播产品-->
  <div class="custom">
    <div data-am-widget="slider" class="am-slider am-slider-a1 olli" data-am-slider='{&quot;directionNav&quot;:false}' >
      <ul class="am-slides ">
        <li><div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${group.groupProduct.productModel.productModel_url}@!tg-efeiyi-view-list"><div class="c-page"><span>${group.groupProduct.productModel.product.name}[${group.groupProduct.productModel.name}]</span></div></div></li>
        <c:forEach items="${group.groupProduct.productModel.product.productPictureList}" var="picture">
          <c:if test="${picture.status=='1'&&picture.productModel.id==group.groupProduct.productModel.id}">
            <li><div class="colonel-pic ae"><img src="http://pro.efeiyi.com/${picture.pictureUrl}@!tg-efeiyi-view-list"><div class="c-page"><span>${group.groupProduct.productModel.product.name}[${group.groupProduct.productModel.name}]</span></div></div></li>
          </c:if>
        </c:forEach>
      </ul>
    </div>
  </div>
  <!--价格-->
  <div class="cost ae">
    <div class="txt1"><s>飞蚁价:${group.groupProduct.productModel.price}元</s></div>
    <div class="txt2"><em>拼团价:${group.groupProduct.groupPrice}元</em><i class="icon"></i></div>
  </div>
  <!--功能-->
  <div class="iwill ae">
    <div class="join ae">
      <div class="txt-page ae"><span>团长:${manUserName}</span><span>${group.memberList.size()}人参团/${group.groupProduct.memberAmount}人起成团</span></div>
      <div class="Powerweb ae">
        <div class="black" style="width: ${bil}%;"></div>
        <div class="gray"></div>
      </div>
      <div class="txt-page ae"><span>拼团倒计时：</span><span>分享红包：${group.groupProduct.bonus}</span></div>
      <div class="time ae" id="timer">00:00:00</div>
    </div>
    <c:if test="${group.status==1}">
      <c:if test="${flag==1}">
        <c:if test="${group.groupProduct.memberAmount-group.memberList.size()>0}">
          <a href="javascript:void(0)" class="btn" id="btn">还&nbsp;差&nbsp;${group.groupProduct.memberAmount-group.memberList.size()}&nbsp;人&nbsp;成&nbsp;团&nbsp;,&nbsp;去&nbsp;分&nbsp;享</a>
          <div id="cover" style="display: none;"><em class="bg"></em><img src="<c:url value="/scripts/wap/upload/guide-share.png"/>"> alt=""></div>
        </c:if>
        <c:if test="${group.groupProduct.memberAmount-group.memberList.size()<=0}">
          <a href="javascript:void(0)" class="btn">还&nbsp;差&nbsp;0&nbsp;人&nbsp;成&nbsp;团</a>
        </c:if>
      </c:if>
      <c:if test="${flag==0}">
        <a href="<c:url value='/group/groupBuy.do'/>${url}" class="btn">参&nbsp;团</a>
      </c:if>
    </c:if>
    <c:if test="${group.status==3}">
      <a href="javascript:void(0)" class="btn">已&nbsp;成&nbsp;团</a>
    </c:if>
    <c:if test="${group.status==5}">
      <a href="javascript:void(0)" class="btn">组&nbsp;团&nbsp;失&nbsp;败</a>
    </c:if>
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
          ${group.groupProduct.productModel.product.productDescription.content}
          <div class="button ae"><a href="http://www.efeiyi.com/product/productModel/${group.groupProduct.productModel.id}" class="gbtn"><span>原价直接购买</span><i class="icon1"></i></a></div>
        </div>
        <div class="tab-btn">
          <a href="<c:url value="/product/groupProduct1.do"/>">更多团购商品<i class="gicon"></i></a>
          <a href="<c:url value="/product/groupProduct/${group.groupProduct.id}"/>">我要开团<i class="gicon"></i></a>
        </div>
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
        <%--<div class="more ae"><a href="javascript:void(0)"><span>下拉加载更多...</span><div class="icon"></div></a></div>--%>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  var endDate=${endTime};
  setInterval("daoJiShi()",1000);
  function daoJiShi()
  {
    var now=new Date().getTime();
    var oft=Math.round((endDate-now)/1000);
    var ofh=parseInt(oft/3600);
    var ofm=parseInt((oft%3600)/60);
    var ofs=oft%60;
    if(ofh<10){
    ofh="0"+ofh;
  }
      if(ofm<10){
      ofm="0"+ofm;
    }
    if(ofs<10&&ofs>=0){
      ofs="0"+ofs;
    }
    document.getElementById('timer').innerHTML=ofh+ ':' +ofm+ ':' +ofs;
    if(ofs<0){document.getElementById('timer').innerHTML='00:00:00';return;};
  };
</script>
<!--//End--footer-->

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
</body>
</html>