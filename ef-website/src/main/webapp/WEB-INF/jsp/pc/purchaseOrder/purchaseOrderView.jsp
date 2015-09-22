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
        <c:if test="${!empty purchaseOrderDelivery}">
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">物流信息</dt>
          <dd class="od-id">
            <p >物流方式：<span>普通快递</span></p>
            <p>物流公司：<span><ming800:status name="logisticsCompany" dataType="PurchaseOrderDelivery.logisticsCompany" checkedValue="${purchaseOrderDelivery.logisticsCompany}" type="normal"/></span></p>
            <p>运单号码：<span>${purchaseOrderDelivery.serial}</span></p>
            <p style="cursor: pointer" id="act-q"> 物流查看：</p></li>
            <div class="list-express" style="display: none; margin-left: 30px;">
              <iframe id="kuaidi100" name="kuaidi100" src="${content}" width="600" height="380" marginwidth="12" marginheight="10" hspace="11" vspace="10" frameborder="0" scrolling="no"></iframe>
            </div>
          </dd>
        </dl>
        </c:if>
        <dl class="orderid-mashup bd-top">
          <dt class="orderid">商品信息</dt>
          <dd class="od-id">
            <c:forEach  items="${order.purchaseOrderProductList}" var="op">
            <table class="item-bg">
              <tr>
                <td class="commodity_info1">
                  <ul class="commodity_info-1">
                    <li class="l1 informala"><a href="#" style="outline: none"><img src="http://pro.efeiyi.com/${op.productModel.productModel_url}@!product-icon"></a></li>
                  </ul>
                </td>
                <td class="commodity_price_unit1  price9">${op.productModel.product.name}</td>
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
            <p>收货地址：<span>${order.consumerAddress.province.name} ${order.consumerAddress.city.name}${order.consumerAddress.details}</span></p>
            <p>收货人姓名：<span>${order.consumerAddress.consignee}</span></p>
            <p>联系电话：<span>${order.consumerAddress.phone}</span></p>

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
<script>
  $(function(){
    $('#act-q').mouseenter(function(){
      $(this).siblings('.list-express').slideToggle();

    })
  })

</script>
</div>
<!-- //End--header-->

<!-- //End--footer-->
</div>
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="<c:url value="/scripts/js/jquery.min.js"/>"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
<script src="<c:url value="/scripts/js/amazeui.ie8polyfill.min.js"/>"></script>
<![endif]-->
<script src="<c:url value="/scripts/js/amazeui.min.js"/>"></script>
<script src="<c:url value="/scripts/js/system.js"/>"></script>
<%--<script>--%>
  <%--$(document).ready(function(){--%>
    <%--$.ajax({--%>
     <%--type:'get',--%>
      <%--async:'false',--%>
      <%--url:'http://www.kuaidi100.com/applyurl?key="f8e96a50d49ef863"&com="yunda"&nu="1700173247399"',--%>
      <%--dataType:'jsonp',--%>
      <%--error:function(data){--%>
        <%--console.log(data);--%>
      <%--},--%>
      <%--success: function(data){--%>
<%--//        document.getElementById("kuaidi100").src = data;--%>
<%--//        console.log("test");--%>
<%--//        console.log(typeof data);--%>
        <%--$("#kuaidi100").attr("src",data);--%>
<%--//        $("iframe[name='kuaidi100']").attr("src",data);--%>
<%--//        var rowHtml = "";--%>
<%--//        var obj = data.data;--%>
<%--//        for(var i = 0; i< obj.length;i++){--%>
<%--//            rowHtml+="<p><span class='active2'>"+obj[i].time +"</span><span>"+obj[i].context+"</span></p>";--%>
<%--//        }--%>
<%--//        $("#wl").append(rowHtml);--%>

    <%--},--%>
    <%--});--%>

  <%--})--%>
<%--</script>--%>
</body>
</html>