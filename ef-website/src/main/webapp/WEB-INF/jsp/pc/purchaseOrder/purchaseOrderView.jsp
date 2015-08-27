<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="ming800" uri="http://java.ming800.com/taglib" %>
<!doctype html>
<html class="no-js">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>查看收货订单信息</title>
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
            <p>订单状态：<span><ming800:status name="orderStatus" dataType="PurchaseOrder.orderStatus" checkedValue="${order.orderStatus}" type="normal"/></span></p>
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
              <li class="strong" id="wl">
              </li>
            </ul>
          </dd>
        </dl>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">商品信息</dt>
          <dd class="od-id">
            <c:forEach  items="${order.purchaseOrderProductList}" var="op">
            <table class="item-bg">
              <tr>
                <td class="commodity_info1">
                  <ul class="commodity_info-1">
                    <li class="l1 informala"><a href="#" style="outline: none"><img src="<c:url value="${op.productModel.product.picture_url}"/>"></a></li>
                  </ul>
                </td>
                <td class="commodity_price_unit1  price9">${op.productModel.product.category.name}</td>
                <td class="commodity_quantity  amount">x<span>${op.purchaseAmount}</span></td>
                <td class="commodity_price  price8">￥${op.purchasePrice * op.purchaseAmount}</td>
              </tr>
            </table>
            </c:forEach>
          </dd>
        </dl>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">收货信息</dt>
          <dd class="od-id">
            <%--<p >配送地址：<span>${order.consumerAddress}</span></p>--%>
            <p>收货地址：<span>${order.consumerAddress.province.name} ${order.consumerAddress.city.name}</span></p>
            <p>收货人姓名：<span>${order.consumerAddress.consumer.name}</span></p>
            <p>联系电话：<span>${order.consumerAddress.consumer.phone}</span></p>

          </dd>
        </dl>
        <dl class="orderid-mashup bd-top item-list5">
          <dt class="orderid">支付及配送方式</dt>
          <dd class="od-id">
            <p >支付方式：<span><ming800:status name="payWay" dataType="PurchaseOrder.payWay" checkedValue="${order.payWay}" type="normal"/></span></p>
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
<script src="<c:url value="/scripts/assets/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/assets/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/assets/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/assets/js/system.js"/>"></script>
<script>
  $(document).ready(function(){
    $.ajax({
     type:'post',
      async:'false',
      url:'<c:url value="http://api.kuaidi100.com/api?id=f8e96a50d49ef863&com=guotongkuaidi&nu=2577435025&show=0&muti=1&order=desc"/>',
      dataType:'jsonp',
      success: function(data){
        var rowHtml = "";
        var obj = data.data;
        for(var i = 0; i< obj.length;i++){
            rowHtml+="<p><span class='active2'>"+obj[i].time +"</span><span>"+obj[i].context+"</span></p>";
        }
        $("#wl").append(rowHtml);
    },
    });

  })
</script>
</body>
</html>