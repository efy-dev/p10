<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>个人中心</title>
  <script>
    function func(o){
      window.location.href="<c:url value="/order/myEfeiyi/list.do?status="/>"+o;
    }
  </script>
</head>
<body>

<!-- //End--header-->
<!--content-->

<div class="layout-col">
  <div class="mt wh1">
    <div class="extra-l">
      <strong>我的订单</strong>
      <a href="#" onclick="func(1)">待付款</a>
      <a href="#" onclick="func(5)">待收货</a>
      <a href="#" onclick="func(13)">已完成</a>
      <a href="#" onclick="func(17)">订单回收站</a>
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
      <tr style="border-top: 1px solid #ccc">
        <td colspan="6">
          <div class="mt-null">
            <p>目前还没有订单，现在开启您的购物之旅吧！</p>
            <ul>
            </ul>
          </div>
        </td>
      </tr>
    </table>
  </div>
  <!-- //End--title-->
</div>
</div>
</div>
<!--content-->
<!-- //End--footer-->


<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/assets/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="<c:url value="/scripts/assets/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/assets/js/system.js"/>"></script>
</body>
</html>