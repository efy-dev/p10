<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>查看收货订单信息</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>
  <link rel="icon" type="image/png" href="assets/i/favicon.png">
  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="ico" sizes="192x192" href="assets/i/app-icon72x72@2x.png">
  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="assets/i/app-icon72x72@2x.png">
  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/amazeui.min.css">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/my-efeiyi2.css">
  <link type="text/css" rel="stylesheet" href="/scripts/assets/css/app.css">
</head>
<body>

<!-- //End--header-->
<!--content-->

    <div class="layout-col">
      <div class="mt wh1">
        <div class="extra-l">
          <strong>订单信息</strong>

        </div>

      </div>
      <div class="orderinfo">
        <dl class="orderid-mashup">
          <dt class="orderid">订单</dt>
          <dd class="od-id">
            <p >订单号: <span>${order.serial}</span></p>
            <p>订单金额：<span>${order.total}</span></p>
            <p>订单状态：<span>${order.orderStatus}</span></p>
          </dd>
        </dl>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">物流信息</dt>
          <dd class="od-id">
            <p >物流方式：<span>普通快递</span></p>
            <p>物流公司：<span>圆通快递</span></p>
            <p>运单号码：<span>0987654321</span></p>
            <ul class="strong-1">
              <li class="strong">物流跟踪：</li>
              <li class="strong">
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>
                <p><span class="active2">2015-08-01</span><span>17:32:19</span><span>北京西城区圆通物流公司</span><span>已收件</span></p>

              </li>
            </ul>
          </dd>
        </dl>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">商品信息</dt>
          <dd class="od-id">
            <table class="item-bg">
              <tr>
                <td class="commodity_info1">
                  <ul class="commodity_info-1">
                    <li class="l1 informala"><a href="#" style="outline: none"><img src="/scripts/assets/images/img-tx2.png"></a></li>
                  </ul>
                </td>
                <td class="commodity_price_unit1  price9">【包快递】韩国正品三重仿伪BB霜 Lohashill遮瑕裸妆BB霜50ML </td>
                <td class="commodity_quantity  amount">x<span>100</span></td>
                <td class="commodity_price  price8">￥189.00</td>
              </tr>
            </table>
          </dd>
        </dl>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">收货信息</dt>
          <dd class="od-id">
            <p >配送地址：<span>${order.consumerAddress}</span></p>
            <p>收货地址：<span>${order.consumerAddress}</span></p>
            <p>收货人姓名：<span>${order.consumerAddress.consumer.name}</span></p>
            <p>联系电话：<span>${order.consumerAddress.consumer.phone}</span></p>

          </dd>
        </dl>
        <dl class="orderid-mashup bd-top item-list5">
          <dt class="orderid">支付及配送方式</dt>
          <dd class="od-id">
            <p >支付方式：<span>支付宝</span></p>
            <p>支付备注：<span>想强调的话</span></p>
            <p>配送方式：<span>普通快递</span></p>
            <p>运费：<span>免运费</span></p>
          </dd>
        </dl>
      </div>
    </div>
  </div>
</div>
<!-- //End--header-->

<!-- //End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/scripts/assets/js/amazeui.min.js"></script>
<script src="/scripts/assets/js/system.js"></script>
<!--<script type="text/javascript">
$(window).scroll(function(){
    if($(this).scrollTop()>100){
        $('.slider-menu ul').css({'position':'fixed'})
    }
})
</script>-->
</body>
</html>