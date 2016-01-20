<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/3
  Time: 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body style="z-index: -99999">
<%--${redirect}--%>
<%--<div class="packet ae">--%>
<%--<div class="efeiyi-lod ae">--%>
<%--<a class="efiyi-logo"></a>--%>
<%--<a class="eifyi-ld">--%>
<%--<div class="ld-img"><img src="<c:url value="/scripts/wap/images/jazq2.gif"/>"></div>--%>
<%--</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--<a id="showGiftCard" onclick="callpay();"--%>
<%--style=" width: 100%; float:left;text-align:center;margin-top: 10px;padding: 1rem 0.9rem;font-size: 1rem;border: 1px solid #ccc;background: #000;color: #fff;">--%>
<%--发起支付--%>
<%--</a>--%>

<script>
    function jsApiCall() {
        WeixinJSBridge.invoke(
                'getBrandWCPayRequest',
                {
                    "appId": "${appId}",     //公众号名称，由商户传入
                    "timeStamp": "${timeStamp}",         //时间戳，自1970年以来的秒数
                    "nonceStr": "${nonceStr}", //随机串
                    "package": "${pk}",
                    "signType": "${signType}",         //微信签名方式：
                    "paySign": "${paySign}"//微信签名
                },
                function (res) {
//                    alert(res.err_code + res.err.desc + res.err_msg);
                    if (res.err_msg == "get_brand_wcpay_request:ok") {//支付成功

                        <c:set var="payAmount" value="0"  scope="page"/>
                        <c:forEach items="${order.purchaseOrderPaymentList}" var="payment">
                        <c:set var="payAmount" value="${payAmount = payAmount + payment.paymentAmount}" scope="page"/>
                        </c:forEach>
                        //加入GA追踪
                        ga('send', 'event', {
                            'eventCategory': '支付成功',
                            'eventAction': '微信',
                            'eventLabel': 'wap',
                            'eventValue': parseInt(${payAmount * 100}),
                            'hitCallback': function () {
//                              //跳转到查看支付是否成功
                                <c:if test="${order.orderType=='3'}">
                                window.location.href = "http://www.efeiyi.com/giftReceive/${orderId}";
                                </c:if>
                                <c:if test="${not empty order.callback && order.orderType!='3'}">
                                window.location.href = "http://${order.callback}";
                                </c:if>
                                <c:if test="${empty order.callback && order.orderType!='3'}">
                                window.location.href = "http://www2.efeiyi.com/sharePage/productShare/${orderId}";
                                </c:if>
                            }
                        });
                    }
                    else {
                        window.location.href = "http://i.efeiyi.com/order/myEfeiyi/view/${orderId}";
                    }
                }
        );
    }

    function callpay() {
        if (typeof WeixinJSBridge == "undefined") {
            if (document.addEventListener) {
                document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
            } else if (document.attachEvent) {
                document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
            }
        } else {
            jsApiCall();
        }
    }
</script>
<script>callpay();</script>
<script type="text/javascript">
    var _mvq = window._mvq || [];
    window._mvq = _mvq;
    _mvq.push(['$setAccount', 'm-197303-0']);

    _mvq.push(['$setGeneral', 'ordercreate', '', /*用户名*/ '', /*用户id*/ '']);
    _mvq.push(['$logConversion']);
    _mvq.push(['$addOrder', /*订单号*/ '${order.serial}', /*订单金额*/ '${order.total-order.getOrderPayMoney()}']);
    _mvq.push(['$addItem', /*订单号*/ '', /*商品id*/ '', /*商品名称*/ '', /*商品价格*/ '', /*商品数量*/ '', /*商品页url*/ '', /*商品页图片url*/ '']);
    _mvq.push(['$logData']);
</script>

</body>
</html>
