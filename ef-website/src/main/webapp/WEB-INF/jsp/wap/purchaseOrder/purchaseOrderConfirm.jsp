<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
  <title>确认订单</title>
  <style>
    .paymentActive{
      border: 2px red;
    }
  </style>
</head>
<body>
<!--//End--header-->
<article class="bd shop-cart">
  <div class="bd cart-order">
    <div class="bd order-address">
      <c:forEach items="${addressList}" var="address">
      <c:if test="${address.status=='2'}">
      <a href="#btn-edit-addres" class="btn-edit-addres">
        <p class="title"><span>${address.consignee}</span><span>${address.phone}</span></p>
        <p class="txt">${address.province.name}${address.details}</p>
        <a href="#arrow-right" class="arrow-right"></a>
      </a>
      </c:if>
      </c:forEach>
    </div>
    <c:forEach items="${tenantList}" var="tenant">
      <div class="bd order-list">
        <div class="title">${tenant.name}</div>
        <ul class="ul-list">
          <c:forEach items="${productMap.get(tenant.id)}" var="product">
            <c:if test="${product.isChoose==1}">
              <li>
                <img class="img" src="${product.productModel.product.picture_url}" alt="">
                <div class="bd info">
                  <p class="text">${product.productModel.product.name}</p>
                  <p class="price"><em>￥</em><span>${product.productModel.price}</span></p>
                  <p class="num"><i class="iocn-x"></i><strong>${product.amount}</strong></p>
                </div>
              </li>
            </c:if>
          </c:forEach>
        </ul>
        <div class="bd ask"><textarea name="message" id="${tenant.id}Message" cols="30" rows="4" placeholder="给卖家留言"></textarea></div>
      </div>
    </c:forEach>

    <!-- //End--order-list-->
    <div class="bd order-total">
      <p><strong>优惠券</strong><span class="btn-coupons">2张券可用</span><a href="#arrow-right" class="arrow-right"></a></p>
      <p><strong>商品金额</strong><span><em>￥</em>${cart.totalPrice.intValue()}</span></p>
      <p><strong class="grey">返现</strong><span><em>￥</em>0</span></p>
      <p><strong>运费</strong><span><em>￥</em>0</span></p>
    </div>
    <!-- //End--order-total-->
    <div class="bd cart-pay">
      <div class="title">请选择支付方式</div>
      <ul class="ul-list">
        <li><a id="zhifubao" onclick="zhifubao(this)" title="支付宝"><i class="icon icon-zfb"></i>支 付 宝</a></li>
        <li><a id="weixin" onclick="weixin(this)" title="微信支付"><i class="icon icon-wechat"></i>微 信 支 付</a></li>
      </ul>
    </div>
  </div>
  <!-- //End--cart-order-->
  <div class="bd payment-total-bar">
    <span class="txt">共${purchaseOrder.purchaseOrderProductList.size()}件，总计付款${cart.totalPrice.intValue()}元</span>
    <a onclick="submitOrder('${purchaseOrder.id}')" class="btn-right">提交订单</a>
  </div>
</article>


<!--Start--弹出地址-->
<div id="order-address" class="alert-delete" style="display:none;">
  <div class="bd cart-address">
    <div class="bd list-adress">
      <ul class="ul-list">
        <c:forEach items="${addressList}" var="address">

          <li>
            <p class="bd title">${address.consignee}  ${address.phone}</p>
            <p class="bd des">${address.province.name}${address.details}</p>
            <p class="bd btns">
              <input type="radio" name="address" id="address" onclick="chooseAddress('${address.id}')">
            </p>
          </li>
        </c:forEach>
      </ul>
      <div class="bd">
        <a href="#" class="cart-btn" title="确定">确定</a>
      </div>
    </div>
  </div>
  <div class="overbg"></div>
</div>
<!--//End--弹出地址-->

