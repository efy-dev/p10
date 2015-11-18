<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/11/18 0018
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html class="no-js">
<head>
    <title>秒杀—即将开始</title>
</head>
<body>
<header class="am-header custom-header">
    <h1 class="am-header-title">抢购最便宜</h1>

    <div class="am-header-right am-header-nav">
        <a href="#chevron-right" class="chevron-right" id="menu">
            <i class="line"></i>
        </a>
    </div>
    <!-- //End--chevron-left-->
    <div class="menu-list">
        <ul class="bd">
            <li><a href="<c:url value="/miao/list"/>" title="首页">首页</a></li>
            <li><a href="http://i.efeiyi.com" title="个人中心">个&nbsp;人&nbsp;中&nbsp;心</a></li>
        </ul>
    </div>

</header>
<!--//End--header-->
<article class="seckill">
    <div class="bd time">
        <h1 class="bd" id="miaoStatus">距离本场秒杀开始还有</h1>

        <div class="des">
            <span class="items hour" id="time_h">00</span>
            <span class="items minute" id="time_m">00</span>
            <span class="items seconds" id="time_s">00</span>
        </div>
    </div>
    <!-- //End--time-->
    <div data-am-widget="slider" class="bd am-slider am-slider-a1" data-am-slider='{&quot;directionNav&quot;:false}'>
        <ul class="am-slides">
            <li><img src="http://pro.efeiyi.com/${productList.get(0).productModel.productModel_url}@!miao-product-view">
            </li>
        </ul>
    </div>
    <!--//End--am-slider-->
    <div class="bd price-buy">
        <div class="price">
            <p class="t1"><em>￥</em><strong>${productList.get(0).price}</strong>
                <del>￥${productList.get(0).productModel.price}</del>
            </p>
            <p class="t2">关注度：${productList.get(0).attentionAmount}</p>
        </div>
        <div class="btn-buy"><a href="<c:url value="/miao/${productList.get(0).id}"/>" title="查看商品" id="miaoBuy">查看商品</a></div>
    </div>
    <!--//End--price-buy-->
    <div class="bd t-title">
        <h3>秒杀预告</h3>
        <h4>锁定秒杀日，抢购最便宜</h4>
    </div>
    <!--//End--price-buy-->
    <div class="bd s-list">
        <c:forEach items="${productList}" begin="1" var="product">
            <div class="items">
                <img src="http://pro.efeiyi.com/${product.productModel.productModel_url}@!miao-product-list" width="134"
                     alt="">

                <div class="info">
                    <p class="t1"><fmt:formatDate value="${product.startDatetime}" pattern="MM月dd日 HH:mm:ss"/>开抢</p>

                    <p class="t2"><span>${product.productModel.name}</span></p>

                    <p class="t3">${product.productModel.product.subName}</p>

                    <p class="t4">
                        <em>￥</em><strong>${product.price}</strong>
                        <del>￥${product.productModel.price}</del>
                    </p>
                </div>
                <div class="divbtm">
                    <span>关注度：${product.attentionAmount}</span>
                    <a href="" title="查看商品" >查看商品</a>
                </div>
            </div>
        </c:forEach>
    </div>
    <!--//End--s-list-->
    <%--<div class="bd p-list">--%>
    <%--<h3>往期回顾</h3>--%>
    <%--<ul class="ul-list">--%>
    <%--<li>--%>
    <%--<a href="" title=""><img src="../shop2015/upload/seckill2.jpg" alt=""></a>--%>
    <%--<p class="t1">太极八卦砚</p>--%>
    <%--<p class="t2"><del>￥89.00</del><em>￥</em><strong>11</strong></p>--%>
    <%--<p class="t3">关注度：10000</p>--%>
    <%--<p class="t4">秒杀结束</p>--%>
    <%--</li>--%>
    <%--<li>--%>
    <%--<a href="" title=""><img src="../shop2015/upload/seckill2.jpg" alt=""></a>--%>
    <%--<p class="t1">太极八卦砚</p>--%>
    <%--<p class="t2"><del>￥89.00</del><em>￥</em><strong>11</strong></p>--%>
    <%--<p class="t3">关注度：10000</p>--%>
    <%--<p class="t4">秒杀结束</p>--%>
    <%--</li>--%>
    <%--<li>--%>
    <%--<a href="" title=""><img src="../shop2015/upload/seckill2.jpg" alt=""></a>--%>
    <%--<p class="t1">太极八卦砚</p>--%>
    <%--<p class="t2"><del>￥89.00</del><em>￥</em><strong>11</strong></p>--%>
    <%--<p class="t3">关注度：10000</p>--%>
    <%--<p class="t4">秒杀结束</p>--%>
    <%--</li>--%>
    <%--<li>--%>
    <%--<a href="" title=""><img src="../shop2015/upload/seckill2.jpg" alt=""></a>--%>
    <%--<p class="t1">太极八卦砚</p>--%>
    <%--<p class="t2"><del>￥89.00</del><em>￥</em><strong>11</strong></p>--%>
    <%--<p class="t3">关注度：10000</p>--%>
    <%--<p class="t4">秒杀结束</p>--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <!--//End--p-list-->
</article>

<script>
    $().ready(function () {
        show_time();
    })

    function timeEnd() {
        $("#miaoStatus").html("本场秒杀正火热进行中...");
        $("#miaoBuy").html("立即抢购");
    }

    function show_time() {
        var time_start = new Date().getTime(); //设定当前时间
        var time_end = new Date("<fmt:formatDate value="${productList.get(0).startDatetime}" pattern="20YY/MM/dd HH:mm:ss"/>").getTime(); //设定目标时间
        // 计算时间差
        var time_distance = time_end - time_start;

        if (time_distance < 0) {
            timeEnd();
        } else {


            // 时
            var int_hour = Math.floor(time_distance / 3600000)
            time_distance -= int_hour * 3600000;
            // 分
            var int_minute = Math.floor(time_distance / 60000)
            time_distance -= int_minute * 60000;
            // 秒
            var int_second = Math.floor(time_distance / 1000)
            // 时分秒为单数时、前面加零
            if (int_hour < 10) {
                int_hour = "0" + int_hour;
            }
            if (int_minute < 10) {
                int_minute = "0" + int_minute;
            }
            if (int_second < 10) {
                int_second = "0" + int_second;
            }
            // 显示时间
            $("#time_h").html(int_hour);
            $("#time_m").html(int_minute);
            $("#time_s").html(int_second);
            // 设置定时器
            setTimeout("show_time()", 1000);
        }
    }
</script>

</body>
</html>
