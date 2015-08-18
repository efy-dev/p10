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
  <title>个人中心</title>
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
  <link type="text/css" rel="stylesheet" href="../../../../scripts/assets/css/amazeui.min.css">
  <link type="text/css" rel="stylesheet" href="../../../../scripts/assets/css/my-efeiyi2.css">
  <link type="text/css" rel="stylesheet" href="../../../../scripts/assets/css/app.css">
</head>

<body>

<!-- //End--header-->
<!--content-->

    <div class="layout-col">
      <div class="mt wh1">
        <div class="extra-l">
          <strong>我的订单</strong>
          <a href="#">待付款(<span>3</span>)</a>
          <a href="#">待收货</a>
          <a href="#">待评价</a>
          <a href="#">已完成</a>
          <a href="#">订单回收站</a>
        </div>
        <div class="extra-r">
          <a href="">合并</a>
          <a href="">付款</a>
        </div>
      </div>
      <!-- //End--mt-->
      <div class="title wh1">
        <table>
          <tr>
            <th width="237">商品名称</th>
            <th width="174">单价</th>
            <th width="107">数量</th>
            <th width="100">总计</th>
            <th width="130">交易状态</th>
            <th width="139">操作</th>
          </tr>
        </table>
      </div>
      <!-- //End--title-->
      <div class="list-pro wh1">
        <table>
          <tr>
            <th colspan="6">
              <span>2015-08-02 18:29:30</span>
              <span>订单号：<strong>1234567890</strong></span>
              <span>瓷器之都</span>
            </th>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130">待付款</td>
            <td width="139">
              <p><a href="#">付款</a></p>
              <p><a href="/order/view/100000000001">查看</a></p>
              <p><a href="#">取消订单</a></p>
            </td>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130">待付款</td>
            <td width="139">
              <p><a href="#">付款</a></p>
              <p><a href="#">查看</a></p>
              <p><a href="#">取消订单</a></p>
            </td>
          </tr>
        </table>
      </div>
      <!-- //End--two-->
      <div class="list-pro wh1">
        <table>
          <tr>
            <th colspan="6">
              <span>2015-08-02 18:29:30</span>
              <span>订单号：<strong>1234567890</strong></span>
              <span>瓷器之都</span>
            </th>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="<c:url value="../../../../scripts/assets/images/img-tx2.png"/>" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130" rowspan='2' style="border-left:1px solid #ccc;">
              <p><a href="#">待收货</a></p>
              <p><a href="#">订单跟踪</a></p>
            </td>
            <td width="139" rowspan='2' style="border-left:1px solid #ccc;">
              <p><a href="#">查看</a></p>
              <p><a href="#">再次购买</a></p>
            </td>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
          </tr>
        </table>
      </div>
      <!-- //End--3-->
      <div class="list-pro wh1">
        <table>
          <tr>
            <th colspan="6">
              <span>2015-08-02 18:29:30</span>
              <span>订单号：<strong>1234567890</strong></span>
              <span>瓷器之都</span>
            </th>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130">
              <P>已完成</P>
              <P ><a>未评价</a></P>
            </td>
            <td width="139">
              <p><a href="#">查看</a></p>
              <p><a href="#">删除</a></p>
              <p><a href="#">追加评价</a></p>
            </td>
          </tr>
          <tr>
            <td width="237" >
              <div class="cols1">
                <img src="../../../../scripts/assets/images/img-tx2.png" alt=""/>
                <div class="info">
                  <p><a href="#">瓷器</a></p>
                  <p><a href="#">商品名称</a></p>

                </div>
              </div>
            </td>
            <td width="174">￥189.00</td>
            <td width="107">x<span>1</span></td>
            <td width="100">在线支付</td>
            <td width="130">
              <P>已完成</P>
              <P>已评价</P>
            </td>
            <td width="139">
              <p><a href="#">查看</a></p>
              <p><a href="#">删除</a></p>
              <p><a href="#">追加评价</a></p>
            </td>
          </tr>
        </table>
      </div>
    </div>
</div>
</div>
<!-- //End--footer-->
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="../../../../scripts/assets/js/jquery.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="../../../../scripts/assets/http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="../../../../scripts/assets/http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="../../../../scripts/assets/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="../../../../scripts/assets/js/amazeui.min.js"></script>
<script src="../../../../scripts/assets/js/system.js"></script>





</body>
</html>
