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
<body>
<%--${redirect}--%>


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
                        //跳转到查看支付是否成功
                        <c:if test="${not empty order.callback}">
                        window.location.href = "http://${order.callback}";
                        </c:if>
                        <c:if test="${empty order.callback}">
                        window.location.href = "http://i.efeiyi.com/order/myEfeiyi/view/${orderId}";
                        </c:if>
                    }
                    else {
                        <c:if test="${not empty order.callback}">
                        window.location.href = "http://${order.callback}";
                        </c:if>
                        <c:if test="${empty order.callback}">
                        window.location.href = "http://i.efeiyi.com/order/myEfeiyi/view/${orderId}";
                        </c:if>
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

</body>
</html>
