<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>分享页面</title>
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
</head>
<body>
<header class="am-header custom-header newhad">
  <!-- //End--chevron-left-->

  <h1 class="am-header-title"><i class="had-icon"></i>
    <h1 class="am-header-title"><i class="had-icon"></i>
      <c:if test="${flag==0}">
        <c:if test="${group.status==1}">
          组团中，还差${group.groupProduct.memberAmount-group.groupMemberList.size()}人成团
        </c:if>
        <c:if test="${group.status==3}">
          组团成功
        </c:if>
        <c:if test="${group.status==5}">
          组团失败
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          活动结束
        </c:if>
      </c:if>
      <c:if test="${flag==1||flag==2}">
        <c:if test="${group.status==1&&group.groupMemberList.size==1}">
          开团成功
        </c:if>
        <c:if test="${group.status==1&&group.groupMemberList.size>1}">
          组团中，还差${group.groupProduct.memberAmount-group.groupMemberList.size}人成团
        </c:if>

        <c:if test="${group.status==3}">
          组团成功
        </c:if>
        <c:if test="${group.status==5}">
          组团失败
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          活动结束
        </c:if>
      </c:if>
    </h1>
  </h1>
  <!-- //End--title-->
</header>
<!--//End--header-->
<div class="newshare ae">
  <!--头部产品-->
  <div class="had-product ae">
    <div class="had-pic"><a href="<c:url value='/group/joinGroup.do'/>?groupProductId=${group.groupProduct.id}&groupId=${group.id}&memberId=${memberId}"><img src="http://pro.efeiyi.com/${group.groupProduct.productModel.productModel_url}@!group-share-product-view"></a></div>
    <div class="had-txt"><p>${group.groupProduct.productModel.product.name}[${group.groupProduct.productModel.name}]</p><p>${group.groupProduct.memberAmount}人起成团/${group.groupProduct.groupPurchaseTime}天成团</p><p><strong>拼团价${group.groupProduct.groupPrice}</strong>（<s>原价${group.groupProduct.productModel.price}</s>）</p></div>
  </div>
  <!--成团人数-->
  <div class="new-team ae">
    <div class="old"><a href="#" class="iste"><img class="addnewbd" src="<c:url value="/scripts/wap/upload/fx-x-1.png"/>"><strong>长</strong></a></div>
      <div class="crew">
        <c:forEach items="${group.getGroupMemberList()}" var="groupMember">
        <c:if test="${groupMember.level!=0}">
       <a href="#" class="iste"><img class="addnewbd" src="<c:url value="/scripts/wap/upload/fx-x-1.png"/>"></a>
      </c:if>
        </c:forEach>
      </div>

    <div class="newtext">
      <c:if test="${flag==0}">
        <c:if test="${group.status==1}">
        还差${group.groupProduct.memberAmount-group.groupMemberList.size()}人成团，时间有限，小伙伴们都抢疯了，你还在等什么捏~~
        </c:if>
        <c:if test="${group.status==3}">
          组团成功啦！不过还有参团名额呢，赶快参与吧/组团成功啦，可是没有你的参与，伦家不开心呢，快去开个团吧
        </c:if>
        <c:if test="${group.status==5}">
          组团失败，不要气馁，自己开个团试试看~~
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          哎呀，你来的太晚了，商品已被抢完啦
        </c:if>
      </c:if>
      <c:if test="${flag==1}">
        <c:if test="${group.status==1&&group.groupMemberList.size==1}">
          恭喜您成功开团当团长，赶快呼唤小伙伴们加入你的团吧
        </c:if>
        <c:if test="${group.status==1&&group.groupMemberList.size>1}">
          还差${group.groupProduct.memberAmount-group.groupMemberList.size}人成团，时间有限，赶快去呼唤小伙伴们加入吧
        </c:if>
        <c:if test="${group.status==3}">
          组团成功啦，恭喜恭喜！不过还有参团名额呢，快去告诉朋友们吧
        </c:if>
        <c:if test="${group.status==5}">
          组团失败，不要气馁，一回生，二回熟，再接再厉呦~~
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          哎呀，商品太热销，已经抢完啦
        </c:if>
      </c:if>
      <c:if test="${flag==2}">
        <c:if test="${group.status==1}">
          还差${group.groupProduct.memberAmount-group.groupMemberList.size}人成团，时间有限，赶快去呼唤小伙伴们加入吧
        </c:if>
        <c:if test="${group.status==3}">
          组团成功啦，恭喜恭喜！不过还有参团名额呢，快去告诉朋友们吧
        </c:if>
        <c:if test="${group.status==5}">
          组团失败，不要气馁，自己开个团试试看~~
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          哎呀，商品太热销，已经抢完啦
        </c:if>
      </c:if>

    </div>
    <a href="javascript:void(0)" class="btn">
      <c:if test="${flag==0}">
        <c:if test="${group.status==1||group.status==3}">
          参团
        </c:if>
        <c:if test="${group.status==5}">
          组团失败
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          活动结束
        </c:if>
      </c:if>
      <c:if test="${flag==1}">
        <c:if test="${group.status==1}">
          还差${group.groupProduct.memberAmount-group.groupMemberList.size}人成团，去分享
        </c:if>
        <c:if test="${group.status==3}">
          组团成功，去分享
        </c:if>
        <c:if test="${group.status==5}">
          组团失败
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          活动结束
        </c:if>
      </c:if>
      <c:if test="${flag==2}">
        <c:if test="${group.status==1}">
          参团
        </c:if>
        <c:if test="${group.status==3}">
          参团
        </c:if>
        <c:if test="${group.status==5}">
          组团失败
        </c:if>
        <c:if test="${group.groupProduct.status==0}">
          活动结束
        </c:if>
      </c:if>
    </a>
  </div>
  <!--成团信息-->
  <div class="new-page ae">
    <ul class="ae">
      <li>
        <strong><img src="<c:url value="/scripts/wap/upload/fx-x-1.png"/>" class="page-pic"></strong>
        <span>团长
          <c:forEach items="${group.getGroupMemberList()}" var="member">
        <c:if test="${member.level==0}">
        ${fn:substring(member.user.getUsername(), 0,3 )}****${fn:substring(member.user.getUsername(),7,11)}
        </c:if>
          </c:forEach></span>

        <span>${fn:substring(group.createDateTime,0 ,11 )}</span>
        <span>${fn:substring(group.createDateTime,12 ,19 )}开团</span>
      </li>
      <c:forEach items="${group.getGroupMemberList()}" var="member">
        <c:if test="${member.level!=0}">
      <li>
        <strong><img src="<c:url value="/scripts/wap/upload/fx-x-1.png"/>" class="page-pic"></strong>
        <span>团员${fn:substring(member.user.getUsername(), 0,3 )}****${fn:substring(member.user.getUsername(),7,11)}</span>
        <span>${fn:substring(group.createDateTime,0 ,11 )}</span>
        <span>${fn:substring(group.createDateTime,12 ,19 )}开团</span>
      </li>
        </c:if>
      </c:forEach>
    </ul>
  </div>
  <!--拼团玩法-->
  <div class="method ae">
    <div class="met-head ae">
      <span>拼团玩法</span>
      <span><a href="<c:url value="/product/playDetails"/>">查看详情<i class="met-icon"></i></a></span>
    </div>
    <div class="met-footer ae">
      <ul class="ae">
        <c:if test="${flag==1&&group.status==1}">
        <li>
        <p><strong>1</strong></p>
        <p>选择心仪商品</p>
       </li>
        <li >
          <p><strong>2</strong></p>
          <p>支付开团或参团</p>
        </li>
        <li class="active">
          <p><strong>3</strong></p>
          <p>招募团员</p>
        </li>
        <li class="hover">
          <p><strong>4</strong></p>
          <p>达到人数组团成功</p>
        </li>
          </c:if>
        <c:if test="${group.status==3}">
          <li>
          <p><strong>1</strong></p>
          <p>选择心仪商品</p>
          </li>
          <li>
            <p><strong>2</strong></p>
            <p>参团</p>
          </li>
          <li>
            <p><strong>3</strong></p>
            <p>招募团员</p>
          </li>
          <li class="active">
            <p><strong>4</strong></p>
            <p>达到人数组团成功</p>
          </li>
        </c:if>
        <c:if test="${flag==0&&group.status==1}">
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
        </c:if>
        <c:if test="${flag==2&&group.status==1}">
          <li>
            <p><strong>1</strong></p>
            <p>选择心仪商品</p>
          </li>
          <li>
            <p><strong>2</strong></p>
            <p>支付开团或参团</p>
          </li>
          <li  class="active">
            <p><strong>3</strong></p>
            <p>招募团员</p>
          </li>
          <li class="hover">
            <p><strong>4</strong></p>
            <p>达到人数组团成功</p>
          </li>
        </c:if>
        <c:if test="${group.status==5}">
          <li>
            <p><strong>1</strong></p>
            <p>选择心仪商品</p>
          </li>
          <li>
            <p><strong>2</strong></p>
            <p>支付开团或参团</p>
          </li>
          <li  class="active">
            <p><strong>3</strong></p>
            <p>招募团员</p>
          </li>
          <li class="hover">
            <p><strong>4</strong></p>
            <p>达到人数组团成功</p>
          </li>
        </c:if>
      </ul>
    </div>
  </div>
