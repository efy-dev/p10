<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/4/8
  Time: 12:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<div>
<p>${date}</p>
<p>今天注册人数：${registerCount}</p>
<p>今天订单数量：${purchaseOrderCount}</p>
<p>今天支付成功记录：${purchaserPaymentCount}</p>
<p>${yesterday}</p>
<p>昨天注册人数：${yesterdayRegisterCount}</p>
<p>昨天订单数量：${yesterdayPurchaseOrderCount}</p>
<p>昨天支付成功记录：${yesterdayPurchasePaymentCount}</p>
</div>
<script type="text/javascript">
  $().ready(function(){
    $(".nav-new").hide();
    $(".footernew").hide();
    $(".header-new").hide();
    $(".items").hide();
  })
  </script>
</body>

</html>