<!--Start--弹出地址-->
<div id="order-total" class="alert-delete" style="display:none;">
  <div class="bd cart-coupons">
    <div class="title">
      <h2>优惠券</h2>
    </div>
    <!--//ENd-->
    <ul class="ul-list">
      <li>
        <input type="checkbox" name="" id="cbox1">
        <p>满500减50</p>
        <p>有效期：2012-09-09至2013-09-09</p>
        <p>适用范围：全网通用</p>
      </li>
      <li>
        <input type="checkbox" name="" id="cbox2">
        <p>满500减50</p>
        <p>有效期：2012-09-09至2013-09-09</p>
        <p>适用范围：全网通用</p>
      </li>
      <li>
        <input type="checkbox" name="" id="cbox3">
        <p>满500减50</p>
        <p>有效期：2012-09-09至2013-09-09</p>
        <p>适用范围：全网通用</p>
      </li>
      <li>
        <input type="checkbox" name="" id="cbox4">
        <p>满500减50</p>
        <p>有效期：2012-09-09至2013-09-09</p>
        <p>适用范围：全网通用</p>
      </li>
    </ul>

    <div class="bd">
      <a href="#确定" class="cart-btn" title="确定">确定</a>
    </div>
  </div>
  <div class="overbg"></div>
</div>

<script>

  var payment = "1";
  var consumerAddress = "";

  function zhifubao(element) {
    $("#zhifubao").attr("style", "border:2px solid red");
    $("#weixin").attr("style", "");
//    $(element).attr("class", "alipay wechat-active");
//    $("#weixin").attr("class", "alipay");
//    $("#weixin").find("i").remove();
//    $(element).append('<i class="triangle" style="display: block"></i>')
    payment = "1";
  }

  function weixin(element) {
//    $(element).attr("class", "alipay wechat-active");
    $("#weixin").attr("style", "border:2px solid red");
    $("#zhifubao").attr("style", "");

//    $("#weixin").attr("class", "paymentActive");
//    $("#zhifubao").find("i").remove();
//    $(element).append('<i class="triangle" style="display: block"></i>')
    payment = "3";
  }
  function submitOrder(orderId) {
    var messageObject = new Object();
    $("input[name=message]").each(function () {
      messageObject[$(this).attr("id")] = $(this).val();
    })
    var message = "";
    for (var key in messageObject) {
      message += key + ":" + messageObject[key] + ";"
    }

    if (consumerAddress == "") {
      showAlert("提示", "请选择一个收货地址！");
    } else {
      var url = "<c:url value="/order/confirm/"/>";
      url += orderId + "?payment=" + payment + "&address=" + consumerAddress + "&message=" + message;
      window.location.href = url;
    }
  }


  $(function () {
    $('.clearing-site span a').click(function () {
      $(this).siblings('.active-pop').show();
      $('.clase, .sh-bg').click(function () {
        $(this).parents('.active-pop').hide();
      })
      return false;
    })

    //网页加载的时候把城市的数据取回来
    ajaxRequest("<c:url value="/myEfeiyi/address/listProvince.do"/>", {}, function (data) {
      var out = '<option value="">请选择</option>';
      for (var i = 0; i < data.length; i++) {
        out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
      }
      $("#province").html(out);
    }, function () {
    }, "post")

  })

  function provinceChange(element) {
    var provinceId = $(element).val();
    ajaxRequest("<c:url value="/myEfeiyi/address/listCity.do"/>", {provinceId: provinceId}, function (data) {
      var out = '<option value="">请选择</option>';
      for (var i = 0; i < data.length; i++) {
        out += '<option value="' + data[i]["id"] + '">' + data[i]["name"] + '</option>';
      }
      $("#city").html(out);
    }, function () {
    }, "post")
  }

  function newAddress(it) {
    var out = ' <div class="page-default"> <span> <div id="' + (it.id) + '" class="default-text" name="addressItem" onclick="chooseAddress(this,\'' + it.id + '\')"> <strong>' + (it.consignee) + ' ' + (it.province.name) + '</strong> </a> </div> </span> <span>' + (it.consignee) + '</span> <span>' + (it.province.name) + '</span> <span>' + (it.city.name) + '</span> <span>' + (it.details) + '</span> <span>' + (it.phone) + '</span> </div>';
    return out;
  }

  function submitNewAddress() {
    var param = $("#newAddress").serialize();
    var success = function (data) {
      console.log(data)
      var html = newAddress(data);
      $("#address").append(html);
      $(".active-pop").hide();
    }
    ajaxRequest("<c:url value="/order/addAddress.do"/>", param, success, function () {
    }, "post")
  }

  function chooseAddress(addressId) {
    consumerAddress = addressId
    console.log(consumerAddress);
//    $("div[name=addressItem]").each(function () {
//      $(this).attr("class", "default-text");
//    })
//    $(element).attr("class", "default-text default-active")
  }


</script>
</body>
</html>