</div>
<div class="login-reg">
  <a href="#login" class="btn-login" title="登录">登&nbsp;&nbsp;&nbsp;&nbsp;录</a>
  <a href="#reg" class="btn-reg">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
</div>
<!--//End--login-reg-->
<footer class="bd footer">
  <div class="bd info">
    <a class="icon"></a>
    <div class="txt">中&nbsp;&nbsp;国&nbsp;&nbsp;非&nbsp;&nbsp;遗&nbsp;&nbsp;电&nbsp;&nbsp;商&nbsp;&nbsp;平&nbsp;&nbsp;台</div>
    <div class="wechat"></div>
    <div class="txt">关注微信公众号</div>
    <div class="txt">领取超值代金券</div>
  </div>
  <div class="bd copyright">京ICP备15032511号-1</div>
</footer>
<!--//End--footer-->
<!--悬浮订单-->
<div class="met-nav ae">
  <a href="<c:url value="/tuan.do"/>"><p><i class="met-1con m-icon"></i></p><p>团购首页</p></a>
  <a href="<c:url value="/person/myGroup.do"/>"><p><i class="met-2con m-icon"></i></p><p>我的团</p></a>
  <a href="<c:url value="/person/myPurchaseOrder.do"/>"><p><i class="met-3con m-icon"></i></p><p>我的订单</p></a>
  <a href="<c:url value="/person/personInfoView.do"/>"><p><i class="met-4con m-icon"></i></p><p>个人中心</p></a>
</div>
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